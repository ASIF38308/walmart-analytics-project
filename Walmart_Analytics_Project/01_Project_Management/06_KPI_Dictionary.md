# KPI Dictionary

## Walmart Centralized Analytics Platform

**Document:** KPI Dictionary
**Project:** Walmart Centralized Analytics Platform
**Version:** 1.0
**Status:** Working Document
**Last Updated:** August 2026
**Document Owner:** Business Analyst

---

## 1. Purpose

This document defines the business meaning, calculation methodology, data ownership, business rules, reporting requirements, and approval status for key metrics used in the Walmart Centralized Analytics Platform.

The purpose of the KPI Dictionary is to establish a **single, consistent definition for each KPI** across Marketing, Finance, Product, and Data/BI teams.

This document will be maintained as a **living project artefact** throughout the project lifecycle.

---

## 2. KPI Status Definitions

| Status          | Meaning                                            |
| --------------- | -------------------------------------------------- |
| 🟡 Draft        | Initial definition; stakeholder review required    |
| 🟠 Under Review | Definition is being discussed or validated         |
| 🟢 Agreed       | Stakeholders have agreed on the working definition |
| 🔵 Approved     | Formal business approval completed                 |
| 🔴 Deprecated   | Definition is no longer used                       |

---

# 3. KPI Definitions

---

## KPI-001 — Revenue

### 3.1 KPI Overview

| Field                    | Definition                                        |
| ------------------------ | ------------------------------------------------- |
| **KPI ID**               | KPI-001                                           |
| **KPI Name**             | Revenue                                           |
| **Category**             | Financial / Business Performance                  |
| **Business Owner**       | Finance                                           |
| **Primary Stakeholders** | Finance, Marketing, Product, Executive Leadership |
| **Status**               | 🟢 Agreed                                         |
| **Approval Authority**   | Finance                                           |

### 3.2 Business Definition

**Revenue** represents the sales revenue recognized by Finance from valid customer transactions after applicable cancellations, refunds, returns, and other approved financial adjustments.

This is the **official financial revenue figure** used for business reporting.

### 3.3 Business Question

> **How much recognized sales revenue did Walmart generate during the reporting period?**

### 3.4 Calculation

**Official Revenue = Finance-recognized revenue**

Revenue should be sourced from the approved Finance-recognized financial figure rather than reconstructed independently from marketing or order-level metrics.

### 3.5 Numerator

Not applicable.

Revenue is itself the recognized financial amount rather than a ratio.

### 3.6 Denominator

Not applicable.

### 3.7 Primary Source

**Finance**

### 3.8 Source of Truth

Finance-recognized financial data.

The Central Analytics Layer will consume and present the approved Finance figure.

### 3.9 Business Rules

1. Cancelled transactions are excluded from recognized revenue.
2. Applicable refunds are reflected in recognized revenue.
3. Applicable returns are reflected in recognized revenue.
4. Other Finance-approved financial adjustments must be reflected according to Finance's accounting treatment.
5. Marketing campaign attribution must not redefine the official Revenue KPI.
6. Campaign-Attributed Sales must remain a separate analytical KPI.
7. Preliminary and finalized financial data should be distinguishable where applicable.

### 3.10 Dimensions / Filters

Revenue should be available for analysis by:

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Region
* Product
* Product Category
* Customer Segment
* Store, where applicable

### 3.11 Reporting Frequency

**Daily availability**, subject to Finance data availability and reconciliation status.

### 3.12 Dashboard Placement

* Executive Dashboard: ✅
* Marketing Dashboard: ✅
* Product Analytics Dashboard: ✅

### 3.13 Data/BI Responsibility

Data/BI is responsible for:

* Extracting the approved Finance data
* Transforming it where required
* Validating data completeness
* Maintaining consistent reporting logic
* Presenting the metric in dashboards

Data/BI does **not** redefine the Finance business definition.

### 3.14 Data Status

Where applicable, financial data should be identified as:

* Preliminary
* Finalized

### 3.15 Notes

Revenue and Campaign-Attributed Sales are intentionally maintained as separate KPIs because they answer different business questions.

---

# KPI-002 — Campaign-Attributed Sales

### 4.1 KPI Overview

| Field                    | Definition                           |
| ------------------------ | ------------------------------------ |
| **KPI ID**               | KPI-002                              |
| **KPI Name**             | Campaign-Attributed Sales            |
| **Category**             | Marketing Performance                |
| **Business Owner**       | Marketing                            |
| **Financial Validation** | Finance                              |
| **Primary Stakeholders** | Marketing, Finance, Product, Data/BI |
| **Status**               | 🟢 Agreed                            |
| **Approval Authority**   | Marketing, with Finance validation   |

### 4.2 Business Definition

**Campaign-Attributed Sales** represents the eligible sales value attributed to the marketing campaign that generated the customer's **final qualifying marketing interaction before conversion**, using the approved Phase 1 attribution methodology.

### 4.3 Business Question

> **How much eligible sales value can be attributed to a specific marketing campaign?**

### 4.4 Calculation

**Campaign-Attributed Sales = Sum of eligible sales attributed to a campaign using Last-Touch Attribution**

### 4.5 Numerator

**Eligible sales value after applicable:**

* Cancellations
* Refunds
* Returns
* Other approved adjustments

### 4.6 Denominator

Not applicable.

### 4.7 Attribution Model

**Phase 1: Last-Touch Attribution**

The campaign associated with the customer's final qualifying marketing interaction before conversion receives the campaign attribution.

### 4.8 Primary Sources

* Marketing campaign/platform data
* Customer data
* Transaction/order data
* Finance-recognized financial adjustments, where applicable

### 4.9 Source of Truth

The **Central Analytics Layer** will calculate Campaign-Attributed Sales using approved source data and the agreed attribution methodology.

### 4.10 Business Rules

1. Phase 1 will use **Last-Touch Attribution**.
2. The final qualifying marketing interaction before conversion receives campaign credit.
3. Cancelled transactions are excluded.
4. Applicable refunds reduce eligible sales value.
5. Applicable returns reduce eligible sales value.
6. Other approved financial adjustments must be reflected according to the agreed financial treatment.
7. Campaign-Attributed Sales must not be labelled or treated as the official Finance Revenue KPI.
8. Campaign attribution does not determine whether a customer is classified as a new customer.
9. A customer may interact with multiple campaigns before purchasing, but Phase 1 will assign campaign credit according to the Last-Touch methodology.
10. Multi-Touch Attribution is considered a future enhancement and is not part of the Phase 1 implementation.

### 4.11 Dimensions / Filters

Campaign-Attributed Sales should be available by:

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Region
* Product
* Product Category
* Customer Segment

### 4.12 Reporting Frequency

**Daily**

Subject to source-data availability.

### 4.13 Dashboard Placement

* Executive Dashboard: ❌
* Marketing Dashboard: ✅
* Product Analytics Dashboard: ✅

### 4.14 Data/BI Responsibility

Data/BI is responsible for:

* Implementing the attribution logic
* Applying the approved business rules
* Integrating relevant source data
* Validating the calculated results
* Maintaining consistent attribution logic across dashboards

### 4.15 Marketing Responsibility

Marketing is responsible for:

* Defining campaign classification
* Confirming campaign business requirements
* Validating campaign attribution logic from a business perspective

### 4.16 Finance Responsibility

Finance is responsible for:

* Validating the financial treatment of refunds, returns, cancellations, and other applicable adjustments
* Confirming that the metric does not conflict with the official Finance Revenue definition

### 4.17 Future Enhancement

