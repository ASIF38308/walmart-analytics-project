# Data Source Assessment

## Walmart Centralized Analytics Platform

---

## 1. Document Control

| Field | Details |
|---|---|
| Document Name | Data Source Assessment |
| Project | Walmart Centralized Analytics Platform |
| Version | 1.0 |
| Status | Draft |
| Prepared By | Business Analyst |
| Date | August 2026 |

---

## 2. Purpose

The purpose of this document is to identify, assess, and document the data sources required to support the approved business requirements, KPIs, and dashboards.

The assessment will establish:

- Required data sources
- Data ownership
- Business purpose
- Expected data availability
- Historical coverage
- Data quality considerations
- Access requirements
- Source-to-KPI relationships

---

## 3. Data Source Register

| ID | Data Source | Business Area | Primary Owner | Purpose | Status |
|---|---|---|---|---|---|
| DS-001 | Customer Data | Customer | Customer/Data Team | Customer identification and segmentation | 🟠 To Assess |
| DS-002 | Transaction/Order Data | Sales | Sales/Data Team | Revenue, orders, AOV and conversion | 🟠 To Assess |
| DS-003 | Campaign Data | Marketing | Marketing | Campaign performance and attribution | 🟠 To Assess |
| DS-004 | Advertising Platform Data | Marketing | Marketing | Impressions, clicks and platform spend | 🟠 To Assess |
| DS-005 | Finance Revenue Data | Finance | Finance | Recognized revenue | 🟠 To Assess |
| DS-006 | Finance Marketing Cost Data | Finance | Finance | Financial ROAS, ROI and CAC | 🟠 To Assess |
| DS-007 | Website Analytics Data | Digital/Product | Product/Digital | Sessions and unique visitors | 🟠 To Assess |
| DS-008 | Product Data | Product | Product/Merchandising | Product and category analysis | 🟠 To Assess |
| DS-009 | Regional Data | Business | Business/Data Team | Regional reporting | 🟠 To Assess |
| DS-010 | Marketing Budget Data | Finance/Marketing | Marketing/Finance | Budget vs actual analysis | 🟠 To Assess |

---

## 4. Assessment Criteria

Each source will be assessed against:

1. Data ownership
2. Business purpose
3. Data granularity
4. Historical availability
5. Refresh frequency
6. Data quality
7. Required fields
8. Access requirements
9. Integration method
10. KPI usage

---

## 5. Source Assessment Status

| Status | Meaning |
|---|---|
| 🟢 Confirmed | Source and requirements validated |
| 🟡 Partially Confirmed | Some information available |
| 🟠 To Assess | Source requires investigation |
| 🔴 Blocked | Access or availability issue |

---

## 6. Next Activity

The next activity is to assess each source and identify:

**Source → Tables/Data → Fields → Business Meaning → KPI Usage**

---

## 7. Status

**Status:** 🟢 Data Source Assessment Started
# 8. DS-001 — Customer Data Assessment

## 8.1 Source Overview

| Field | Details |
|---|---|
| Source ID | DS-001 |
| Data Source | Customer Data |
| Business Area | Customer |
| Primary Owner | Customer/Data Team |
| Purpose | Customer identification, segmentation and CAC |
| Historical Requirement | January 2024 onward |
| Status | 🟠 To Assess |

## 8.2 Required Data

| Data Element | Business Purpose | KPI Usage |
|---|---|---|
| Customer ID | Unique customer identification | CAC |
| Customer First Purchase Date | Identify new customers | CAC |
| Customer Status | Identify active/valid customers | CAC |
| Acquisition Channel | Customer acquisition analysis | CAC / Marketing |
| Customer Segment | Segment performance analysis | CAC / Dashboard |
| Region | Regional analysis | CAC / Dashboard |

## 8.3 Data Quality Requirements

The following checks are required:

- Customer ID must be unique.
- Customer ID must not be NULL.
- First purchase date must be valid.
- Acquisition channel should use approved values.
- Customer records must be linked correctly to transactions.
- Duplicate customer records must be identified.
- Cancelled/refunded first purchases must follow the approved CAC business rule.

