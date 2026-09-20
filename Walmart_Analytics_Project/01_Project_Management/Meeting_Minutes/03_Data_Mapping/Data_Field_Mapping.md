# Data Field Mapping

## Walmart Centralized Analytics Platform

---

## 1. Document Control

| Field | Details |
|---|---|
| Document | Data Field Mapping |
| Version | 1.0 |
| Status | Draft |
| Prepared By | Business Analyst |
| Date | August 2026 |

---

## 2. Purpose

This document maps source-system fields to the data required for KPI calculation and dashboard reporting.

Mapping flow:

**Source → Field → Business Meaning → Transformation → KPI**

---

## 3. Customer Data Mapping

| Source Field | Business Meaning | Target Usage | KPI |
|---|---|---|---|
| customer_id | Unique customer | Customer identifier | CAC |
| first_purchase_date | First valid purchase | New customer identification | CAC |
| acquisition_channel | Acquisition source | Channel analysis | CAC |
| customer_segment | Customer classification | Segmentation | CAC / Dashboard |
| region | Customer geography | Regional analysis | CAC / Dashboard |

---

## 4. Transaction Data Mapping

| Source Field | Business Meaning | Target Usage | KPI |
|---|---|---|---|
| order_id | Unique order | Order identifier | Revenue / AOV |
| customer_id | Customer reference | Customer linkage | CAC |
| order_date | Transaction date | Reporting period | All sales KPIs |
| order_status | Order state | Completed/cancelled classification | Revenue / AOV |
| order_value | Transaction value | Revenue calculation | Revenue / AOV |
| refund_amount | Refunded value | Revenue adjustment | Revenue / AOV |
| return_amount | Returned value | Revenue adjustment | Revenue / AOV |
| discount_amount | Discount value | Financial treatment | ROI |
| campaign_id | Campaign reference | Attribution | Campaign Sales / ROAS |
| channel | Marketing channel | Channel analysis | Marketing KPIs |

---

## 5. Campaign Data Mapping

| Source Field | Business Meaning | Target Usage | KPI |
|---|---|---|---|
| campaign_id | Campaign identifier | Campaign linkage | Campaign KPIs |
| campaign_name | Campaign name | Dashboard | Campaign KPIs |
| campaign_type | Campaign classification | Filtering | Campaign KPIs |
| channel | Marketing channel | Channel analysis | ROAS / CAC |
| start_date | Campaign start | Campaign period | Reporting |
| end_date | Campaign end | Campaign period | Reporting |
| attribution_id | Attribution reference | Revenue attribution | Campaign Sales |

---

## 6. Advertising Platform Mapping

| Source Field | Business Meaning | Target Usage | KPI |
|---|---|---|---|
| campaign_id | Campaign reference | Campaign linkage | Marketing KPIs |
| platform | Advertising platform | Platform analysis | CPC / CTR |
| impressions | Ad impressions | Reach | CTR |
| clicks | Ad clicks | Engagement | CTR / CPC |
| platform_spend | Platform advertising cost | Operational cost | Operational ROAS / CPC |

---

## 7. Finance Revenue Mapping

| Source Field | Business Meaning | Target Usage | KPI |
|---|---|---|---|
| order_id | Transaction reference | Reconciliation | Revenue |
| revenue_date | Financial date | Reporting | Revenue |
| recognized_revenue | Finance-approved revenue | Revenue measure | Revenue / AOV / ROAS |
| refund_amount | Refund adjustment | Revenue adjustment | Revenue |
| return_amount | Return adjustment | Revenue adjustment | Revenue |
| financial_adjustment | Other adjustment | Reconciliation | Revenue / ROI |

---

## 8. Finance Marketing Cost Mapping

| Source Field | Business Meaning | Target Usage | KPI |
|---|---|---|---|
| cost_date | Cost period | Reporting | Financial KPIs |
| channel | Marketing channel | Channel analysis | ROAS / CAC |
| campaign_id | Campaign reference | Campaign analysis | ROAS / ROI |
| cost_category | Cost classification | Financial treatment | ROI / CAC |
| marketing_cost | Finance-recognized cost | Financial cost | Financial ROAS / ROI / CAC |
| agency_cost | Agency expense | Cost classification | ROI / CAC |
| creative_cost | Creative expense | Cost classification | ROI / CAC |
| campaign_expense | Campaign-related cost | Cost classification | ROI / CAC |

---

## 9. Website Analytics Mapping

| Source Field | Business Meaning | Target Usage | KPI |
|---|---|---|---|
| date | Analytics date | Reporting | Marketing KPIs |
| visitor_id | Unique visitor | Visitor measurement | RPV |
| session_id | Website session | Session measurement | RPS |
| sessions | Total sessions | Session denominator | Conversion / RPS |
| unique_visitors | Unique visitors | Visitor denominator | RPV |
| campaign_id | Campaign reference | Campaign analysis | Campaign KPIs |
| channel | Marketing channel | Channel analysis | Marketing KPIs |

---

## 10. Product Data Mapping

| Source Field | Business Meaning | Target Usage | KPI |
|---|---|---|---|
| product_id | Product identifier | Product linkage | Revenue / AOV |
| product_name | Product name | Dashboard | Product analysis |
| category | Product category | Category analysis | AOV / Revenue |
| brand | Product brand | Brand analysis | Revenue |
| price | Product price | Pricing analysis | AOV |

---

## 11. Regional Data Mapping

| Source Field | Business Meaning | Target Usage | KPI |
|---|---|---|---|
| region_id | Region identifier | Regional linkage | All applicable KPIs |
| region_name | Region name | Dashboard | Regional analysis |
| state | State | Geographic analysis | Regional KPIs |
| city | City | Detailed analysis | Regional KPIs |

---

## 12. Budget Data Mapping

| Source Field | Business Meaning | Target Usage | KPI / Report |
|---|---|---|---|
| budget_period | Budget period | Time comparison | Budget vs Actual |
| channel | Marketing channel | Budget allocation | Budget vs Actual |
| campaign_id | Campaign reference | Campaign budget | Budget vs Actual |
| budget_amount | Approved budget | Budget comparison | Budget vs Actual |
| cost_category | Budget classification | Cost comparison | Budget vs Actual |

---

## 13. Mapping Status

| Status | Meaning |
|---|---|
| 🟢 Confirmed | Field validated with source owner |
| 🟡 Partially Confirmed | Business meaning known, source field pending |
| 🟠 To Map | Source field requires confirmation |
| 🔴 Unavailable | Required field not currently available |

**Current Status:** 🟠 Initial Mapping