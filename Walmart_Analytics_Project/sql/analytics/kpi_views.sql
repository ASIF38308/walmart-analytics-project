/*
=========================================================
Project : Walmart Centralized Analytics Platform
File    : kpi_views.sql
Stage   : SQL Development / Analytical Layer - Step 2 (KPI Views)
Author  : Mohd Asif
Purpose : Reusable KPI views aligned to 06_KPI_Dictionary.md

SOURCE STRATEGY
----------------
These views query the OLTP source tables directly
(orders, order_items, returns, marketing_campaigns,
marketing_channels) rather than the star schema in
analytical_schema.sql. The star schema tables are
currently structural only - no ETL populates them yet.
Once that ETL exists, these views can be repointed at
fact_orders / fact_order_items / dim_campaign etc.
without changing their output contract.

SCOPE NOTE - READ BEFORE EXTENDING THIS FILE
----------------------------------------------
Per Data_Source_Assessment.md, every data source (DS-001
through DS-010) is still status "To Assess". Two sources
in particular are NOT available anywhere in this project:
  - DS-005 Finance Revenue Data
  - DS-006 Finance Marketing Cost Data
There is also no order-to-campaign linkage in `orders`,
so true Last-Touch Attribution (the methodology KPI-002
requires) cannot be computed.

This means several KPIs in 06_KPI_Dictionary.md cannot be
built as formally defined yet. Rather than approximate them
under their official names, they are documented as BLOCKED
at the bottom of this file. Do not build a "workaround" view
for a blocked KPI without updating the KPI Dictionary first -
see project rule: identify conflicts, don't silently redefine.
=========================================================
*/

USE walmart_analytics;


-- ============================================================
-- KPI-001 (interim) - Revenue, operational/transactional basis
-- ============================================================
-- Business purpose: Finance owns the official Revenue figure,
-- but Finance data doesn't exist in this dataset yet (DS-005).
-- This view reconstructs revenue from order + return data so
-- Sales/Product/Marketing can work with a directionally correct
-- number now. It must be reconciled against Finance's feed once
-- DS-005 is confirmed - it is NOT a substitute for KPI-001.
--
-- Logic: an order contributes 0 to revenue if cancelled. Returned
-- orders have their refund_amount netted off. LEFT JOIN to
-- returns is safe here (max 1 return row per order_id).
CREATE OR REPLACE VIEW vw_kpi_revenue_operational_daily AS
WITH order_level AS (
    SELECT
        o.order_id,
        o.order_date,
        o.order_status,
        o.total_amount,
        COALESCE(r.refund_amount, 0) AS refund_amount
    FROM orders o
    LEFT JOIN returns r
        ON r.order_id = o.order_id
)
SELECT
    order_date,
    SUM(CASE WHEN order_status <> 'Cancelled' THEN total_amount ELSE 0 END)               AS gross_order_value,
    SUM(CASE WHEN order_status <> 'Cancelled' THEN refund_amount ELSE 0 END)              AS total_refunds,
    SUM(CASE WHEN order_status <> 'Cancelled' THEN total_amount - refund_amount ELSE 0 END) AS recognized_revenue_operational
FROM order_level
GROUP BY order_date;


-- ============================================================
-- KPI-011 (interim) - Average Order Value, operational basis
-- ============================================================
-- Business purpose: same Finance-source caveat as above.
-- Business rule applied: a fully refunded order (refund_amount
-- >= total_amount) is excluded from the completed-order count,
-- per KPI-011 Business Rules (13.5).
-- NULLIF guards divide-by-zero on days with zero completed orders,
-- which would otherwise throw or silently return NULL differently
-- from an intentional 0 - we want an explicit NULL, not an error.
CREATE OR REPLACE VIEW vw_kpi_aov_operational_daily AS
WITH order_level AS (
    SELECT
        o.order_id,
        o.order_date,
        o.order_status,
        o.total_amount,
        COALESCE(r.refund_amount, 0) AS refund_amount
    FROM orders o
    LEFT JOIN returns r
        ON r.order_id = o.order_id
)
SELECT
    order_date,
    SUM(CASE WHEN order_status <> 'Cancelled' THEN total_amount - refund_amount ELSE 0 END) AS recognized_revenue_operational,
    SUM(CASE WHEN order_status <> 'Cancelled' AND refund_amount < total_amount THEN 1 ELSE 0 END) AS completed_orders,
    ROUND(
        SUM(CASE WHEN order_status <> 'Cancelled' THEN total_amount - refund_amount ELSE 0 END)
        / NULLIF(SUM(CASE WHEN order_status <> 'Cancelled' AND refund_amount < total_amount THEN 1 ELSE 0 END), 0)
    , 2) AS aov_operational
FROM order_level
GROUP BY order_date;


