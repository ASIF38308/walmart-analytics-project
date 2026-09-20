/*
=========================================================
Project : Walmart Centralized Analytics Platform
File    : validation_queries.sql
Stage   : SQL Development / Analytical Layer - Step 3
Author  : Mohd Asif
Purpose : Validate kpi_views.sql outputs against the
          underlying transactional tables, and surface data-
          quality issues that would silently distort a KPI.

How to use: run each block and inspect the result. A query
with a comment "-- expect 0 rows" or "-- expect: TRUE" that
returns otherwise means either the view logic or the source
data needs attention before the KPI is trusted downstream.
=========================================================
*/

USE walmart_analytics;


-- ============================================================
-- 1. Reconciliation: vw_kpi_revenue_operational_daily totals
--    must equal a manual recompute straight from source tables
-- ============================================================
-- Business purpose: this is the core trust check for the
-- revenue view - if these two numbers don't match, the view's
-- CASE/JOIN logic has a bug, not the data.
SELECT
    (SELECT SUM(recognized_revenue_operational) FROM vw_kpi_revenue_operational_daily) AS view_total_revenue,
    (
        SELECT SUM(o.total_amount) - COALESCE(SUM(r.refund_amount), 0)
        FROM orders o
        LEFT JOIN returns r ON r.order_id = o.order_id
        WHERE o.order_status <> 'Cancelled'
    ) AS manual_total_revenue;
    -- expect: the two columns are equal


-- ============================================================
-- 2. Reconciliation: completed_orders count in AOV view
-- ============================================================
SELECT
    (SELECT SUM(completed_orders) FROM vw_kpi_aov_operational_daily) AS view_completed_orders,
    (
        SELECT COUNT(*)
        FROM orders o
        LEFT JOIN returns r ON r.order_id = o.order_id
        WHERE o.order_status <> 'Cancelled'
          AND COALESCE(r.refund_amount, 0) < o.total_amount
    ) AS manual_completed_orders;
    -- expect: the two columns are equal


-- ============================================================
-- 3. Orders with no matching rows in the AOV view at all
-- ============================================================
-- Catches a date grouping bug (e.g. NULL order_date silently
-- dropped by GROUP BY).
SELECT COUNT(*) AS orders_missing_a_date_bucket
FROM orders o
WHERE o.order_date IS NULL;
-- expect 0 rows / 0 count


-- ============================================================
-- 4. Data-quality: refund_amount exceeding order total
-- ============================================================
-- Business purpose: a return should never refund more than the
-- customer paid. If this returns rows, either return generation
-- has a bug or there's a legitimate case (e.g. refund includes
-- shipping) that the KPI logic needs to account for explicitly
-- rather than silently netting to a negative revenue figure.
SELECT
    o.order_id,
    o.total_amount,
    r.refund_amount,
    r.refund_amount - o.total_amount AS overage
FROM orders o
JOIN returns r ON r.order_id = o.order_id
WHERE r.refund_amount > o.total_amount;
-- expect 0 rows


-- ============================================================
-- 5. Orphan check: returns pointing at an order_id that
--    doesn't exist in orders
-- ============================================================
SELECT r.order_id
FROM returns r
LEFT JOIN orders o ON o.order_id = r.order_id
WHERE o.order_id IS NULL;
-- expect 0 rows


-- ============================================================
-- 6. Orphan check: marketing_campaigns pointing at a
--    channel_id that doesn't exist in marketing_channels
-- ============================================================
-- Business purpose: vw_kpi_campaign_performance uses an inner
-- JOIN to marketing_channels - if this returns rows, those
-- campaigns are silently dropped from the KPI view and nobody
-- would notice without this check.
SELECT mc.campaign_id, mc.channel_id
FROM marketing_campaigns mc
LEFT JOIN marketing_channels ch ON ch.channel_id = mc.channel_id
WHERE ch.channel_id IS NULL;
-- expect 0 rows


-- ============================================================
-- 7. Row count parity: vw_kpi_campaign_performance vs
--    marketing_campaigns source
-- ============================================================
SELECT
    (SELECT COUNT(*) FROM vw_kpi_campaign_performance) AS view_row_count,
    (SELECT COUNT(*) FROM marketing_campaigns) AS source_row_count;
    -- expect: equal (500). If not equal, query 6 above will
    -- show why (orphaned channel_id causing a dropped row).


-- ============================================================
-- 8. Data-quality: campaigns with clicks but zero/NULL
--    impressions (breaks CTR, not a divide-by-zero bug since
--    NULLIF handles it, but worth knowing how often it happens)
-- ============================================================
SELECT COUNT(*) AS campaigns_with_clicks_but_no_impressions
FROM marketing_campaigns
WHERE clicks > 0 AND (impressions = 0 OR impressions IS NULL);
-- informational - investigate if count is unexpectedly high


-- ============================================================
-- 9. Data-quality: clicks exceeding impressions
-- ============================================================
-- Business purpose: CTR should never exceed 100%. If this
-- returns rows, either the synthetic data generator has a bug
-- or these campaigns need to be excluded/flagged before CTR
-- reaches a dashboard.
SELECT campaign_id, impressions, clicks
FROM marketing_campaigns
WHERE clicks > impressions;
-- expect 0 rows


-- ============================================================
-- 10. Sanity check: self_reported_roas vs the pre-computed
--     `roas` column already present in marketing_campaigns
-- ============================================================
-- Business purpose: marketing_campaigns.roas was generated
-- independently of this project's SQL. This isn't validating
-- our logic against itself - it's a cross-check that our
-- recomputation (revenue_generated / spend) agrees with
-- whatever formula produced the original roas column. A
-- mismatch here doesn't mean either number is "wrong", but it
-- does mean the two must not be used interchangeably until
-- reconciled.
SELECT
    mc.campaign_id,
    mc.roas AS source_roas,
    ROUND(mc.revenue_generated / NULLIF(mc.spend, 0), 2) AS recomputed_roas,
    ROUND(mc.revenue_generated / NULLIF(mc.spend, 0), 2) - mc.roas AS difference
FROM marketing_campaigns mc
WHERE ABS(ROUND(mc.revenue_generated / NULLIF(mc.spend, 0), 2) - mc.roas) > 0.01
ORDER BY ABS(ROUND(mc.revenue_generated / NULLIF(mc.spend, 0), 2) - mc.roas) DESC;
-- informational - review count and magnitude of mismatches