## 8.4 Business Rules

For CAC:

**New Customer = Customer whose first-ever valid purchase qualifies under the approved business definition.**

The treatment of customers whose first purchase is subsequently cancelled or fully refunded must follow the approved CAC methodology.

## 8.5 Source-to-KPI Relationship

| KPI | Required? | Usage |
|---|---:|---|
| CAC | ✅ | New-customer identification |
| Conversion Rate | ❌ | Not primary source |
| AOV | ❌ | Not primary source |
| RPV | ❌ | Not primary source |
| RPS | ❌ | Not primary source |

## 8.6 Assessment Questions

The following must be confirmed with the source owner:

1. What system is the customer master stored in?
2. Is Customer ID unique across all systems?
3. Where is the first-ever purchase date stored?
4. How is customer acquisition channel recorded?
5. How are duplicate customer records handled?
6. What historical data is available?
7. How frequently is customer data updated?
8. Are there restrictions on customer-level data?

## 8.7 Status

**Assessment Status:** 🟠 To Assess

**Next:** DS-002 — Transaction / Order Data
# 9. DS-002 — Transaction / Order Data Assessment

## 9.1 Source Overview

| Field | Details |
|---|---|
| Source ID | DS-002 |
| Data Source | Transaction / Order Data |
| Business Area | Sales / Commerce |
| Primary Owner | Sales / Data Team |
| Purpose | Revenue, orders, AOV and conversion analysis |
| Historical Requirement | January 2024 onward |
| Status | 🟠 To Assess |

## 9.2 Required Data

| Data Element | Business Purpose | KPI Usage |
|---|---|---|
| Order ID | Unique order identification | Revenue / AOV / Conversion |
| Customer ID | Link order to customer | CAC / Customer Analysis |
| Order Date | Time-based analysis | All sales KPIs |
| Order Status | Identify completed/cancelled orders | Revenue / AOV |
| Order Value | Transaction value | Revenue / AOV |
| Refund Amount | Revenue adjustment | Revenue / AOV |
| Return Amount | Revenue adjustment | Revenue / AOV |
| Discount Amount | Financial adjustment | Revenue / ROI |
| Product ID | Product analysis | AOV / Product |
| Campaign ID | Campaign attribution | Campaign-Attributed Sales |
| Marketing Channel | Channel analysis | Marketing KPIs |
| Region | Regional analysis | Dashboard |

## 9.3 Data Quality Requirements

The following checks are required:

- Order ID must be unique at the order level.
- Customer ID must link to a valid customer where applicable.
- Order dates must be valid.
- Order status must use approved values.
- Order values must not contain invalid negative amounts unless explicitly permitted.
- Refunds and returns must be correctly linked to the original order.
- Duplicate transactions must be identified.
- Missing campaign or channel information must be identified.
- Transaction totals must reconcile with Finance-approved revenue where applicable.

## 9.4 Revenue Business Rules

Revenue reporting must follow the approved Finance definition of **recognized revenue**.

The calculation must account for applicable:

- Cancellations
- Refunds
- Returns
- Financial adjustments

The transaction-level calculation must reconcile with Finance-recognized revenue.

## 9.5 AOV Business Rules

AOV will use:

**Recognized Revenue ÷ Completed Orders**

Cancelled orders are excluded.

Fully refunded orders are excluded from the completed-order count.

Partial refunds and returns follow Finance-approved revenue treatment.

## 9.6 Campaign Attribution

Campaign-level reporting requires a valid relationship between transactions and campaign attribution data.

Phase 1 will use the approved **Last-Touch Attribution** methodology.

## 9.7 Source-to-KPI Relationship

| KPI | Required? | Usage |
|---|---:|---|
| Revenue | ✅ | Recognized revenue |
| Campaign-Attributed Sales | ✅ | Campaign revenue |
| CAC | ✅ | Customer/order relationship |
| Conversion Rate | ✅ | Completed purchases |
| AOV | ✅ | Revenue / completed orders |
| RPV | ✅ | Revenue component |
| RPS | ✅ | Revenue component |
| ROAS | ✅ | Revenue component |
| ROI | ✅ | Return component |