**Multi-Touch Attribution**

Multi-touch attribution may be considered in a future phase after the Phase 1 Last-Touch implementation has been validated.

### 4.18 Important Distinction

| KPI                           | Purpose                                              |
| ----------------------------- | ---------------------------------------------------- |
| **Revenue**                   | Official Finance-recognized financial revenue        |
| **Campaign-Attributed Sales** | Eligible sales value assigned to marketing campaigns |

These metrics should not be treated as interchangeable even when their values may be similar.

---

# 5. KPI Approval & Change Control

KPI definitions documented in this file are treated as working requirements until formally approved.

Any future change to:

* Formula
* Definition
* Attribution methodology
* Data source
* Business rules
* Ownership

must be documented as a requirement change and assessed for its impact on:

* SQL logic
* Data models
* Dashboards
* Historical reporting
* UAT test cases
* Stakeholder communication

---

## 6. Change Log

| Version | Date        | KPI     | Change                                                         | Status |
| ------- | ----------- | ------- | -------------------------------------------------------------- | ------ |
| 1.0     | August 2026 | KPI-001 | Initial agreed Revenue definition documented                   | 🟢     |
| 1.0     | August 2026 | KPI-002 | Initial agreed Campaign-Attributed Sales definition documented | 🟢     |

---
# KPI-003 — Marketing Spend

## 5.1 KPI Overview

| Field                    | Definition                                                                    |
| ------------------------ | ----------------------------------------------------------------------------- |
| **KPI ID**               | KPI-003                                                                       |
| **KPI Name**             | Marketing Spend                                                               |
| **Category**             | Marketing / Financial Performance                                             |
| **Business Owner**       | Finance for financial reporting; Marketing for operational campaign reporting |
| **Financial Validation** | Finance                                                                       |
| **Primary Stakeholders** | Marketing, Finance, Data/BI                                                   |
| **Status**               | 🟢 Agreed                                                                     |
| **Approval Authority**   | Finance for financial treatment; Marketing for operational campaign spend     |

---

## 5.2 Business Definition

Marketing Spend represents the cost incurred or reported for marketing activities during the reporting period.

For this project, we will distinguish between **three related but different concepts**:

1. **Marketing Budget** — the amount planned or allocated for marketing activity.
2. **Platform Spend** — the amount reported by marketing advertising platforms for campaign activity.
3. **Finance-Recognized Marketing Cost** — the marketing cost recognized by Finance for financial reporting.

These values must not be treated as interchangeable.

---

## 5.3 Business Questions

### Primary Question

> **How much did Walmart spend on marketing during the reporting period?**

### Operational Question

> **How much did we spend on each campaign or marketing channel according to the marketing platforms?**

### Financial Question

> **How much marketing cost has Finance officially recognized for financial reporting?**

---

## 5.4 KPI Components

### A. Marketing Budget

**Definition:**

The planned amount allocated to a marketing campaign, channel, or marketing activity.

**Purpose:**

Used for:

* Budget planning
* Budget monitoring
* Planned vs actual analysis
* Campaign allocation decisions

**Important:**

Budget is **not an expense** and should not be used as actual spend in ROAS, ROI, or CAC calculations unless explicitly approved for a planning metric.

---

### B. Platform Spend

**Definition:**

Advertising spend reported by the relevant marketing or advertising platform for campaign activity.

**Purpose:**

Primarily used for operational campaign optimisation.

**Examples of possible platform sources:**

* Search advertising platforms
* Social media advertising platforms
* Display advertising platforms
* Other paid media platforms

**Primary Owner:**

Marketing

---

### C. Finance-Recognized Marketing Cost

**Definition:**

Marketing-related costs recognized by Finance according to the organization's financial treatment and accounting rules.

Potential components may include, where applicable and approved:

* Advertising/platform costs
* Agency fees
* Creative costs
* Direct campaign costs
* Other directly attributable marketing expenses

The exact treatment must be confirmed and approved by Finance.

**Primary Owner:**

Finance

---

## 5.5 Formula

### Operational Marketing Spend

**Operational Spend = Platform-reported campaign spend**

### Financial Marketing Cost

**Financial Marketing Cost = Finance-recognized eligible marketing costs**

### Budget Variance

Where required:

**Budget Variance = Actual Spend − Marketing Budget**

### Budget Utilization

Where required:

**Budget Utilization % = Actual Spend ÷ Marketing Budget × 100**

---

## 5.6 Numerator / Denominator

### Operational Spend

Not applicable.

Platform spend is an absolute monetary amount.

### Financial Marketing Cost

Not applicable.

Finance-recognized marketing cost is an absolute monetary amount.

### Budget Utilization

**Numerator:** Actual Spend

**Denominator:** Marketing Budget

---

## 5.7 Primary Sources

### Marketing Budget

Marketing planning/budgeting data.

### Platform Spend

Marketing advertising platforms.

### Finance-Recognized Marketing Cost

Finance financial systems.

---

## 5.8 Source of Truth

The source of truth depends on the purpose of the metric:

| Metric                            | Source of Truth           |
| --------------------------------- | ------------------------- |
| Marketing Budget                  | Approved Marketing Budget |
| Platform Spend                    | Marketing Platform        |
| Finance-Recognized Marketing Cost | Finance                   |

The Central Analytics Layer will bring these sources together for reporting.

---

## 5.9 Business Rules

1. Budget must not be treated as actual spend.
2. Platform Spend and Finance-Recognized Marketing Cost must remain separate metrics.
3. Operational campaign analysis should primarily use Platform Spend.
4. Financial reporting should use Finance-recognized marketing cost.
5. Agency fees, creative costs, discounts, and other campaign-related expenses should only be included in Finance-recognized marketing cost when approved by Finance.
6. Campaign-funded discounts must follow the agreed classification and financial treatment.
7. Marketing and Finance must agree on the treatment of directly attributable campaign costs before they are included in financial calculations.
8. Spend must be associated with the appropriate reporting period.
9. Missing or invalid spend records must be flagged during data validation.
10. Currency and financial treatment must follow the approved Finance source.
11. Budget changes made after campaign launch should be tracked rather than silently replacing the original budget.
12. Any change to the financial definition of Marketing Spend must go through the project's change-control process.

---

## 5.10 Dimensions / Filters

Marketing Spend should be available by:

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Region
* Product Category
* Customer Segment
* Marketing Platform

Where the source data supports the dimension.

---

## 5.11 Reporting Frequency

**Daily operational reporting**

Finance-recognized marketing cost may have a different reconciliation/finalization schedule.

Therefore the dashboard should distinguish between:

* Preliminary financial data
* Finalized financial data

where applicable.

---

## 5.12 Dashboard Placement

| Metric                            | Executive Dashboard | Marketing Dashboard | Product Dashboard |
| --------------------------------- | ------------------: | ------------------: | ----------------: |
| Marketing Budget                  |                   ✅ |                   ✅ |                 ❌ |
| Platform Spend                    |                   ✅ |                   ✅ |  ✅ where relevant |
| Finance-Recognized Marketing Cost |                   ✅ |                   ✅ |       ❌ initially |

---

## 5.13 Data/BI Responsibility

Data/BI is responsible for:

* Integrating the relevant spend sources
* Maintaining separate definitions for Budget, Platform Spend, and Finance Cost
* Applying approved transformations
* Validating totals against source systems
* Identifying discrepancies
* Maintaining consistent reporting logic
* Communicating data-quality issues to the relevant owner

Data/BI must not independently decide whether a cost should receive financial treatment.

