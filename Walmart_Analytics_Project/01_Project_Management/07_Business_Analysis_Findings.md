# Business Analysis Findings

**Project:** Walmart Centralized Analytics Platform
**Stage:** SQL Development / Analytical Layer - Step 4 (Business Analysis)
**Status:** Living document - updated as new analysis areas are covered

---

## Purpose

This document records the business questions asked, the SQL used to
answer them, the key numbers found, and the resulting insight - for
each area of analysis. It is the reference point for the Dashboard
stage (Tableau) and for final Insights/Recommendations.

Data caveats discovered during analysis are logged here too, so a
finding is never mistaken for a real business signal when it is
actually a data-generation limitation.

---

## 1. Revenue Trend

**Business question:** How has recognized revenue moved over time -
growing, flat, seasonal?

**Source:** `vw_kpi_revenue_operational_daily`, grouped by month.

**Finding:**
- Monthly revenue is flat across all 3 years of data (2023-2025),
  consistently in the ₹12.9M-14.7M range. No clear growth or decline
  trend - a mature/steady business pattern rather than a growth story.
- Refunds run consistently high, ~14-18% of gross order value, every
  month - a structural pattern, not a seasonal spike.

**Caveat:** This is the *operational* (transactional) revenue figure,
not the official Finance-recognized KPI-001, since no Finance revenue
source exists in this project (DS-005, unconfirmed).

---

## 2. Product / Category Performance

**Business question:** Which categories/products drive revenue, and
where's the weak spot?

**Source:** `order_items` joined to `products` and `orders`
(excluding cancelled orders).

**Data issue found and fixed:** `order_items.total_price` originally
summed to ~18x the real order revenue, and product brands were
randomly assigned regardless of department (e.g. IKEA under
Groceries). Both were data-generation bugs, not query bugs - fixed
by regenerating `order_items.csv` (line items now reconcile exactly
to `orders.total_amount`) and `products.csv` (brands now mapped to
their correct department). See `python/generate_order_items.py` and
`python/config_products.py` for the corrected logic.

**Finding (after fix):**
- Groceries leads: Britannia + Amul together ≈ ₹151M, ahead of every
  other department.
- Electronics is the weakest department across all its brands
  (~₹35-37M each), despite typically higher unit prices.
- Groceries also has the highest order counts (14K, 13.6K orders) -
  a high-frequency, lower-ticket buying pattern.

---

## 3. Customer Value / Segments

**Business question:** Which customer segment (membership tier)
drives the most revenue per customer?

**Source:** `customers` joined to `orders` (excluding cancelled),
grouped by `membership_tier`.

**Finding:**
| Tier | Customers | Revenue/Customer |
|---|---|---|
| Bronze | 4,959 | ₹58,602.90 |
| Silver | 2,908 | ₹59,675.44 |
| Gold | 1,498 | ₹59,211.94 |
| Platinum | 480 | ₹58,874.12 |

Revenue-per-customer is nearly identical across all 4 tiers.

**Caveat - not a real business signal:** `membership_tier` appears
randomly assigned in the source data, not tied to actual customer
spend. Do not use this as evidence that "tier doesn't drive value" -
it means the tier field itself isn't currently meaningful. Flagged as
a known data limitation, not yet fixed (lower priority than the
order_items/products fix above).

---

## 4. Store / Regional Performance

**Business question:** Which regions/stores drive the most revenue -
are there real performance gaps?

**Source:** `stores` joined to `orders` (excluding cancelled),
grouped by `region`.

**Finding:**
| Region | Stores | Revenue/Store |
|---|---|---|
| South | 54 | ₹5,808,253.18 |
| North | 19 | ₹5,847,962.61 |
| West | 15 | ₹5,807,866.05 |
| East | 12 | ₹5,769,337.29 |

Revenue-per-store is nearly identical across every region (this one
looks like a genuine, consistent pattern, not random noise). South's
much larger total revenue is purely a footprint effect - 54 stores
vs 12-19 elsewhere - not stronger per-store performance. The real
insight is that store efficiency is uniform; the business difference
between regions is store count, not effectiveness.

---

## 5. Campaign / Marketing Performance

**Business question:** Which channels are performing best - where is
spend working, where isn't it?

**Source:** `vw_kpi_campaign_performance`, grouped by `channel_name`.

**Finding (top channels by spend):**
| Channel | Spend | CTR % | Avg CPC | Avg Self-Reported ROAS |
|---|---|---|---|---|
| Affiliate | ₹57.0M | 3.32 | ₹5.99 | 4.27 |
| Referral | ₹50.1M | 3.27 | ₹6.39 | 3.94 |
| YouTube | ₹47.5M | 3.21 | ₹6.29 | 4.34 |
| Google Ads | ₹34.8M | 3.64 | ₹5.47 | 3.87 |

Google Ads has the lowest spend but highest CTR and cheapest CPC -
efficient at the click level. YouTube and Affiliate report the
highest self-reported ROAS.

**Caveat:** `self_reported_roas` and other conversion/revenue figures
here come directly from the campaign source data, not from real
order-level Last-Touch Attribution (that link doesn't exist in this
dataset - see `kpi_views.sql` BLOCKED KPIs section for KPI-002/004/005).
Useful directionally for channel comparison, not final financial truth.

---

## 6. Returns / Inventory

**Business question:** What's driving returns - concentrated in
specific categories/reasons, or spread evenly?

**Source:** `returns` grouped by `return_reason`; return rate by
`department` via `order_items`/`products`/`returns`.

**Finding:**
- Return reasons are evenly spread (1,425-1,581 occurrences each,
  out of ~7,500 total returns) - no single reason dominates.
- Return rate by department is also flat: 14.87%-15.12% across all
  4 departments. No department is disproportionately returned.

No operational red flag here - returns are a consistent ~15% baseline
across the business, not a category-specific problem.

---

## Cross-Cutting Pattern

Several areas above show unusually flat/even results (regional
store output, tier revenue, return rates). Real retail data
typically shows more skew. This is a synthetic-data characteristic
worth being upfront about in interviews - two real bugs were found
and fixed during this analysis (order_items/products), and one
further limitation (membership_tier) is logged but not yet fixed.
This document should be updated if that gets addressed later.