-- ============================================================
-- KPI-003 (Operational Spend/Budget) + KPI-009 (CTR)
-- + KPI-010 (Operational CPC) - one campaign-grain view
-- ============================================================
-- Business purpose: these three KPIs all sit at the same grain
-- (one row per campaign) and all use only platform-reported
-- fields that genuinely exist in marketing_campaigns - no
-- attribution or Finance dependency. Kept as one view rather
-- than three near-duplicate ones, consistent with this
-- project's "one living document, not many small ones" principle.
--
-- self_reported_conversion_rate_pct and self_reported_roas are
-- included because the columns exist in the source data and are
-- useful operationally, but they are explicitly NOT the
-- attribution-based KPI-004/005/008 figures the Dictionary
-- defines - they're the campaign's own reported numbers, not
-- independently verified via order-level Last-Touch Attribution.
-- Labeled accordingly so nobody mistakes one for the other.
CREATE OR REPLACE VIEW vw_kpi_campaign_performance AS
SELECT
    mc.campaign_id,
    mc.campaign_name,
    ch.channel_name,
    mc.campaign_type,
    mc.campaign_status,
    mc.start_date,
    mc.end_date,
    mc.budget,
    mc.spend                                                   AS operational_spend,
    mc.budget - mc.spend                                       AS budget_variance,
    ROUND(mc.spend / NULLIF(mc.budget, 0) * 100, 2)             AS budget_utilization_pct,
    mc.impressions,
    mc.clicks,
    ROUND(mc.clicks / NULLIF(mc.impressions, 0) * 100, 2)       AS ctr_pct,
    ROUND(mc.spend / NULLIF(mc.clicks, 0), 2)                   AS operational_cpc,
    mc.conversions                                              AS self_reported_conversions,
    mc.revenue_generated                                        AS self_reported_revenue,
    ROUND(mc.conversions / NULLIF(mc.clicks, 0) * 100, 2)        AS self_reported_conversion_rate_pct,
    ROUND(mc.revenue_generated / NULLIF(mc.spend, 0), 2)         AS self_reported_roas
FROM marketing_campaigns mc
JOIN marketing_channels ch
    ON ch.channel_id = mc.channel_id;


-- ============================================================
-- BLOCKED KPIs - documented, not built
-- ============================================================
-- KPI-002 Campaign-Attributed Sales
--   Blocked: no order-to-campaign link exists in `orders`, so
--   Last-Touch Attribution cannot be computed. See MOM_Marketing
--   _Requirements_Meeting.md / Data_Field_Mapping.md section 4-5,
--   which map campaign_id onto Transaction Data - that field is
--   not present in the actual `orders` table.
--
-- KPI-004 Operational ROAS / KPI-005 Financial ROAS
--   Blocked: numerator (Campaign-Attributed Sales) is blocked
--   above. Financial ROAS additionally needs DS-006 (Finance
--   Marketing Cost Data), which does not exist as a source.
--
-- KPI-006 ROI
--   Blocked by definition, not just data: status is "Under
--   Review" and the Dictionary explicitly states "Data/BI must
--   not independently decide what constitutes financial return
--   or investment" (8.14) pending Finance sign-off. Do not build
--   this view even once data exists, until KPI-006 status is
--   Agreed/Approved.
--
-- KPI-007 Customer Acquisition Cost (CAC)
--   Partially blocked: "new customer" count is computable from
--   customers.join_date / first order date, but the numerator
--   (Finance-Recognized Acquisition Cost, DS-006) does not exist.
--
-- KPI-008 Conversion Rate
--   Website-level: blocked, no web analytics source exists
--   (DS-007). Campaign-level: blocked under the strict definition
--   since "Campaign-Attributed Conversions" requires the same
--   attribution this file can't compute - see
--   self_reported_conversion_rate_pct above for the closest
--   available (non-attributed) proxy.
--
-- Next unblocking step for all of the above: confirm DS-005 and
-- DS-006 in Data_Source_Assessment.md, and decide (with Finance/
-- Marketing) whether Phase 1 Last-Touch Attribution will be
-- implemented via a synthetic join key or a real one.


-- ============================================================
-- Category Performance - supports Dashboard Step 5
-- ============================================================
-- Business purpose: department/brand grain revenue and unit
-- sales, used for the Product/Category dashboard chart. Built
-- after order_items/products data-quality fixes (see
-- 07_Business_Analysis_Findings.md, section 2).
CREATE OR REPLACE VIEW vw_category_performance AS
SELECT
    p.department,
    p.brand,
    SUM(oi.total_price) AS category_revenue,
    SUM(oi.quantity) AS units_sold,
    COUNT(DISTINCT oi.order_id) AS orders_count
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.department, p.brand;


-- ============================================================
-- Regional Performance - supports Dashboard Step 5
-- ============================================================
CREATE OR REPLACE VIEW vw_regional_performance AS
SELECT
    s.region,
    COUNT(DISTINCT s.store_id) AS store_count,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS gross_revenue,
    ROUND(SUM(o.total_amount) / COUNT(DISTINCT s.store_id), 2) AS revenue_per_store
FROM stores s
JOIN orders o ON o.store_id = s.store_id
WHERE o.order_status <> 'Cancelled'
GROUP BY s.region;