---

## 5.14 Marketing Responsibility

Marketing is responsible for:

* Providing campaign budget information
* Validating campaign/platform spend
* Defining operational campaign requirements
* Confirming campaign classifications
* Reviewing campaign-level spend reporting

---

## 5.15 Finance Responsibility

Finance is responsible for:

* Defining and validating Finance-recognized marketing cost
* Determining financial treatment of eligible marketing expenses
* Validating financial totals
* Confirming treatment of agency, creative, campaign, discount, refund, and other applicable costs
* Providing final approval for financial reporting methodology

---

## 5.16 Relationship With Other KPIs

Marketing Spend will be used as an input to several other KPIs.

### Operational ROAS

**Campaign-Attributed Sales ÷ Platform Spend**

### Financial ROAS

**Campaign-Attributed Sales ÷ Finance-Recognized Marketing Cost**

### ROI

Marketing investment/cost component will use the Finance-approved cost definition.

### CAC

Acquisition cost component will use the agreed Finance-recognized acquisition-cost definition.

Therefore, changing the definition of Marketing Spend may affect multiple downstream KPIs.

---

## 5.17 Important Distinction

| Concept                               | Meaning                                 | Primary Use           |
| ------------------------------------- | --------------------------------------- | --------------------- |
| **Marketing Budget**                  | Planned allocation                      | Planning              |
| **Platform Spend**                    | Spend reported by advertising platforms | Campaign optimisation |
| **Finance-Recognized Marketing Cost** | Financially recognized marketing cost   | Financial reporting   |

These should **not be combined into one generic "Marketing Spend" field** without identifying which definition is being used.

---

## 5.18 Status

🟢 **Agreed — working definition**

**Financial cost components remain subject to Finance validation where specific expense classifications have not yet been formally approved.**

---

# 5.19 Change Log

| Version | Date        | Change                                       | Status |
| ------- | ----------- | -------------------------------------------- | ------ |
| 1.0     | August 2026 | Initial Marketing Spend framework documented | 🟢     |


# KPI-004 — Operational ROAS

## 6.1 KPI Overview

| Field                    | Definition                                             |
| ------------------------ | ------------------------------------------------------ |
| **KPI ID**               | KPI-004                                                |
| **KPI Name**             | Operational ROAS                                       |
| **Category**             | Marketing Performance                                  |
| **Business Owner**       | Marketing                                              |
| **Financial Validation** | Finance validates the sales treatment where applicable |
| **Primary Stakeholders** | Marketing, Finance, Data/BI                            |
| **Status**               | 🟢 Agreed                                              |
| **Approval Authority**   | Marketing                                              |

---

## 6.2 Business Definition

**Operational ROAS (Return on Ad Spend)** measures how much eligible campaign-attributed sales value is generated for every unit of advertising spend reported by the marketing platform.

It is intended primarily for **campaign optimisation and operational marketing decisions**.

---

## 6.3 Business Question

> **How efficiently is our advertising platform spend generating campaign-attributed sales?**

---

## 6.4 Formula

**Operational ROAS = Campaign-Attributed Sales ÷ Platform Spend**

Example:

If:

* Campaign-Attributed Sales = ₹10,00,000
* Platform Spend = ₹2,00,000

Then:

**Operational ROAS = 5.0**

This means the campaign generated **₹5 of attributed sales for every ₹1 of platform advertising spend**.

---

## 6.5 Numerator

**Campaign-Attributed Sales**

The numerator uses the approved KPI-002 definition:

> Eligible sales value after applicable cancellations, refunds, returns, and approved adjustments, attributed using the Phase 1 Last-Touch Attribution methodology.

---

## 6.6 Denominator

**Platform Spend**

The denominator uses the operational spend reported by the relevant marketing platform.

It does **not** use Finance-recognized total marketing costs.

---

## 6.7 Primary Sources

### Numerator

* Campaign data
* Customer data
* Transaction/order data
* Approved financial adjustment data

### Denominator

* Marketing advertising platform spend data

---

## 6.8 Source of Truth

The Central Analytics Layer will calculate Operational ROAS using:

* Approved Campaign-Attributed Sales
* Approved Platform Spend
* Approved Last-Touch Attribution logic

---

## 6.9 Business Rules

1. Campaign-Attributed Sales must follow the approved Phase 1 **Last-Touch Attribution** methodology.
2. Platform Spend must come from the approved marketing platform source.
3. Finance-recognized marketing costs must not be included in Operational ROAS.
4. Cancelled transactions must not contribute to Campaign-Attributed Sales.
5. Applicable refunds and returns must reduce eligible Campaign-Attributed Sales.
6. If Platform Spend is zero or unavailable, Operational ROAS should return **NULL / Not Available**, not an artificially high value.
7. Spend and attributed sales must use the same reporting period.
8. Campaign-level calculations should be aggregated correctly before calculating overall ROAS.
9. Operational ROAS should not be interpreted as Finance's official profitability measure.
10. Changes to the attribution methodology require KPI change control and impact assessment.

---

## 6.10 Aggregation Rule

When reporting ROAS across multiple campaigns or channels:

**Do not simply average individual campaign ROAS values.**

Instead:

**Overall Operational ROAS = Total Campaign-Attributed Sales ÷ Total Platform Spend**

This prevents small campaigns from receiving the same mathematical weight as very large campaigns.

---

## 6.11 Dimensions / Filters

Operational ROAS should be available by:

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Marketing Platform
* Region
* Product Category
* Customer Segment

---

## 6.12 Reporting Frequency

**Daily**

Subject to campaign platform data availability.

---

## 6.13 Dashboard Placement

| Dashboard                   |       Include? |
| --------------------------- | -------------: |
| Executive Dashboard         |              ❌ |
| Marketing Dashboard         |              ✅ |
| Product Analytics Dashboard | Where relevant |
| Finance Dashboard           |              ❌ |

Operational ROAS should primarily be used by Marketing for campaign optimisation.

---

## 6.14 Data/BI Responsibility

Data/BI is responsible for:

* Implementing the calculation
* Integrating campaign and platform spend data
* Applying the approved attribution methodology
* Validating numerator and denominator
* Monitoring missing/zero spend
* Ensuring consistent calculation across dashboards

---

## 6.15 Marketing Responsibility

Marketing is responsible for:

* Campaign classification
* Campaign performance interpretation
* Validating campaign attribution
* Using Operational ROAS for campaign optimisation
* Identifying campaigns requiring investigation or budget changes

---

## 6.16 Finance Responsibility

Finance is responsible for:

* Validating the financial treatment of Campaign-Attributed Sales where required
* Ensuring Operational ROAS is not presented as the official financial profitability metric

---

## 6.17 Relationship With Other KPIs

Operational ROAS directly depends on:

**KPI-002 — Campaign-Attributed Sales**

and

**KPI-003 — Platform Spend**

It should therefore be treated as a **derived KPI** rather than an independent source metric.

```text
Campaign-Attributed Sales
            +
      Platform Spend
            ↓
     Operational ROAS
```

---

## 6.18 Difference From Financial ROAS

| Metric               | Numerator                 | Denominator                       | Primary Purpose                 |
| -------------------- | ------------------------- | --------------------------------- | ------------------------------- |
| **Operational ROAS** | Campaign-Attributed Sales | Platform Spend                    | Campaign optimisation           |
| **Financial ROAS**   | Campaign-Attributed Sales | Finance-Recognized Marketing Cost | Financial / executive reporting |

These metrics must not be combined or labelled simply as "ROAS" without identifying the methodology.