## 9.8 Assessment Questions

The following must be confirmed with the source owner:

1. What is the authoritative transaction system?
2. What defines a completed order?
3. Where are cancellations recorded?
4. Where are refunds and returns recorded?
5. How are partial refunds handled?
6. How are discounts recorded?
7. Is campaign attribution stored at transaction level?
8. How are orders linked to marketing channels?
9. What historical data is available?
10. How frequently is transaction data updated?

## 9.9 Reconciliation Requirement

Transaction revenue must be reconciled against Finance-recognized revenue.

Any material difference must be documented and investigated before financial reporting is published.

## 9.10 Status

**Assessment Status:** 🟠 To Assess

**Next:** DS-003 — Campaign Data Assessment
# 10. DS-003 — Campaign Data Assessment

## 10.1 Source Overview

| Field | Details |
|---|---|
| Source ID | DS-003 |
| Data Source | Campaign Data |
| Business Area | Marketing |
| Primary Owner | Marketing |
| Purpose | Campaign performance and attribution |
| Historical Requirement | January 2024 onward |
| Status | 🟠 To Assess |

## 10.2 Required Data

| Data Element | Business Purpose | KPI Usage |
|---|---|---|
| Campaign ID | Unique campaign identification | Marketing KPIs |
| Campaign Name | Campaign reporting | Dashboard |
| Campaign Type | Campaign classification | Dashboard |
| Marketing Channel | Channel analysis | Marketing KPIs |
| Campaign Start Date | Campaign period | Reporting |
| Campaign End Date | Campaign period | Reporting |
| Platform | Advertising platform | CTR / CPC |
| Attribution ID | Link campaign to conversions | Campaign Sales / ROAS |
| Target Audience | Customer segment analysis | Dashboard |
| Campaign Status | Active/inactive classification | Reporting |

## 10.3 Data Quality Requirements

- Campaign ID must be unique.
- Campaign names should follow approved naming conventions.
- Campaign dates must be valid.
- Campaign must have an approved channel classification.
- Campaign type must use approved categories.
- Duplicate campaigns must be identified.
- Campaign attribution records must be traceable.
- Missing attribution must be identified and documented.

## 10.4 Attribution Rules

Phase 1 will use **Last-Touch Attribution** for campaign-level reporting.

Campaign-attributed revenue/sales must be linked to the approved attribution record.

The same attribution methodology should be applied consistently across relevant marketing and product dashboards.

## 10.5 Campaign Classification

Marketing will be responsible for defining:

- Campaign type
- Marketing channel
- Campaign classification
- Campaign hierarchy

Finance will validate the financial treatment where campaign classification affects financial metrics.

## 10.6 Source-to-KPI Relationship

| KPI | Required? | Usage |
|---|---:|---|
| Campaign-Attributed Sales | ✅ | Attributed sales |
| Operational ROAS | ✅ | Sales / Platform Spend |
| Financial ROAS | ✅ | Sales / Finance Cost |
| CAC | ✅ | Acquisition analysis |
| Conversion Rate | ✅ | Campaign conversions |
| CTR | ✅ | Campaign clicks / impressions |
| CPC | ✅ | Campaign spend / clicks |
| RPV | ✅ | Campaign-attributed revenue |
| RPS | ✅ | Campaign-attributed revenue |
| ROI | ✅ | Campaign financial return |

## 10.7 Assessment Questions

1. Which system is the authoritative campaign master?
2. What is the campaign ID standard?
3. How are campaigns linked to marketing platforms?
4. How is campaign attribution recorded?
5. Are campaign types standardized?
6. Are channel classifications standardized?
7. How are campaigns that run across multiple channels handled?
8. How far back is campaign data available?
9. How frequently is campaign data updated?
10. Who approves changes to campaign classification?

## 10.8 Status

**Assessment Status:** 🟠 To Assess

