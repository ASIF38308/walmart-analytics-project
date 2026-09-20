# Insights and Recommendations

**Project:** Walmart Centralized Analytics Platform
**Stage:** SQL Development / Analytical Layer - Step 6 (Insights and Recommendations)
**Based on:** `07_Business_Analysis_Findings.md`

---

## Purpose

This document translates the Business Analysis findings into concrete
actions. Each recommendation is tied to a specific finding - no
recommendation is included without a data point behind it.

---

## 1. Revenue is flat - refund rate is the bigger lever than growth

**Finding:** Monthly revenue held steady (₹12.9M-14.7M) across 3 years,
no growth trend. Refunds consistently ran 14-18% of gross order value
every month.

**Recommendation:** Since top-line growth isn't moving on its own,
reducing the refund rate has more immediate financial upside than
chasing acquisition. A 2-3 point reduction in refund rate would
recover real revenue without needing new demand.

**Next step:** Investigate refund drivers by product/category (not
yet broken down by reason at the revenue level - only at return-count
level, see #6).

---

## 2. Groceries is the strongest category - Electronics is underperforming

**Finding:** Groceries (Britannia + Amul) generated ~₹151M, the
highest of any department. Electronics was the weakest across all
4 of its brands (~₹35-37M each), despite typically carrying higher
unit prices.

**Recommendation:** Electronics has pricing headroom (higher unit
value) but isn't converting that into revenue - worth checking if
this is a demand issue, a pricing/discount issue, or a shelf-space/
visibility issue. Groceries' strength is volume-driven (highest order
counts) - a loyalty/repeat-purchase play here likely pays off faster
than in any other department.

---

## 3. Membership tier isn't a real value signal - don't act on it yet

**Finding:** Revenue-per-customer is nearly flat across Bronze,
Silver, Gold, Platinum (₹58.6K-59.7K, no meaningful gap).

**Recommendation:** Do not build tier-based targeting, tier-based
offers, or a "protect Platinum customers" strategy on this data - the
field doesn't currently reflect real spending behavior. This is a
data limitation, not a business finding. Recommend fixing the
`membership_tier` generation logic (tie it to actual historical
spend) before this dimension is used in any real segmentation work.

---

## 4. Store efficiency is uniform - South's revenue lead is just footprint

**Finding:** Revenue-per-store is nearly identical across all regions
(₹5.77M-5.85M). South's higher total revenue comes from having 54
stores vs 12-19 elsewhere, not from stronger per-store performance.

**Recommendation:** If expansion budget exists, it can go to any
region with similar expected return - store performance itself isn't
regionally skewed. This also means underperformance investigations
should look at individual stores, not blame or credit a whole region.

---

## 5. Google Ads is the most cost-efficient channel; Affiliate the highest-spend

**Finding:** Google Ads had the lowest spend (₹34.8M) but the highest
CTR (3.64%) and cheapest CPC (₹5.47). Affiliate had the highest spend
(₹57.0M) and strongest self-reported ROAS (4.27).

**Recommendation:** Google Ads looks under-invested relative to its
efficiency - worth testing an increased budget allocation there.
Affiliate's ROAS is promising but **should not be treated as
confirmed** until real order-level attribution exists (see caveat
below) - don't reallocate major budget on this number alone yet.

**Caveat carried over:** all campaign revenue/ROAS/conversion figures
here are self-reported by the campaign source, not independently
verified via Last-Touch Attribution (no order-to-campaign link exists
in the data - see `kpi_views.sql` BLOCKED KPIs section). Treat channel
ranking as directional, not final.

---

## 6. Returns are a flat ~15% baseline - not a targeted problem

**Finding:** Return rate is flat across all departments (14.87%-
15.12%) and return reasons are evenly spread (no single reason
dominates).

**Recommendation:** This is a business-wide baseline issue, not a
category-specific fix. A general returns-reduction initiative
(packaging quality, delivery time, product description accuracy -
matching the 5 reasons logged) would apply evenly across the board,
rather than targeting one department.

---

## Overall Priority Order

1. **Refund/return reduction** - highest financial leverage, affects
   revenue directly and applies uniformly (#1, #6)
2. **Electronics category review** - clear underperformance with
   identifiable upside (#2)
3. **Google Ads budget test** - low-risk, data-supported efficiency
   play (#5)
4. **Fix `membership_tier` data** - prerequisite before any
   segmentation strategy is trustworthy (#3)
5. **Regional expansion** - open decision, not blocked by any finding
   (#4)

---

## What This Analysis Could Not Determine

Logged here so it isn't silently forgotten:

- **True marketing attribution** (which channel/campaign actually
  drove a sale) - blocked, no order-to-campaign link in the data
- **Official Finance-recognized revenue** - blocked, no Finance data
  source exists (DS-005)
- **ROI** - intentionally not calculated; methodology still "Under
  Review" per the KPI Dictionary, pending Finance sign-off
- **Customer Acquisition Cost** - blocked, no Finance cost data (DS-006)