---

## 6.19 Status

🟢 **Agreed**

---

# 6.20 Change Log

| Version | Date        | Change                                         | Status |
| ------- | ----------- | ---------------------------------------------- | ------ |
| 1.0     | August 2026 | Initial Operational ROAS definition documented | 🟢     |


# KPI-005 — Financial ROAS

## 7.1 KPI Overview

| Field                       | Definition                                        |
| --------------------------- | ------------------------------------------------- |
| **KPI ID**                  | KPI-005                                           |
| **KPI Name**                | Financial ROAS                                    |
| **Category**                | Financial / Marketing Performance                 |
| **Business Owner**          | Finance                                           |
| **Operational Stakeholder** | Marketing                                         |
| **Financial Validation**    | Finance                                           |
| **Primary Stakeholders**    | Finance, Marketing, Data/BI, Executive Leadership |
| **Status**                  | 🟢 Agreed                                         |
| **Approval Authority**      | Finance                                           |

---

## 7.2 Business Definition

**Financial ROAS (Return on Ad Spend)** measures the amount of eligible campaign-attributed sales generated relative to the **Finance-recognized marketing cost** associated with those activities.

Unlike Operational ROAS, Financial ROAS considers the financially recognized cost base rather than only advertising-platform spend.

It is intended primarily for **financial evaluation and executive reporting**.

---

## 7.3 Business Question

> **How much eligible campaign-attributed sales value did Walmart generate relative to the marketing costs recognized by Finance?**

---

## 7.4 Formula

**Financial ROAS = Campaign-Attributed Sales ÷ Finance-Recognized Marketing Cost**

Example:

If:

* Campaign-Attributed Sales = ₹10,00,000
* Finance-Recognized Marketing Cost = ₹2,50,000

Then:

**Financial ROAS = 4.0**

This means Walmart generated **₹4 of eligible campaign-attributed sales for every ₹1 of Finance-recognized marketing cost**.

---

## 7.5 Numerator

**Campaign-Attributed Sales**

The numerator uses the approved KPI-002 definition:

> Eligible sales value after applicable cancellations, refunds, returns, and approved adjustments, attributed using the Phase 1 Last-Touch Attribution methodology.

---

## 7.6 Denominator

**Finance-Recognized Marketing Cost**

The denominator uses the approved Finance treatment of marketing costs.

Potential cost components may include, where Finance approves them:

* Advertising/platform costs
* Agency fees
* Creative costs
* Direct campaign-related expenses
* Other eligible marketing costs

The exact financial treatment of each cost category must be approved by Finance.

---

## 7.7 Primary Sources

### Numerator

* Marketing campaign data
* Customer data
* Transaction/order data
* Approved financial adjustment data

### Denominator

* Finance financial system
* Approved Finance marketing-cost data

---

## 7.8 Source of Truth

The **Central Analytics Layer** will calculate Financial ROAS using:

* Approved Campaign-Attributed Sales
* Finance-recognized marketing cost
* Approved attribution methodology
* Finance-approved cost classification

Finance remains the owner of the financial cost definition.

---

## 7.9 Business Rules

1. Campaign-Attributed Sales must follow the approved Phase 1 **Last-Touch Attribution** methodology.
2. The denominator must use **Finance-recognized marketing cost**, not simply platform-reported advertising spend.
3. Only costs approved by Finance should be included in the denominator.
4. Cancelled transactions must not contribute to Campaign-Attributed Sales.
5. Applicable refunds and returns must reduce eligible Campaign-Attributed Sales.
6. Campaign-funded discounts must follow the approved Finance treatment.
7. Agency, creative, and other campaign-related costs should only be included when Finance confirms they are part of the recognized marketing-cost definition.
8. If Finance-recognized marketing cost is zero or unavailable, Financial ROAS should return **NULL / Not Available**.
9. Numerator and denominator must follow the same reporting period or an explicitly approved financial-period alignment.
10. Financial ROAS must not be calculated using Budget instead of actual recognized cost.
11. Financial ROAS must not be treated as interchangeable with Operational ROAS.
12. Changes to the financial cost methodology require Finance approval and formal change control.

---

## 7.10 Aggregation Rule

When calculating Financial ROAS across multiple campaigns, channels, or regions:

**Financial ROAS = Total Campaign-Attributed Sales ÷ Total Finance-Recognized Marketing Cost**

Individual campaign ROAS values should not simply be averaged to produce an overall Financial ROAS.

---

## 7.11 Dimensions / Filters

Financial ROAS should be available, where source data supports it, by:

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Region
* Product Category
* Customer Segment

Financial reporting may additionally require:

* Financial Period
* Cost Category
* Cost Centre
* Business Unit

---

## 7.12 Reporting Frequency

**Daily availability where data is available.**

However, Finance-recognized costs may have a reconciliation or closing process.

Therefore the dashboard should distinguish between:

* Preliminary
* Finalized

financial figures where applicable.

---

## 7.13 Dashboard Placement

| Dashboard                   |    Include? |
| --------------------------- | ----------: |
| Executive Dashboard         |           ✅ |
| Marketing Dashboard         |           ✅ |
| Product Analytics Dashboard | ❌ Initially |
| Finance Dashboard           |           ✅ |

### Executive Reporting

**Financial ROAS should be the primary ROAS metric shown to executive leadership** because it uses the Finance-recognized cost basis.

### Marketing Reporting

Marketing may see both:

* Operational ROAS
* Financial ROAS

This allows Marketing to compare campaign-platform efficiency with the broader financial view.

---

## 7.14 Data/BI Responsibility

Data/BI is responsible for:

* Integrating Finance-recognized marketing costs
* Applying the approved cost classification
* Applying campaign attribution logic
* Calculating Financial ROAS
* Validating numerator and denominator
* Reconciling totals against Finance
* Monitoring missing or delayed financial data
* Maintaining consistent calculation across dashboards

Data/BI must not independently determine whether a cost belongs in the Finance-recognized cost base.

---

## 7.15 Finance Responsibility

Finance is responsible for:

* Defining recognized marketing costs
* Approving cost classifications
* Validating financial totals
* Confirming treatment of agency fees, creative costs, discounts and other applicable expenses
* Reviewing Financial ROAS methodology
* Providing final approval for the financial definition

---

## 7.16 Marketing Responsibility

Marketing is responsible for:

* Validating campaign attribution
* Reviewing campaign-level Financial ROAS
* Comparing Financial ROAS with Operational ROAS
* Using the metric to understand broader campaign economics

---

## 7.17 Relationship With Other KPIs

Financial ROAS depends directly on:

**KPI-002 — Campaign-Attributed Sales**

and

**KPI-003 — Finance-Recognized Marketing Cost**

```text
Campaign-Attributed Sales
            +
Finance-Recognized Marketing Cost
            ↓
      Financial ROAS
```

---

## 7.18 Operational ROAS vs Financial ROAS

| Attribute           | Operational ROAS                        | Financial ROAS                    |
| ------------------- | --------------------------------------- | --------------------------------- |
| **KPI ID**          | KPI-004                                 | KPI-005                           |
| Numerator           | Campaign-Attributed Sales               | Campaign-Attributed Sales         |
| Denominator         | Platform Spend                          | Finance-Recognized Marketing Cost |
| Primary Owner       | Marketing                               | Finance                           |
| Primary Purpose     | Campaign optimisation                   | Financial evaluation              |
| Executive Dashboard | ❌                                       | ✅                                 |
| Marketing Dashboard | ✅                                       | ✅                                 |
| Cost Basis          | Platform-reported                       | Finance-recognized                |
| Financial Approval  | Not required for operational definition | Required                          |