**Next:** DS-004 — Advertising Platform Data Assessment
# 11. DS-004 — Advertising Platform Data Assessment

## 11.1 Source Overview

| Field | Details |
|---|---|
| Source ID | DS-004 |
| Data Source | Advertising / Marketing Platforms |
| Business Area | Marketing |
| Primary Owner | Marketing |
| Purpose | Campaign reach, engagement and platform spend |
| Historical Requirement | January 2024 onward |
| Status | 🟠 To Assess |

## 11.2 Required Data

| Data Element | Business Purpose | KPI Usage |
|---|---|---|
| Campaign ID | Campaign identification | Marketing KPIs |
| Platform | Platform analysis | CTR / CPC |
| Date | Time-based reporting | All marketing KPIs |
| Impressions | Reach measurement | CTR |
| Clicks | Engagement measurement | CTR / CPC / Conversion |
| Platform Spend | Advertising cost | Operational ROAS / CPC |
| Campaign Status | Active/inactive reporting | Dashboard |
| Channel | Channel analysis | Marketing KPIs |
| Ad / Creative ID | Creative performance | CTR / CPC |
| Conversion Data | Campaign performance | Conversion Rate |

## 11.3 Data Quality Requirements

- Campaign IDs must be traceable to the campaign master.
- Clicks and impressions must use the same reporting period.
- Platform spend must be validated against platform records.
- Duplicate records must be identified.
- Invalid or missing values must be flagged.
- Currency and timezone treatment must be standardized.
- Platform-specific exclusions must be documented.

## 11.4 KPI Business Rules

### CTR

**Clicks ÷ Impressions × 100**

### Operational CPC

**Platform Spend ÷ Clicks**

### Operational ROAS

**Campaign-Attributed Sales ÷ Platform Spend**

Campaign attribution must follow the approved Last-Touch methodology.

## 11.5 Platform Differences

Different advertising platforms may have different definitions for:

- Clicks
- Impressions
- Conversions
- Spend
- Attribution windows

Any material differences must be documented before combining platform data.

## 11.6 Source-to-KPI Relationship

| KPI | Required? | Usage |
|---|---:|---|
| Operational ROAS | ✅ | Platform spend |
| CTR | ✅ | Clicks / impressions |
| Operational CPC | ✅ | Spend / clicks |
| Conversion Rate | ✅ | Campaign conversions |
| Campaign-Attributed Sales | 🟡 | Attribution support |
| Financial ROAS | 🟡 | Supporting comparison |
| CAC | 🟡 | Acquisition-cost analysis |

## 11.7 Assessment Questions

1. Which advertising platforms are included in Phase 1?
2. What is the authoritative source for platform spend?
3. How are clicks and impressions defined for each platform?
4. Are platform currencies consistent?
5. Are platform timezones consistent?
6. What attribution windows are used by each platform?
7. How are invalid or duplicate clicks handled?
8. How frequently is platform data updated?
9. How far back is platform data available?
10. Are API connections available for automated extraction?

## 11.8 Access Requirements

The project may require:

- API access
- Service accounts
- Platform credentials
- Read-only permissions
- Historical data access

Access should follow organizational security policies.

## 11.9 Status

**Assessment Status:** 🟠 To Assess

**Next:** DS-005 — Finance Revenue Data Assessment
# 12. DS-005 — Finance Revenue Data Assessment

## 12.1 Source Overview

| Field | Details |
|---|---|
| Source ID | DS-005 |
| Data Source | Finance Revenue Data |
| Business Area | Finance |
| Primary Owner | Finance |
| Purpose | Authoritative recognized revenue and financial validation |
| Historical Requirement | January 2024 onward |
| Status | 🟠 To Assess |

## 12.2 Required Data