-- ============================================================
-- Returns Analysis - supports Dashboard Step 5
-- ============================================================
CREATE OR REPLACE VIEW vw_returns_by_reason AS
SELECT
    r.return_reason,
    COUNT(*) AS return_count,
    SUM(r.refund_amount) AS total_refunded,
    ROUND(AVG(r.refund_amount), 2) AS avg_refund
FROM returns r
GROUP BY r.return_reason;

CREATE OR REPLACE VIEW vw_returns_by_department AS
SELECT
    p.department,
    COUNT(DISTINCT oi.order_id) AS orders_with_product,
    COUNT(DISTINCT r.order_id) AS orders_returned,
    ROUND(COUNT(DISTINCT r.order_id) / COUNT(DISTINCT oi.order_id) * 100, 2) AS return_rate_pct
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
LEFT JOIN returns r ON r.order_id = oi.order_id
GROUP BY p.department;


-- ============================================================
-- KPI-002 (unblocked) - Campaign-Attributed Sales
-- ============================================================
-- Business purpose: now that order_campaign_attribution exists
-- (Last-Touch Attribution, per BRD scope - single-touch only,
-- multi-touch remains explicitly out of scope), this joins
-- attributed orders back to their recognized revenue.
-- CAVEAT: attribution itself is synthetically generated (see
-- generate_order_campaign_attribution.py) - it simulates a
-- realistic Last-Touch pattern but is not derived from real
-- click/session tracking. Treat as a working methodology
-- demonstration, not verified real-world attribution.
CREATE OR REPLACE VIEW vw_kpi_campaign_attributed_sales AS
WITH attributed_orders AS (
    SELECT
        oca.campaign_id,
        o.order_id,
        o.total_amount,
        COALESCE(r.refund_amount, 0) AS refund_amount,
        o.order_status
    FROM order_campaign_attribution oca
    JOIN orders o ON o.order_id = oca.order_id
    LEFT JOIN returns r ON r.order_id = o.order_id
)
SELECT
    campaign_id,
    COUNT(*) AS attributed_orders,
    SUM(CASE WHEN order_status <> 'Cancelled' THEN total_amount - refund_amount ELSE 0 END) AS campaign_attributed_sales
FROM attributed_orders
GROUP BY campaign_id;


-- ============================================================
-- KPI-004 (unblocked) - Operational ROAS
-- ============================================================
-- Business purpose: Campaign-Attributed Sales / Operational
-- Spend, now that the numerator is available. This REPLACES
-- self_reported_roas as the methodology-correct figure -
-- self_reported_roas stays in vw_kpi_campaign_performance for
-- comparison, but this view is the one that matches KPI-004's
-- actual definition.
CREATE OR REPLACE VIEW vw_kpi_operational_roas AS
SELECT
    mc.campaign_id,
    mc.campaign_name,
    ch.channel_name,
    mc.spend AS operational_spend,
    COALESCE(cas.campaign_attributed_sales, 0) AS campaign_attributed_sales,
    ROUND(COALESCE(cas.campaign_attributed_sales, 0) / NULLIF(mc.spend, 0), 2) AS operational_roas
FROM marketing_campaigns mc
JOIN marketing_channels ch ON ch.channel_id = mc.channel_id
LEFT JOIN vw_kpi_campaign_attributed_sales cas ON cas.campaign_id = mc.campaign_id;


-- ============================================================
-- KPI-008 (unblocked, campaign-level only) - Conversion Rate
-- ============================================================
-- Business purpose: attributed orders now stand in for
-- "Campaign-Attributed Conversions" per KPI-008's campaign-level
-- definition. Website-level conversion rate remains BLOCKED -
-- no web session source exists (DS-007), see note below.
CREATE OR REPLACE VIEW vw_kpi_conversion_rate_campaign AS
SELECT
    mc.campaign_id,
    mc.campaign_name,
    ch.channel_name,
    mc.clicks,
    COALESCE(cas.attributed_orders, 0) AS attributed_conversions,
    ROUND(COALESCE(cas.attributed_orders, 0) / NULLIF(mc.clicks, 0) * 100, 2) AS conversion_rate_pct
FROM marketing_campaigns mc
JOIN marketing_channels ch ON ch.channel_id = mc.channel_id
LEFT JOIN vw_kpi_campaign_attributed_sales cas ON cas.campaign_id = mc.campaign_id;


-- ============================================================
-- UPDATED STATUS - previously BLOCKED, now available:
--   KPI-002 Campaign-Attributed Sales -> vw_kpi_campaign_attributed_sales
--   KPI-004 Operational ROAS          -> vw_kpi_operational_roas
--   KPI-008 Conversion Rate (campaign)-> vw_kpi_conversion_rate_campaign
--
-- STILL BLOCKED (Finance data, out of BRD Phase 1 scope to
-- self-generate per section 8.2 "unapproved financial cost
-- classifications"):
--   KPI-005 Financial ROAS, KPI-006 ROI, KPI-007 CAC,
--   KPI-010 Financial CPC, KPI-008 website-level Conversion Rate,
--   Revenue per Visitor/Session (need web session data, DS-007)