---

## 7.19 Status

🟢 **Agreed — working definition**

The exact list of Finance-recognized marketing-cost components remains subject to formal Finance validation.

---

# 7.20 Change Log

| Version | Date        | Change                                       | Status |
| ------- | ----------- | -------------------------------------------- | ------ |
| 1.0     | August 2026 | Initial Financial ROAS definition documented | 🟢     |

# KPI-006 — ROI

## 8.1 KPI Overview

| Field                       | Definition                                        |
| --------------------------- | ------------------------------------------------- |
| **KPI ID**                  | KPI-006                                           |
| **KPI Name**                | Return on Investment (ROI)                        |
| **Category**                | Financial Performance                             |
| **Business Owner**          | Finance                                           |
| **Operational Stakeholder** | Marketing                                         |
| **Financial Validation**    | Finance                                           |
| **Primary Stakeholders**    | Finance, Marketing, Data/BI, Executive Leadership |
| **Status**                  | 🟠 Under Review                                   |
| **Approval Authority**      | Finance                                           |

---

## 8.2 Business Definition

**Return on Investment (ROI)** measures the financial return generated relative to the investment or cost incurred to generate that return.

For this project, the official ROI methodology will be based on the **Finance-approved definition of investment and return**.

Unlike ROAS, ROI is intended to evaluate the broader financial return relative to the applicable investment rather than simply comparing sales against advertising spend.

---

## 8.3 Business Question

> **Did the financial return generated by the marketing activity justify the investment made?**

---

## 8.4 Proposed Formula

The initial proposed methodology is:

**ROI % = (Return − Investment) ÷ Investment × 100**

However, the exact definitions of **Return** and **Investment** must be confirmed by Finance before this KPI is marked Approved.

---

## 8.5 Return Component

The return component may use the applicable financial return generated by the marketing activity.

For the centralized analytics project, the initial candidate is:

**Eligible Campaign-Attributed Sales**

However, Finance must confirm whether sales/revenue or a profit-based measure should be used as the return component.

---

## 8.6 Investment Component

The investment component should be based on the **Finance-approved marketing investment/cost definition**.

Potential components may include:

* Advertising/platform spend
* Agency fees
* Creative costs
* Direct campaign costs
* Campaign-funded discounts
* Other directly attributable campaign expenses

These costs should **not automatically be included**.

Finance must determine which costs qualify as part of the investment component.

---

## 8.7 Primary Sources

### Return

Potential sources:

* Marketing campaign data
* Transaction/order data
* Customer data
* Finance-recognized revenue/adjustment data

### Investment

Primary source:

* Finance-recognized marketing cost data

Supporting source:

* Marketing platform spend
* Campaign cost data
* Agency/creative cost data where applicable

---

## 8.8 Source of Truth

The **Finance-approved ROI methodology and Finance-recognized financial data** will be the source of truth for the official ROI KPI.

The Central Analytics Layer will implement the approved methodology.

---

## 8.9 Business Rules

1. ROI must not be treated as interchangeable with ROAS.
2. The investment component must use the Finance-approved cost definition.
3. Platform spend alone should not automatically be treated as the complete investment.
4. Agency fees, creative costs, discounts, and other campaign-related costs require Finance classification before inclusion.
5. Campaign-funded discounts must follow the agreed business and financial treatment.
6. The return component must be approved by Finance.
7. Cancelled transactions should not contribute to eligible returns.
8. Applicable refunds and returns must be reflected according to the approved financial treatment.
9. If the investment value is zero or unavailable, ROI should return **NULL / Not Available** rather than an invalid or misleading value.
10. ROI must be calculated using aligned reporting periods.
11. Any change to the ROI methodology requires Finance approval and formal change control.
12. Historical ROI values should be recalculated if the approved methodology changes and Finance determines that historical restatement is required.

---

## 8.10 ROI vs ROAS

| Attribute            | ROI                                                   | ROAS                                                   |
| -------------------- | ----------------------------------------------------- | ------------------------------------------------------ |
| **Purpose**          | Evaluate financial return relative to investment      | Evaluate sales generated relative to advertising spend |
| Return               | Finance-approved financial return                     | Campaign-Attributed Sales                              |
| Cost/Investment      | Finance-approved investment definition                | Platform Spend or Finance-recognized marketing cost    |
| Profit Consideration | Potentially included depending on Finance methodology | Generally sales/revenue-based                          |
| Primary Use          | Financial evaluation                                  | Marketing performance                                  |
| Owner                | Finance                                               | Marketing / Finance depending on version               |

---

## 8.11 Dimensions / Filters

ROI should be available, where data supports the calculation, by:

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Region
* Product Category
* Customer Segment
* Financial Period
* Business Unit
* Cost Category

---

## 8.12 Reporting Frequency

**Daily availability where the required financial data is available.**

Finalized ROI may depend on Finance reconciliation and financial closing processes.

The dashboard should distinguish between:

* Preliminary
* Finalized

where applicable.

---

## 8.13 Dashboard Placement

| Dashboard                   |    Include? |
| --------------------------- | ----------: |
| Executive Dashboard         |           ✅ |
| Marketing Dashboard         |           ✅ |
| Product Analytics Dashboard | ❌ Initially |
| Finance Dashboard           |           ✅ |

ROI should be prominently available for executive and Finance reporting once the methodology receives formal approval.

---

## 8.14 Data/BI Responsibility

Data/BI is responsible for:

* Implementing the Finance-approved methodology
* Integrating required financial and marketing data
* Applying approved business rules
* Validating calculations
* Reconciling results with Finance
* Documenting calculation logic
* Maintaining consistent ROI logic across dashboards

Data/BI must not independently decide what constitutes financial return or investment.

---

## 8.15 Finance Responsibility

Finance is responsible for:

* Defining the official ROI methodology
* Defining the return component
* Defining the investment component
* Classifying eligible costs
* Validating financial treatment
* Approving the final formula
* Approving historical treatment if the methodology changes

---

## 8.16 Marketing Responsibility

Marketing is responsible for:

* Providing campaign context
* Validating campaign attribution
* Reviewing campaign-level ROI
* Explaining operational drivers behind ROI changes
* Using ROI alongside ROAS for campaign evaluation

---

## 8.17 Open Decisions

The following items require formal Finance confirmation:

### Decision 1 — Return

Should ROI use:

* Campaign-attributed sales/revenue
* Recognized revenue
* Contribution margin
* Profit
* Another Finance-approved return measure

### Decision 2 — Investment

Which costs should be included?

* Advertising/platform spend
* Agency fees
* Creative costs
* Campaign-funded discounts
* Other campaign-related expenses

### Decision 3 — Attribution

Should the return component use the same **Last-Touch Attribution** methodology used for Campaign-Attributed Sales?

### Decision 4 — Historical Treatment

If the ROI methodology changes later, should historical ROI values be recalculated?

---

## 8.18 Status

🟠 **Under Review**

The overall requirement for ROI is agreed, but the final Finance-approved methodology is still pending.

---

# 8.19 Change Log

| Version | Date        | Change                                                        | Status |
| ------- | ----------- | ------------------------------------------------------------- | ------ |
| 1.0     | August 2026 | Initial ROI framework documented; Finance methodology pending | 🟠     |

# KPI-007 — Customer Acquisition Cost (CAC)

## 9.1 KPI Overview