| Data Element | Business Purpose | KPI Usage |
|---|---|---|
| Revenue Date | Financial period reporting | Revenue / AOV / ROAS |
| Order ID | Transaction reconciliation | Revenue / AOV |
| Recognized Revenue | Official revenue measure | Revenue / ROAS / ROI / AOV |
| Refund Amount | Revenue adjustment | Revenue / AOV |
| Return Amount | Revenue adjustment | Revenue / AOV |
| Cancellation Amount | Revenue adjustment | Revenue |
| Financial Adjustment | Revenue reconciliation | Revenue / ROI |
| Currency | Financial standardisation | Financial KPIs |
| Region | Financial analysis | Dashboard |
| Product / Category | Product analysis | AOV / Dashboard |

## 12.3 Business Rules

Finance-recognized revenue will be treated as the authoritative financial revenue measure.

Recognized revenue should reflect applicable:

- Cancellations
- Refunds
- Returns
- Financial adjustments

Where transaction-level revenue differs from Finance-recognized revenue, the Finance-approved figure will be used for financial reporting.

## 12.4 KPI Relationship

| KPI | Required? | Usage |
|---|---:|---|
| Revenue | ✅ | Primary revenue source |
| Campaign-Attributed Sales | 🟡 | Financial validation |
| Financial ROAS | ✅ | Revenue / Finance marketing cost |
| ROI | ✅ | Return component |
| AOV | ✅ | Revenue / completed orders |
| RPV | ✅ | Revenue / unique visitors |
| RPS | ✅ | Revenue / sessions |
| CAC | 🟡 | Financial cost validation |

## 12.5 Data Quality Requirements

- Revenue records must reconcile with Finance-approved totals.
- Revenue dates must be valid.
- Order IDs must be traceable where applicable.
- Refunds and returns must be correctly reflected.
- Currency treatment must be documented.
- Duplicate financial records must be identified.
- Financial adjustments must be traceable.
- Preliminary and finalized financial figures must be distinguishable.

## 12.6 Reconciliation

The following reconciliation should be performed:

**Transaction Revenue → Finance Recognized Revenue**

Material differences must be investigated and documented.

## 12.7 Assessment Questions

1. What Finance system is the authoritative revenue source?
2. What is the exact Finance definition of recognized revenue?
3. How are returns and refunds treated?
4. How are partial refunds treated?
5. How are financial adjustments recorded?
6. When does financial data become final?
7. What historical data is available?
8. How frequently is Finance data updated?
9. What access restrictions apply?
10. Who provides final financial validation?

## 12.8 Access & Security

Finance data must be restricted to authorized users.

Only the fields required for approved analytics use cases should be exposed to the centralized analytics layer.

## 12.9 Status

**Assessment Status:** 🟠 To Assess

**Next:** DS-006 — Finance Marketing Cost Data Assessment
# 13. DS-006 — Finance Marketing Cost Data

## 13.1 Source Overview

| Field | Details |
|---|---|
| Source ID | DS-006 |
| Source | Finance Marketing Cost Data |
| Owner | Finance |
| Purpose | Financial ROAS, ROI and CAC |
| Historical Requirement | January 2024 onward |
| Status | 🟠 To Assess |

## 13.2 Required Data

| Data Element | Usage |
|---|---|
| Marketing Cost | Financial ROAS / ROI / CAC |
| Cost Date | Period reporting |
| Channel | Channel analysis |
| Campaign | Campaign analysis |
| Cost Category | Cost classification |
| Agency Cost | ROI / CAC |
| Creative Cost | ROI / CAC |
| Campaign Expenses | ROI / CAC |
| Discounts | ROI treatment |
| Region | Regional analysis |

## 13.3 Business Rules

- Finance-recognized costs are the financial source of truth.
- Operational platform spend remains separate.
- Eligible costs must be classified consistently.
- Campaign-funded discounts must be separately identified where applicable.
- Financial ROAS, ROI and CAC must use Finance-approved cost treatment.

## 13.4 KPI Relationship

| KPI | Usage |
|---|---|
| Financial ROAS | Finance cost |
| ROI | Investment component |
| CAC | Acquisition cost |
| Financial CPC | Finance cost |

## 13.5 Assessment Questions