| Field                    | Definition                      |
| ------------------------ | ------------------------------- |
| **KPI ID**               | KPI-007                         |
| **KPI Name**             | Customer Acquisition Cost (CAC) |
| **Category**             | Marketing Performance           |
| **Business Owner**       | Finance                         |
| **Operational Owner**    | Marketing                       |
| **Primary Stakeholders** | Finance, Marketing, Data/BI     |
| **Status**               | 🟢 Agreed                       |

## 9.2 Business Definition

CAC measures the average cost required to acquire a **new Walmart customer** during the reporting period.

## 9.3 Business Question

> How much does Walmart spend to acquire one new customer?

## 9.4 Formula

**CAC = Finance-Recognized Acquisition Cost ÷ Number of New Customers**

## 9.5 New Customer Definition

A customer is considered **new** when they complete their **first-ever Walmart purchase**.

## 9.6 Business Rules

* Cancelled first purchases are excluded from the new-customer count.
* A customer whose first purchase is later fully cancelled/refunded is excluded from the acquisition count.
* A customer remains a new customer if their completed first purchase is subsequently returned, subject to the approved Finance treatment.
* Acquisition costs must use the Finance-approved cost definition.
* Platform spend alone should not automatically be treated as the official CAC cost.
* CAC should be calculated for the same reporting period as the acquisition cost and new-customer count.
* Zero or missing acquisition cost must return **NULL / Not Available**.

## 9.7 Source

| Component           | Source                      |
| ------------------- | --------------------------- |
| Acquisition Cost    | Finance                     |
| New Customers       | Customer + Transaction Data |
| Attribution/Channel | Marketing Data              |

## 9.8 Dimensions / Filters

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Region
* Customer Segment

## 9.9 Dashboard

| Dashboard |       Include? |
| --------- | -------------: |
| Executive |              ✅ |
| Marketing |              ✅ |
| Product   | Where relevant |
| Finance   |              ✅ |

## 9.10 Frequency

Daily, subject to source-data availability.

## 9.11 Ownership

**Finance:** acquisition-cost definition and financial validation.

**Marketing:** campaign/channel interpretation.

**Data/BI:** calculation, integration and validation.

## 9.12 Open Decision

Finance must confirm the final list of costs included in **Finance-Recognized Acquisition Cost**, such as:

* Advertising/platform spend
* Agency fees
* Creative costs
* Direct campaign costs
* Other eligible acquisition expenses

## 9.13 Status

🟢 **Agreed — cost components pending Finance confirmation**

---

# 9.14 Change Log

| Version | Date        | Change                            | Status |
| ------- | ----------- | --------------------------------- | ------ |
| 1.0     | August 2026 | Initial CAC definition documented | 🟢     |

# KPI-008 — Conversion Rate

## 10.1 KPI Overview

| Field                    | Definition                      |
| ------------------------ | ------------------------------- |
| **KPI ID**               | KPI-008                         |
| **KPI Name**             | Conversion Rate                 |
| **Category**             | Marketing / Product Performance |
| **Business Owner**       | Marketing / Product             |
| **Primary Stakeholders** | Marketing, Product, Data/BI     |
| **Status**               | 🟢 Agreed                       |

## 10.2 Business Definition

Conversion Rate measures the percentage of users who complete the defined conversion action from the relevant traffic population.

## 10.3 Business Question

> What percentage of users who reached the relevant stage completed a purchase?

## 10.4 Formula

### Website-Level Conversion Rate

**Completed Purchases ÷ Website Sessions × 100**

### Campaign-Level Conversion Rate

**Campaign-Attributed Conversions ÷ Campaign Clicks × 100**

## 10.5 Business Rules

* Website conversion uses **sessions** as the denominator.
* Campaign conversion uses **clicks** as the denominator.
* Completed purchases are used as the conversion event.
* Cancelled purchases are excluded.
* Attribution must follow the approved campaign attribution methodology.
* The reporting period for numerator and denominator must be aligned.
* Zero or missing denominator returns **NULL / Not Available**.

## 10.6 Source

| Component            | Source                  |
| -------------------- | ----------------------- |
| Website Sessions     | Web Analytics           |
| Campaign Clicks      | Marketing Platform      |
| Purchases            | Transaction Data        |
| Campaign Attribution | Central Analytics Layer |

## 10.7 Dimensions / Filters

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Region
* Product Category
* Customer Segment
* Device / Platform, where available

## 10.8 Dashboard

| Dashboard | Include? |
| --------- | -------: |
| Executive |        ✅ |
| Marketing |        ✅ |
| Product   |        ✅ |
| Finance   |        ❌ |

## 10.9 Frequency

Daily.

## 10.10 Ownership

**Marketing:** campaign performance.

**Product:** website/product conversion.

**Data/BI:** calculation and validation.

## 10.11 Status

🟢 **Agreed**

---

# 10.12 Change Log

| Version | Date        | Change                                                 | Status |
| ------- | ----------- | ------------------------------------------------------ | ------ |
| 1.0     | August 2026 | Campaign and website conversion definitions documented | 🟢     |

# KPI-008 — Conversion Rate

## 10.1 KPI Overview

| Field                    | Definition                      |
| ------------------------ | ------------------------------- |
| **KPI ID**               | KPI-008                         |
| **KPI Name**             | Conversion Rate                 |
| **Category**             | Marketing / Product Performance |
| **Business Owner**       | Marketing / Product             |
| **Primary Stakeholders** | Marketing, Product, Data/BI     |
| **Status**               | 🟢 Agreed                       |

## 10.2 Business Definition

Conversion Rate measures the percentage of users who complete the defined conversion action from the relevant traffic population.

## 10.3 Business Question

> What percentage of users who reached the relevant stage completed a purchase?

## 10.4 Formula

### Website-Level Conversion Rate

**Completed Purchases ÷ Website Sessions × 100**

### Campaign-Level Conversion Rate

**Campaign-Attributed Conversions ÷ Campaign Clicks × 100**

## 10.5 Business Rules

* Website conversion uses **sessions** as the denominator.
* Campaign conversion uses **clicks** as the denominator.
* Completed purchases are used as the conversion event.
* Cancelled purchases are excluded.
* Attribution must follow the approved campaign attribution methodology.
* The reporting period for numerator and denominator must be aligned.
* Zero or missing denominator returns **NULL / Not Available**.

## 10.6 Source

| Component            | Source                  |
| -------------------- | ----------------------- |
| Website Sessions     | Web Analytics           |
| Campaign Clicks      | Marketing Platform      |
| Purchases            | Transaction Data        |
| Campaign Attribution | Central Analytics Layer |

## 10.7 Dimensions / Filters

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Region
* Product Category
* Customer Segment
* Device / Platform, where available

## 10.8 Dashboard

| Dashboard | Include? |
| --------- | -------: |
| Executive |        ✅ |
| Marketing |        ✅ |
| Product   |        ✅ |
| Finance   |        ❌ |

## 10.9 Frequency

Daily.

## 10.10 Ownership

**Marketing:** campaign performance.

**Product:** website/product conversion.

**Data/BI:** calculation and validation.

## 10.11 Status

🟢 **Agreed**

---

# 10.12 Change Log

| Version | Date        | Change                                                 | Status |
| ------- | ----------- | ------------------------------------------------------ | ------ |
| 1.0     | August 2026 | Campaign and website conversion definitions documented | 🟢     |

# KPI-009 — Click-Through Rate (CTR)

## 11.1 KPI Overview

| Field                    | Definition               |
| ------------------------ | ------------------------ |
| **KPI ID**               | KPI-009                  |
| **KPI Name**             | Click-Through Rate (CTR) |
| **Category**             | Marketing Performance    |
| **Business Owner**       | Marketing                |
| **Primary Stakeholders** | Marketing, Data/BI       |
| **Status**               | 🟢 Agreed                |

## 11.2 Business Definition

CTR measures the percentage of ad impressions that result in a user click.

## 11.3 Business Question

> How effectively does a campaign or advertisement generate clicks from the impressions it receives?

## 11.4 Formula

**CTR = Clicks ÷ Impressions × 100**

## 11.5 Business Rules

* Use platform-reported clicks and impressions.
* Apply the standard definition consistently across channels where comparable.
* Any channel-specific exclusions or alternative definitions must be documented.
* Invalid, duplicate, or excluded traffic should follow the source platform's approved treatment.
* Zero or missing impressions returns **NULL / Not Available**.
* Numerator and denominator must cover the same reporting period.

## 11.6 Source

**Marketing / Advertising Platforms**

## 11.7 Dimensions / Filters

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Platform
* Region
* Customer Segment
* Ad / Creative, where available

## 11.8 Dashboard

| Dashboard | Include? |
| --------- | -------: |
| Executive |        ✅ |
| Marketing |        ✅ |
| Product   |        ❌ |
| Finance   |        ❌ |

## 11.9 Frequency

Daily.

## 11.10 Ownership

**Marketing:** metric interpretation and channel requirements.

**Data/BI:** integration, calculation and validation.

## 11.11 Open Decision

Confirm whether any **channel-specific CTR definitions or exclusions** are required.

## 11.12 Status

🟢 **Agreed — channel-specific exceptions pending confirmation**

---

# 11.13 Change Log

| Version | Date        | Change                            | Status |
| ------- | ----------- | --------------------------------- | ------ |
| 1.0     | August 2026 | Initial CTR definition documented | 🟢     |

# KPI-010 — Cost per Click (CPC)

## 12.1 KPI Overview

| Field                    | Definition                  |
| ------------------------ | --------------------------- |
| **KPI ID**               | KPI-010                     |
| **KPI Name**             | Cost per Click (CPC)        |
| **Category**             | Marketing Performance       |
| **Business Owner**       | Marketing                   |
| **Financial Validation** | Finance                     |
| **Primary Stakeholders** | Marketing, Finance, Data/BI |
| **Status**               | 🟢 Agreed                   |

## 12.2 Business Definition

CPC measures the average cost incurred for each click generated by a marketing campaign.

Two versions will be maintained:

* **Operational CPC** — for campaign optimisation.
* **Financial CPC** — using Finance-recognized marketing costs.

## 12.3 Business Question

> How much does each marketing click cost?

## 12.4 Formula

### Operational CPC

**Platform Spend ÷ Clicks**

### Financial CPC

**Finance-Recognized Marketing Cost ÷ Clicks**

## 12.5 Business Rules

* Operational CPC uses platform-reported spend.
* Financial CPC uses Finance-recognized marketing cost.
* Clicks must come from the approved marketing platform.
* Spend and clicks must use the same reporting period.
* Zero or missing clicks returns **NULL / Not Available**.
* Operational CPC is used for campaign optimisation.
* Financial CPC is used for financial analysis.
* The two metrics must not be combined under a single undefined "CPC".

## 12.6 Source

| Component               | Source             |
| ----------------------- | ------------------ |
| Platform Spend          | Marketing Platform |
| Clicks                  | Marketing Platform |
| Finance-Recognized Cost | Finance            |

## 12.7 Dimensions / Filters

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Platform
* Region
* Customer Segment

## 12.8 Dashboard

| Metric          | Executive | Marketing | Finance |
| --------------- | --------: | --------: | ------: |
| Operational CPC |         ❌ |         ✅ |       ❌ |
| Financial CPC   |         ✅ |         ✅ |       ✅ |

## 12.9 Frequency

Daily, subject to Finance data availability for Financial CPC.

## 12.10 Ownership

**Marketing:** Operational CPC.

**Finance:** Financial CPC cost definition.

**Data/BI:** Calculation and validation.

## 12.11 Status

🟢 **Agreed**

---

# 12.12 Change Log

| Version | Date        | Change                                               | Status |
| ------- | ----------- | ---------------------------------------------------- | ------ |
| 1.0     | August 2026 | Operational and Financial CPC definitions documented | 🟢     |

# KPI-011 — Average Order Value (AOV)

## 13.1 KPI Overview

| Field                    | Definition                           |
| ------------------------ | ------------------------------------ |
| **KPI ID**               | KPI-011                              |
| **KPI Name**             | Average Order Value (AOV)            |
| **Category**             | Sales / Product Performance          |
| **Business Owner**       | Finance / Product                    |
| **Primary Stakeholders** | Finance, Marketing, Product, Data/BI |
| **Status**               | 🟢 Agreed                            |

## 13.2 Business Definition

AOV measures the average recognized revenue generated per completed order.

## 13.3 Business Question

> What is the average revenue generated per completed order?

## 13.4 Formula

**AOV = Recognized Revenue ÷ Completed Orders**

## 13.5 Business Rules

* Use **recognized revenue** as the numerator.
* Use completed orders as the denominator.
* Cancelled orders are excluded.
* Fully refunded orders are excluded from completed-order count.
* Returns and partial refunds must follow Finance's approved revenue treatment.
* Revenue and orders must use the same reporting period.
* Zero or missing orders returns **NULL / Not Available**.

## 13.6 Source

| Component          | Source                     |
| ------------------ | -------------------------- |
| Recognized Revenue | Finance / Transaction Data |
| Completed Orders   | Order Data                 |

## 13.7 Dimensions / Filters

* Date
* Marketing Channel
* Campaign
* Region
* Product
* Product Category
* Customer Segment
* Store, where applicable

## 13.8 Dashboard

| Dashboard | Include? |
| --------- | -------: |
| Executive |        ✅ |
| Marketing |        ✅ |
| Product   |        ✅ |
| Finance   |        ✅ |

## 13.9 Frequency

Daily.

## 13.10 Ownership

**Finance:** Revenue treatment.

**Product/Marketing:** Business interpretation.

**Data/BI:** Calculation and validation.

## 13.11 Status

🟢 **Agreed**

---

# 13.12 Change Log

| Version | Date        | Change                            | Status |
| ------- | ----------- | --------------------------------- | ------ |
| 1.0     | August 2026 | Initial AOV definition documented | 🟢     |
# KPI-012 — Revenue per Visitor (RPV)

## 14.1 KPI Overview

| Field                    | Definition                      |
| ------------------------ | ------------------------------- |
| **KPI ID**               | KPI-012                         |
| **KPI Name**             | Revenue per Visitor (RPV)       |
| **Category**             | Marketing / Product Performance |
| **Business Owner**       | Marketing / Product             |
| **Primary Stakeholders** | Marketing, Product, Data/BI     |
| **Status**               | 🟢 Agreed                       |

## 14.2 Business Definition

Revenue per Visitor measures the average recognized revenue generated per **unique website visitor** during the reporting period.

## 14.3 Business Question

> How much recognized revenue does each unique website visitor generate on average?

## 14.4 Formula

**RPV = Recognized Revenue ÷ Unique Website Visitors**

## 14.5 Business Rules

* Use recognized revenue as the numerator.
* Use **unique visitors**, not sessions, as the denominator.
* Revenue and visitor data must cover the same reporting period.
* Campaign-level RPV uses campaign-attributed revenue and the approved attribution methodology.
* Zero or missing visitors returns **NULL / Not Available**.
* Visitor identification must follow the approved web-analytics methodology.