1. Which costs are included in Finance-recognized marketing cost?
2. How are agency and creative costs classified?
3. How are campaign-funded discounts treated?
4. At what level are costs available—channel, campaign, region?
5. When does financial cost data become final?
6. What historical data is available?

## 13.6 Status

**Assessment Status:** 🟠 To Assess

**Next:** DS-007 — Website Analytics Data
# 14. DS-007 — Website Analytics Data

## 14.1 Source Overview

| Field | Details |
|---|---|
| Source ID | DS-007 |
| Source | Website Analytics |
| Owner | Product / Digital |
| Purpose | Sessions, visitors and conversion |
| Historical Requirement | January 2024 onward |
| Status | 🟠 To Assess |

## 14.2 Required Data

| Data Element | Usage |
|---|---|
| Session ID | Session analysis |
| Visitor ID | Unique visitor analysis |
| Date | Reporting |
| Sessions | Conversion / RPS |
| Unique Visitors | RPV |
| Campaign | Campaign analysis |
| Channel | Channel analysis |
| Device | Device analysis |

## 14.3 KPI Relationship

- Conversion Rate
- Revenue per Visitor
- Revenue per Session

## 14.4 Assessment Questions

- What platform provides website analytics?
- How are unique visitors defined?
- How are sessions defined?
- How is campaign traffic captured?
- What historical data is available?

**Status:** 🟠 To Assess


# 15. DS-008 — Product Data

## 15.1 Source Overview

| Field | Details |
|---|---|
| Source ID | DS-008 |
| Source | Product / Merchandising System |
| Owner | Product / Merchandising |
| Purpose | Product and category analysis |
| Status | 🟠 To Assess |

## 15.2 Required Data

| Data Element | Usage |
|---|---|
| Product ID | Product identification |
| Product Name | Reporting |
| Category | Category analysis |
| Brand | Brand analysis |
| Product Status | Active/inactive |
| Price | Revenue / AOV analysis |

## 15.3 KPI Relationship

- Revenue
- AOV
- Conversion Rate
- RPV
- RPS

## 15.4 Assessment Questions

- What is the product master source?
- Are product/category IDs consistent?
- How are product changes handled?
- What historical product data is available?

**Status:** 🟠 To Assess


# 16. DS-009 — Regional / Geographic Data

## 16.1 Source Overview

| Field | Details |
|---|---|
| Source ID | DS-009 |
| Source | Geographic / Business Master Data |
| Owner | Business / Data Team |
| Purpose | Regional performance analysis |
| Status | 🟠 To Assess |

## 16.2 Required Data

| Data Element | Usage |
|---|---|
| Region ID | Regional reporting |
| Region Name | Dashboard |
| State | Geographic analysis |
| City | Detailed analysis |
| Customer/Store Mapping | Regional attribution |

## 16.3 KPI Relationship

Regional filtering for:

- Revenue
- Campaign Sales
- ROAS
- CAC
- AOV
- Conversion Rate

## 16.4 Assessment Questions

- What is the authoritative geography master?
- How are customers/orders mapped to regions?
- How are changes in geography handled?

**Status:** 🟠 To Assess


# 17. DS-010 — Marketing Budget Data

## 17.1 Source Overview

| Field | Details |
|---|---|
| Source ID | DS-010 |
| Source | Marketing / Finance Budget Data |
| Owner | Marketing / Finance |
| Purpose | Budget vs actual analysis |
| Status | 🟠 To Assess |

## 17.2 Required Data

| Data Element | Usage |
|---|---|
| Budget Amount | Budget comparison |
| Budget Period | Time reporting |
| Channel | Channel budget |
| Campaign | Campaign budget |
| Region | Regional budget |
| Cost Category | Spend classification |

## 17.3 KPI / Reporting Relationship

Used for:

- Budget vs Actual Spend
- Channel performance
- Campaign performance
- Executive reporting

## 17.4 Assessment Questions

- Who owns the approved budget?
- At what level is budget allocated?
- How frequently is budget revised?
- How are budget changes recorded?
- What historical budget data is available?

**Status:** 🟠 To Assess