## 14.6 Source

| Component            | Source                     |
| -------------------- | -------------------------- |
| Recognized Revenue   | Finance / Transaction Data |
| Unique Visitors      | Web Analytics              |
| Campaign Attribution | Central Analytics Layer    |

## 14.7 Dimensions / Filters

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Region
* Customer Segment
* Device / Platform, where available

## 14.8 Dashboard

| Dashboard | Include? |
| --------- | -------: |
| Executive |        ✅ |
| Marketing |        ✅ |
| Product   |        ✅ |
| Finance   |        ❌ |

## 14.9 Frequency

Daily.

## 14.10 Ownership

**Marketing/Product:** Business interpretation.

**Finance:** Revenue treatment.

**Data/BI:** Calculation and validation.

## 14.11 Status

🟢 **Agreed**

---

# 14.12 Change Log

| Version | Date        | Change                                            | Status |
| ------- | ----------- | ------------------------------------------------- | ------ |
| 1.0     | August 2026 | Initial Revenue per Visitor definition documented | 🟢     |
# KPI-013 — Revenue per Session (RPS)

## 15.1 KPI Overview

| Field                    | Definition                      |
| ------------------------ | ------------------------------- |
| **KPI ID**               | KPI-013                         |
| **KPI Name**             | Revenue per Session (RPS)       |
| **Category**             | Marketing / Product Performance |
| **Business Owner**       | Marketing / Product             |
| **Primary Stakeholders** | Marketing, Product, Data/BI     |
| **Status**               | 🟢 Agreed                       |

## 15.2 Business Definition

Revenue per Session measures the average recognized revenue generated per website session during the reporting period.

## 15.3 Business Question

> How much recognized revenue is generated, on average, per website session?

## 15.4 Formula

**RPS = Recognized Revenue ÷ Website Sessions**

## 15.5 Business Rules

* Use recognized revenue as the numerator.
* Use website sessions as the denominator.
* Revenue and sessions must cover the same reporting period.
* Campaign-level RPS should use campaign-attributed revenue where applicable.
* Campaign attribution must follow the approved attribution methodology.
* Zero or missing sessions returns **NULL / Not Available**.
* Session definition must follow the approved web-analytics platform methodology.

## 15.6 Source

| Component            | Source                     |
| -------------------- | -------------------------- |
| Recognized Revenue   | Finance / Transaction Data |
| Website Sessions     | Web Analytics              |
| Campaign Attribution | Central Analytics Layer    |

## 15.7 Dimensions / Filters

* Date
* Marketing Channel
* Campaign
* Campaign Type
* Region
* Product Category
* Customer Segment
* Device / Platform, where available

## 15.8 Dashboard

| Dashboard | Include? |
| --------- | -------: |
| Executive |        ❌ |
| Marketing |        ✅ |
| Product   |        ✅ |
| Finance   |        ❌ |

## 15.9 Frequency

Daily.

## 15.10 Ownership

**Marketing/Product:** Business interpretation.

**Finance:** Revenue treatment.

**Data/BI:** Calculation and validation.

## 15.11 Relationship to RPV

| KPI     | Denominator     | Primary Use         |
| ------- | --------------- | ------------------- |
| **RPV** | Unique Visitors | Visitor-level value |
| **RPS** | Sessions        | Session-level value |

These metrics should remain separate because **one visitor can generate multiple sessions**.

## 15.12 Status

🟢 **Agreed**

---

# 15.13 Change Log

| Version | Date        | Change                                            | Status |
| ------- | ----------- | ------------------------------------------------- | ------ |
| 1.0     | August 2026 | Initial Revenue per Session definition documented | 🟢     |
# 16. KPI Dictionary Summary

## 16.1 KPI Register

| KPI ID  | KPI                       | Owner               | Status          |
| ------- | ------------------------- | ------------------- | --------------- |
| KPI-001 | Revenue                   | Finance             | 🟢 Agreed       |
| KPI-002 | Campaign-Attributed Sales | Marketing           | 🟢 Agreed       |
| KPI-003 | Marketing Spend           | Finance / Marketing | 🟢 Agreed       |
| KPI-004 | Operational ROAS          | Marketing           | 🟢 Agreed       |
| KPI-005 | Financial ROAS            | Finance             | 🟢 Agreed       |
| KPI-006 | ROI                       | Finance             | 🟠 Under Review |
| KPI-007 | CAC                       | Finance             | 🟢 Agreed       |
| KPI-008 | Conversion Rate           | Marketing / Product | 🟢 Agreed       |
| KPI-009 | CTR                       | Marketing           | 🟢 Agreed       |
| KPI-010 | CPC                       | Marketing / Finance | 🟢 Agreed       |
| KPI-011 | AOV                       | Finance / Product   | 🟢 Agreed       |
| KPI-012 | Revenue per Visitor       | Marketing / Product | 🟢 Agreed       |
| KPI-013 | Revenue per Session       | Marketing / Product | 🟢 Agreed       |

---

## 16.2 Key KPI Dependencies

| KPI                       | Depends On                                         |
| ------------------------- | -------------------------------------------------- |
| Campaign-Attributed Sales | Transactions + Campaign Data + Attribution         |
| Operational ROAS          | Campaign-Attributed Sales + Platform Spend         |
| Financial ROAS            | Campaign-Attributed Sales + Finance Marketing Cost |
| ROI                       | Finance Return + Finance Investment                |
| CAC                       | Acquisition Cost + New Customers                   |
| Conversion Rate           | Purchases + Sessions / Clicks                      |
| CPC                       | Spend + Clicks                                     |
| AOV                       | Revenue + Completed Orders                         |
| Revenue per Visitor       | Revenue + Unique Visitors                          |
| Revenue per Session       | Revenue + Sessions                                 |

---

## 16.3 Open Decisions

### ROI

Finance must confirm:

1. What constitutes the **return** component?
2. What costs constitute the **investment** component?
3. Whether contribution margin/profit should be considered.
4. Whether historical ROI should be recalculated if the methodology changes.

### CTR

Confirm whether any channel-specific definitions or exclusions are required.

### Financial Marketing Cost

Finance must finalize the treatment of:

* Agency fees
* Creative costs
* Campaign-funded discounts
* Other directly attributable campaign expenses

---

## 16.4 KPI Governance Rules

1. Each KPI must have a defined business owner.
2. KPI definitions must be approved before implementation.
3. KPI formulas must not be changed without documenting the change.
4. Business and technical definitions must remain aligned.
5. Source-system changes must be assessed for KPI impact.
6. KPI changes must be reflected in SQL, dashboards and UAT documentation.
7. Any material KPI change must follow the project's change-control process.
8. Finance remains the authority for financial definitions.
9. Marketing remains the authority for campaign-performance requirements.
10. Data/BI implements and validates the approved definitions.

---

## 16.5 Document Status

**KPI Dictionary Status:** 🟢 Complete for Requirements Phase

**Outstanding:** Finance approval of ROI methodology and remaining open cost-classification decisions.

**Next Project Phase:** Business Requirements Document (BRD)

---

# 17. Change Log

| Version | Date        | Change                                             | Status |
| ------- | ----------- | -------------------------------------------------- | ------ |
| 1.0     | August 2026 | Initial KPI Dictionary created                     | 🟢     |
| 1.1     | August 2026 | KPI definitions and business rules completed       | 🟢     |
| 1.2     | August 2026 | KPI summary, dependencies and open decisions added | 🟢     |
