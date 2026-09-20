# Business Requirements Document (BRD)

## Walmart Centralized Analytics Platform

---

## 1. Document Control

| Field                    | Details                                                                  |
| ------------------------ | ------------------------------------------------------------------------ |
| **Document Name**        | Business Requirements Document                                           |
| **Project Name**         | Walmart Centralized Analytics Platform                                   |
| **Document Version**     | 1.0                                                                      |
| **Status**               | Draft                                                                    |
| **Prepared By**          | Business Analyst                                                         |
| **Primary Stakeholders** | Executive Leadership, Marketing, Finance, Product, Supply Chain, Data/BI |
| **Date**                 | August 2026                                                              |

---

## 2. Project Background

Walmart currently uses data across multiple teams and systems for business reporting and decision-making.

Marketing, Finance, Product, Supply Chain, and other teams may use different data sources, definitions, and reporting processes. This can create inconsistencies, duplicated effort, and delays in obtaining reliable information.

The project aims to establish a centralized analytics platform that brings approved business data and KPI definitions into a consistent reporting environment.

---

## 3. Business Problem

The current reporting environment has several challenges:

* Different teams may use different sources for the same metric.
* KPI definitions may not be consistently applied.
* Marketing and Finance figures may differ because of different calculation methods.
* Reporting may require manual data preparation.
* Stakeholders may spend significant time reconciling numbers.
* Leadership may not have a consistent view of business performance.
* Changes in requirements or business definitions may not be formally documented.

These issues can reduce confidence in reported numbers and slow down business decision-making.

---

## 4. Business Need

The business needs a centralized analytics solution that provides:

* Consistent KPI definitions
* Reliable and validated data
* Clear ownership of business metrics
* Standardized reporting
* Timely access to business performance information
* Traceable data and calculation logic
* A controlled process for requirement and KPI changes

---

## 5. Project Objective

The objective of the project is to design and implement a centralized analytics reporting solution that enables stakeholders to access **consistent, reliable, and actionable business information** for decision-making.

The solution should establish a common analytics framework across relevant business functions while maintaining clear ownership and governance of data and KPIs.

---

## 6. Expected Business Outcome

The project will be considered successful when stakeholders can:

1. Access reliable and consistent business information.
2. Use standardized KPI definitions across teams.
3. Reduce manual reconciliation of conflicting reports.
4. Identify business performance issues more quickly.
5. Make data-driven decisions using validated information.
6. Understand the source and methodology behind reported KPIs.

---

## 7. Document Status

**Current Phase:** Requirements Gathering

**Next Sections:** Project Scope and Stakeholder Requirements
# 8. Project Scope

## 8.1 In Scope

The initial phase of the Walmart Centralized Analytics Platform will include:

### Business Areas

* Marketing Analytics
* Finance-related marketing metrics
* Product Analytics
* Supply Chain / Inventory Analytics

### Data & Analytics

* Integration of approved data sources
* Data validation and reconciliation
* Standardized KPI definitions
* Historical marketing data as agreed with stakeholders
* Marketing campaign and channel data
* Transaction and customer data required for approved KPIs
* Finance-recognized financial data required for reporting

### KPI & Reporting

* KPI calculation and standardization
* Marketing performance reporting
* Executive-level reporting
* Operational marketing reporting
* Product performance reporting
* Dashboard filters and business dimensions defined in the KPI Dictionary

### Governance

* KPI ownership
* Data-source ownership
* KPI Dictionary
* Business requirements documentation
* Data mapping
* UAT
* Data validation
* Change request management

---

## 8.2 Out of Scope — Phase 1

The following are excluded from the initial implementation:

* Full enterprise-wide analytics across every business function
* Advanced predictive analytics
* Machine-learning models
* Automated marketing campaign optimisation
* Real-time analytics
* Multi-touch attribution
* Unapproved third-party data sources
* Unapproved financial cost classifications
* Changes to source-system architecture

These may be considered in future phases based on business requirements.

---

## 8.3 Phase 1 Boundaries

Phase 1 will focus on establishing a **reliable centralized reporting foundation**.

The priority is:

**Data → Validation → KPI Standardization → Reporting → UAT**

Advanced analytics and optimisation will be considered after the core reporting foundation is stable.

---

## 8.4 Historical Data

Historical data availability will be based on the period approved by the relevant stakeholders.

For Marketing Analytics, the current working requirement is to include historical campaign data from **January 2024 onward**, subject to source-data availability and stakeholder confirmation.

---

## 8.5 Scope Change Control

Any requirement outside the agreed scope must be documented as a **Change Request**.

The impact should be assessed against:

* Timeline
* Resources
* Data availability
* Technical complexity
* Business value
* Existing dashboards and KPIs

Approved scope changes will be incorporated through the project's change-control process.

---

## 8.6 Scope Status

**Status:** 🟢 Defined — subject to stakeholder approval
# 9. Business Requirements

## 9.1 Business Requirements Register

| ID         | Business Requirement                                                                                                       | Priority | Owner                 |
| ---------- | -------------------------------------------------------------------------------------------------------------------------- | -------- | --------------------- |
| **BR-001** | The solution must provide a centralized analytics platform for approved business reporting.                                | High     | Data/BI               |
| **BR-002** | The solution must use standardized and approved KPI definitions across reporting.                                          | High     | Business Owners       |
| **BR-003** | The solution must provide a consistent view of Marketing and Finance performance metrics.                                  | High     | Finance / Marketing   |
| **BR-004** | The solution must integrate approved data sources required for the defined KPIs.                                           | High     | Data/BI               |
| **BR-005** | The solution must provide validated and reconciled data before business reporting.                                         | High     | Data/BI / Data Owners |
| **BR-006** | Stakeholders must be able to analyse performance using agreed business dimensions and filters.                             | High     | Marketing / Product   |
| **BR-007** | The solution must provide dashboards appropriate for executive, marketing, finance, and product users.                     | High     | Data/BI               |
| **BR-008** | The solution must provide reporting at the agreed refresh frequency.                                                       | Medium   | Data/BI               |
| **BR-009** | Financial metrics must use Finance-approved definitions and financial treatment.                                           | High     | Finance               |
| **BR-010** | Marketing metrics must use approved campaign attribution and classification rules.                                         | High     | Marketing             |
| **BR-011** | The solution must maintain clear ownership for KPIs and source data.                                                       | Medium   | Business Owners       |
| **BR-012** | KPI and requirement changes must be documented and managed through change control.                                         | Medium   | Business Analyst      |
| **BR-013** | Stakeholders must be able to validate dashboard results through UAT before production release.                             | High     | Business Owners / QA  |
| **BR-014** | The solution must support investigation of significant data discrepancies through data validation and root-cause analysis. | Medium   | Data/BI               |
| **BR-015** | The solution should reduce manual reporting and reconciliation effort where automation is feasible.                        | Medium   | Data/BI               |

---

## 9.2 Business Requirement Priorities

| Priority   | Meaning                     |
| ---------- | --------------------------- |
| **High**   | Required for Phase 1        |
| **Medium** | Important but may be phased |
| **Low**    | Future enhancement          |

---

## 9.3 Business Requirement Acceptance

A business requirement will be considered satisfied when:

1. The requirement has been implemented or addressed.
2. The relevant stakeholder has validated the outcome.
3. Supporting UAT evidence is available where applicable.
4. Any exceptions or limitations are documented.

---

## 9.4 Requirement Traceability

Each business requirement should eventually be linked to:

**Business Requirement → Functional Requirement → Data Source → KPI → Dashboard → UAT Test Case**

This traceability will be established during the later requirements and implementation phases.

---

## 9.5 Status

**Status:** 🟢 Initial Business Requirements Defined

**Next:** Functional Requirements
# 10. Functional Requirements

## 10.1 Functional Requirements Register

| ID         | Functional Requirement                                                                                                                               | Related BR     | Priority |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | -------- |
| **FR-001** | The solution must consolidate approved data sources into a centralized analytics layer.                                                              | BR-001, BR-004 | High     |
| **FR-002** | The solution must apply the approved KPI definitions and calculation logic from the KPI Dictionary.                                                  | BR-002         | High     |
| **FR-003** | The solution must calculate Revenue using the approved Finance-recognized revenue definition.                                                        | BR-003, BR-009 | High     |
| **FR-004** | The solution must calculate Campaign-Attributed Sales using the approved Last-Touch Attribution methodology.                                         | BR-010         | High     |
| **FR-005** | The solution must maintain separate Platform Spend and Finance-Recognized Marketing Cost.                                                            | BR-003, BR-009 | High     |
| **FR-006** | The solution must calculate Operational ROAS using Campaign-Attributed Sales and Platform Spend.                                                     | BR-002         | High     |
| **FR-007** | The solution must calculate Financial ROAS using Campaign-Attributed Sales and Finance-Recognized Marketing Cost.                                    | BR-002, BR-009 | High     |
| **FR-008** | The solution must calculate CAC using the approved acquisition-cost definition and new-customer logic.                                               | BR-002         | High     |
| **FR-009** | The solution must calculate Conversion Rate separately for campaign-level and website-level reporting using the approved denominators.               | BR-002         | High     |
| **FR-010** | The solution must calculate CTR using approved clicks and impressions data.                                                                          | BR-002         | High     |
| **FR-011** | The solution must calculate Operational CPC and Financial CPC separately.                                                                            | BR-002, BR-009 | High     |
| **FR-012** | The solution must calculate AOV using recognized revenue and completed orders.                                                                       | BR-002         | High     |
| **FR-013** | The solution must calculate Revenue per Visitor using recognized revenue and unique visitors.                                                        | BR-002         | High     |
| **FR-014** | The solution must calculate Revenue per Session using recognized revenue and website sessions.                                                       | BR-002         | High     |
| **FR-015** | Users must be able to filter dashboards by agreed dimensions such as date, channel, campaign, region, product, and customer segment where available. | BR-006         | High     |
| **FR-016** | The solution must provide separate executive and detailed marketing views where different KPI requirements apply.                                    | BR-007         | High     |
| **FR-017** | The solution must display the applicable data refresh date/time.                                                                                     | BR-008         | Medium   |
| **FR-018** | The solution must identify preliminary versus finalized financial data where applicable.                                                             | BR-009         | High     |
| **FR-019** | The solution must perform data-quality checks before data is used for reporting.                                                                     | BR-005         | High     |
| **FR-020** | The solution must flag missing, duplicate, invalid, or inconsistent data for investigation.                                                          | BR-005, BR-014 | High     |
| **FR-021** | Users must be able to drill down from summary performance to relevant campaign/channel details where supported.                                      | BR-006         | Medium   |
| **FR-022** | The solution must maintain consistent KPI calculations across dashboards.                                                                            | BR-002         | High     |
| **FR-023** | The solution must maintain documentation of KPI definitions, calculation logic, source systems, and ownership.                                       | BR-011         | Medium   |
| **FR-024** | Dashboard results must be available for stakeholder validation during UAT before production release.                                                 | BR-013         | High     |
| **FR-025** | Requirement and KPI changes must be traceable through documented change requests.                                                                    | BR-012         | Medium   |

---

## 10.2 Functional Requirement Principles

Functional requirements must be:

* Clear
* Testable
* Traceable to a business requirement
* Linked to relevant KPIs or data requirements
* Specific enough for implementation and UAT

---

## 10.3 Requirement Traceability

The following relationship will be maintained:

**BR → FR → KPI → Data Source → Dashboard → UAT**

Example:

**BR-006**
↓
**FR-015**
↓
**KPI-004 Operational ROAS**
↓
**Campaign + Platform Spend Data**
↓
**Marketing Dashboard**
↓
**UAT Test Case**

---

## 10.4 Status

**Status:** 🟢 Initial Functional Requirements Defined
# 11. Non-Functional Requirements

## 11.1 Non-Functional Requirements Register

| ID          | Requirement                                                                                                     | Priority |
| ----------- | --------------------------------------------------------------------------------------------------------------- | -------- |
| **NFR-001** | Dashboard data must meet agreed data-quality standards before publication.                                      | High     |
| **NFR-002** | KPI calculations must produce consistent results across all dashboards.                                         | High     |
| **NFR-003** | Data refresh must occur at the agreed reporting frequency.                                                      | High     |
| **NFR-004** | The solution must clearly display the latest data refresh date/time.                                            | Medium   |
| **NFR-005** | Financial data must follow approved Finance controls and access restrictions.                                   | High     |
| **NFR-006** | Users must only access data appropriate to their authorized role.                                               | High     |
| **NFR-007** | Dashboard performance should support normal business use without unreasonable loading delays.                   | Medium   |
| **NFR-008** | KPI calculations and source data should be traceable for validation and audit purposes.                         | High     |
| **NFR-009** | Data-quality issues must be identifiable and traceable to the relevant source.                                  | High     |
| **NFR-010** | The solution should minimize manual data preparation and reporting effort where feasible.                       | Medium   |
| **NFR-011** | Changes to KPI definitions and business rules must be documented and traceable.                                 | High     |
| **NFR-012** | The solution should support scalability for additional KPIs, data sources, and business areas in future phases. | Medium   |
| **NFR-013** | Sensitive financial and customer data must be handled according to applicable organizational security policies. | High     |
| **NFR-014** | Dashboard outputs must be available consistently to authorized users during agreed business reporting periods.  | Medium   |

---

## 11.2 Data Quality Expectations

The solution should validate, where applicable:

* Completeness
* Accuracy
* Consistency
* Uniqueness
* Validity
* Timeliness

Critical data-quality failures must be identified before publication of affected reporting.

---

## 11.3 Security & Access

Access should be controlled based on user roles and business requirements.

Financial and customer-related information should only be accessible to authorized users.

---

## 11.4 Auditability

The solution should allow authorized users to understand:

**Source → Transformation → KPI Calculation → Dashboard**

This will support reconciliation, UAT, troubleshooting, and future audits.

---

## 11.5 Status

**Status:** 🟢 Initial NFRs Defined
# 12. Data Requirements & Data Sources

## 12.1 Data Requirements

The solution must collect and integrate approved data required to calculate the defined KPIs and support dashboard reporting.

| ID         | Data Requirement            | Purpose                                       | Primary Owner           |
| ---------- | --------------------------- | --------------------------------------------- | ----------------------- |
| **DR-001** | Customer data               | Customer identification, segmentation and CAC | Customer/Data Team      |
| **DR-002** | Transaction/order data      | Revenue, orders, AOV and conversion           | Sales/Data Team         |
| **DR-003** | Campaign data               | Campaign performance and attribution          | Marketing               |
| **DR-004** | Advertising platform data   | Impressions, clicks and platform spend        | Marketing               |
| **DR-005** | Finance revenue data        | Recognized revenue and financial validation   | Finance                 |
| **DR-006** | Finance marketing-cost data | Financial ROAS, ROI and CAC                   | Finance                 |
| **DR-007** | Website analytics data      | Sessions and unique visitors                  | Product / Digital       |
| **DR-008** | Product/category data       | Product-level analysis                        | Product / Merchandising |
| **DR-009** | Regional data               | Region-level reporting                        | Business/Data Team      |
| **DR-010** | Marketing budget data       | Budget vs actual analysis                     | Marketing / Finance     |

---

## 12.2 Data Source Requirements

Each source must be evaluated for:

* Ownership
* Availability
* Data quality
* Refresh frequency
* Historical coverage
* Granularity
* Access restrictions
* Business definitions

---

## 12.3 Initial Source Mapping

| Data Domain | Expected Source                   | Key Data                                          |
| ----------- | --------------------------------- | ------------------------------------------------- |
| Customers   | Customer System                   | Customer ID, acquisition channel, customer status |
| Orders      | Transaction System                | Order ID, customer, date, value, status           |
| Campaigns   | Marketing Platform                | Campaign ID, channel, campaign type               |
| Advertising | Ad Platforms                      | Impressions, clicks, spend                        |
| Finance     | Finance System                    | Recognized revenue, recognized marketing costs    |
| Website     | Web Analytics                     | Sessions, unique visitors                         |
| Products    | Product/Merchandising System      | Product, category, brand                          |
| Geography   | Business Master Data              | Region, market                                    |
| Budget      | Marketing/Finance Planning System | Budget allocation                                 |

---

## 12.4 Data Granularity

Where available, data should support analysis at:

* Daily level
* Campaign level
* Channel level
* Region level
* Product/category level
* Customer level where permitted
* Transaction/order level where required

---

## 12.5 Historical Data

The initial working requirement is:

**Marketing campaign data: January 2024 onward**

Historical availability must be confirmed for each source before implementation.

---

## 12.6 Data Quality Requirements

Data must be checked for:

* Missing records
* Duplicate records
* Invalid values
* Missing keys
* Referential integrity
* Date inconsistencies
* Revenue discrepancies
* Spend discrepancies
* Attribution inconsistencies

Significant discrepancies must be investigated before affected metrics are published.

---

## 12.7 Data Reconciliation

Where multiple systems contain related financial or marketing data, reconciliation must be performed.

Examples:

**Marketing Platform Spend ↔ Finance Marketing Cost**

**Transaction Revenue ↔ Finance Recognized Revenue**

**Campaign Data ↔ Marketing Platform Data**

Differences must be documented and investigated rather than automatically overwritten.

---

## 12.8 Data Ownership

| Data Area         | Primary Owner         |
| ----------------- | --------------------- |
| Customer Data     | Customer/Data Team    |
| Transaction Data  | Sales/Data Team       |
| Campaign Data     | Marketing             |
| Platform Spend    | Marketing             |
| Financial Data    | Finance               |
| Website Analytics | Product/Digital       |
| Product Data      | Product/Merchandising |
| Budget Data       | Marketing / Finance   |

---

## 12.9 Data Access & Restrictions

Access to financial, customer, and other restricted information must follow organizational security and access policies.

Only required fields should be exposed to reporting users.

---

## 12.10 Status

**Status:** 🟢 Initial Data Requirements Defined

**Open:** Final source-system names, access method, historical availability and field-level mapping to be confirmed during Data Mapping.
# 13. Dashboard & Reporting Requirements

## 13.1 Dashboard Requirements

The solution must provide role-based dashboards for stakeholders to monitor business and marketing performance.

| ID           | Dashboard           | Primary Users | Purpose                                       |
| ------------ | ------------------- | ------------- | --------------------------------------------- |
| **DASH-001** | Executive Dashboard | Leadership    | High-level business and marketing performance |
| **DASH-002** | Marketing Dashboard | Marketing     | Campaign and channel performance              |
| **DASH-003** | Finance Dashboard   | Finance       | Financial performance and reconciliation      |
| **DASH-004** | Product Dashboard   | Product       | Product and customer performance              |

---

## 13.2 Executive Dashboard

The Executive Dashboard should provide a concise view of key business performance indicators.

### Core KPIs

* Revenue
* Campaign-Attributed Sales
* Financial ROAS
* ROI
* CAC
* AOV
* Conversion Rate

### Key Views

* Overall performance
* Performance trend
* Channel performance
* Campaign performance
* Region performance
* KPI vs target, where targets are available

---

## 13.3 Marketing Dashboard

The Marketing Dashboard should support campaign optimisation and detailed analysis.

### Core KPIs

* Campaign-Attributed Sales
* Operational ROAS
* Financial ROAS
* CAC
* Conversion Rate
* CTR
* Operational CPC
* Financial CPC
* Revenue per Visitor
* Revenue per Session

### Key Views

* Channel
* Campaign
* Campaign Type
* Platform
* Region
* Customer Segment
* Product Category

---

## 13.4 Finance Dashboard

The Finance Dashboard should support financial validation and performance monitoring.

### Core KPIs

* Recognized Revenue
* Finance-Recognized Marketing Cost
* Financial ROAS
* ROI
* Financial CPC
* CAC

### Key Views

* Financial period
* Channel
* Campaign
* Region
* Cost category
* Business unit

---

## 13.5 Product Dashboard

The Product Dashboard should support analysis of customer and product performance.

### Core KPIs

* Revenue
* AOV
* Conversion Rate
* Revenue per Visitor
* Revenue per Session

### Key Views

* Product
* Product Category
* Customer Segment
* Region
* Date
* Channel

---

## 13.6 Dashboard Filters

Where data is available, dashboards should support:

* Date / Date Range
* Marketing Channel
* Campaign
* Campaign Type
* Region
* Product
* Product Category
* Customer Segment
* Platform

---

## 13.7 Refresh Requirements

| Dashboard | Target Refresh               |
| --------- | ---------------------------- |
| Executive | Daily                        |
| Marketing | Daily                        |
| Finance   | Daily / Finance availability |
| Product   | Daily                        |

The dashboard must display the **latest data refresh date/time**.

---

## 13.8 Financial Data Status

Where Finance data is subject to reconciliation or financial close, the dashboard should distinguish between:

* **Preliminary**
* **Finalized**

---

## 13.9 Dashboard Usability

Dashboards should:

* Present KPIs clearly.
* Use consistent definitions and calculations.
* Allow users to filter and drill down where applicable.
* Highlight significant performance changes.
* Provide sufficient context for decision-making.
* Avoid unnecessary visual complexity.

---

## 13.10 Dashboard Validation

Before production release:

1. KPI calculations must be validated.
2. Dashboard totals must be reconciled with source data.
3. Filters must be tested.
4. Drill-downs must be tested where applicable.
5. Stakeholders must complete UAT.
6. Critical defects must be resolved before release.

---

## 13.11 Status

**Status:** 🟢 Initial Dashboard Requirements Defined

**Open:** Final dashboard layouts, visual design and exact target thresholds to be finalized during dashboard design and UAT.
# 14. UAT & Acceptance Criteria

## 14.1 UAT Objective

UAT will confirm that the centralized analytics solution meets approved business requirements, KPI definitions, data rules, and dashboard expectations before production release.

## 14.2 UAT Scope

UAT will validate:

- KPI calculations
- Data accuracy
- Dashboard totals
- Filters and drill-downs
- Data refresh
- Financial reconciliation
- Role-based access
- Business rules
- Dashboard usability

## 14.3 Acceptance Criteria

| ID | Acceptance Criteria | Owner |
|---|---|---|
| UAT-001 | KPI values match approved definitions in the KPI Dictionary. | Business Owner |
| UAT-002 | Dashboard figures reconcile with approved source data. | Finance / Data |
| UAT-003 | Required filters return correct results. | Business Users |
| UAT-004 | Campaign attribution follows the approved methodology. | Marketing |
| UAT-005 | Financial metrics reconcile with Finance-approved figures. | Finance |
| UAT-006 | Data refresh occurs according to the agreed schedule. | Data/BI |
| UAT-007 | Unauthorized users cannot access restricted data. | Data/IT |
| UAT-008 | Critical data-quality issues are resolved before production release. | Data/BI |
| UAT-009 | Business stakeholders confirm that dashboards support required decisions. | Stakeholders |
| UAT-010 | All critical UAT defects are resolved or formally accepted before release. | Project Owner |

## 14.4 UAT Process

**Prepare → Execute → Record Defects → Retest → Business Sign-off → Production Release**

## 14.5 UAT Defect Priority

| Priority | Definition |
|---|---|
| Critical | Prevents business use or produces materially incorrect results |
| High | Major functionality or KPI issue |
| Medium | Limited business impact |
| Low | Cosmetic or minor usability issue |

## 14.6 UAT Sign-off

UAT approval should be obtained from the relevant business owners before production deployment.

Required sign-off areas:

- Marketing
- Finance
- Product
- Data/BI
- Project Owner

## 14.7 Status

**Status:** 🟢 UAT Framework Defined

# 15. Assumptions & Dependencies

## 15.1 Assumptions

| ID | Assumption | Impact if Incorrect |
|---|---|---|
| **A-001** | Stakeholders will provide requirements and feedback on time. | Project delays |
| **A-002** | Required historical data will be available from January 2024 onward. | Reduced reporting scope |
| **A-003** | Approved source systems will provide reliable data. | Additional data validation required |
| **A-004** | Business owners will validate KPI definitions and dashboard results. | UAT delays |
| **A-005** | Required data access will be provided to the project team. | Development delays |
| **A-006** | Finance will approve financial definitions and cost treatment. | Financial KPI implementation delays |

---

## 15.2 Dependencies

| ID | Dependency | Owner |
|---|---|---|
| **D-001** | Access to Marketing platform data | Marketing / IT |
| **D-002** | Access to Finance-recognized revenue and cost data | Finance |
| **D-003** | Access to transaction and customer data | Data / Business |
| **D-004** | Access to website analytics data | Product / Digital |
| **D-005** | Stakeholder availability for requirements and UAT | Business Owners |
| **D-006** | Final approval of KPI definitions | Finance / Marketing / Product |
| **D-007** | Data engineering support for integration and transformation | Data/BI |
| **D-008** | Dashboard development capacity | Data/BI |

---

## 15.3 Assumption Management

If an assumption becomes invalid, the impact should be assessed and documented.

Significant changes may require:

- Requirement updates
- Risk updates
- Scope changes
- Timeline changes
- Change Request

---

## 15.4 Status

**Status:** 🟢 Initial Assumptions & Dependencies Defined
# 16. Risks & Mitigation

## 16.1 Risk Register

| ID | Risk | Probability | Impact | Mitigation | Owner |
|---|---|---|---|---|---|
| **R-001** | Stakeholders may change requirements during the project. | Medium | High | Use formal requirement sign-off and change control. | Business Analyst |
| **R-002** | Source data may be incomplete or inaccurate. | High | High | Perform data profiling, validation and reconciliation before reporting. | Data/BI |
| **R-003** | Stakeholder meetings or feedback may be delayed. | Medium | Medium | Schedule meetings in advance and define response timelines. | Project Owner |
| **R-004** | Finance and Marketing may continue to report different figures. | Medium | High | Establish approved KPI definitions and Finance validation. | Finance / Marketing |
| **R-005** | Required historical data may not be available. | Medium | Medium | Confirm historical availability during data assessment and define fallback scope. | Data/BI |
| **R-006** | Data access may be delayed. | Medium | High | Identify access requirements early and track them as project dependencies. | Data/IT |
| **R-007** | KPI methodology may change after implementation. | Medium | High | Maintain KPI governance and formal change requests. | Business Owners |
| **R-008** | UAT may identify significant data or calculation issues. | Medium | High | Perform early validation and reconciliation before UAT. | Data/BI / Business |
| **R-009** | Financial data may have access or confidentiality restrictions. | Low | High | Apply role-based access and Finance-approved data controls. | Finance / IT |

---

## 16.2 Risk Rating

| Rating | Definition |
|---|---|
| Low | Limited impact on project |
| Medium | Manageable impact requiring monitoring |
| High | Significant impact requiring active mitigation |

---

## 16.3 Risk Management

Risks should be reviewed throughout the project.

New risks must be:

1. Documented.
2. Assigned an owner.
3. Assessed for probability and impact.
4. Assigned a mitigation action.
5. Reviewed during project status meetings.

---

## 16.4 Status

**Status:** 🟢 Initial Risk Register Defined
# 17. Open Questions & Decisions

## 17.1 Open Questions

| ID | Question / Decision Required | Owner | Status |
|---|---|---|---|
| **OQ-001** | What exact costs should be included in the Finance investment component of ROI? | Finance | 🟠 Open |
| **OQ-002** | What should be included in the return component of ROI? | Finance | 🟠 Open |
| **OQ-003** | Should contribution margin/profit be considered in ROI? | Finance | 🟠 Open |
| **OQ-004** | Are any channel-specific exclusions required for CTR? | Marketing | 🟠 Open |
| **OQ-005** | Are campaign-funded discounts classified separately from standard discounts? | Marketing / Finance | 🟠 Open |
| **OQ-006** | Is January 2024 confirmed as the historical data start date? | Marketing | 🟠 Open |
| **OQ-007** | What are the final KPI targets/thresholds for executive reporting? | Business Owners | 🟠 Open |
| **OQ-008** | What are the final source-system names and access methods? | Data/IT | 🟠 Open |
| **OQ-009** | What exact financial data restrictions apply to dashboard users? | Finance / IT | 🟠 Open |

---

## 17.2 Agreed Decisions

| ID | Decision | Owner | Status |
|---|---|---|---|
| **DEC-001** | A centralized analytics platform will be established. | Business | 🟢 Agreed |
| **DEC-002** | KPI definitions will be standardized through the KPI Dictionary. | Business Owners | 🟢 Agreed |
| **DEC-003** | Operational and Financial versions of relevant KPIs will be maintained separately. | Finance / Marketing | 🟢 Agreed |
| **DEC-004** | Last-Touch Attribution will be used for campaign-level attribution in Phase 1. | Marketing | 🟢 Agreed |
| **DEC-005** | Website Conversion Rate will use completed purchases ÷ sessions. | Marketing / Product | 🟢 Agreed |
| **DEC-006** | Campaign Conversion Rate will use attributed conversions ÷ clicks. | Marketing | 🟢 Agreed |
| **DEC-007** | RPV will use unique visitors; RPS will use sessions. | Product / Marketing | 🟢 Agreed |
| **DEC-008** | UAT and stakeholder sign-off are required before production release. | Business Owners | 🟢 Agreed |

---

## 17.3 Decision Management

All open questions must be resolved before the relevant requirement moves into implementation.

Approved decisions must be:

- Documented
- Assigned an owner
- Reflected in the KPI Dictionary or BRD
- Incorporated into technical requirements where applicable
- Validated during UAT

---

## 17.4 Status

**Status:** 🟢 Open Decisions Documented
# 18. Approval & Sign-off

## 18.1 Approval Requirements

The BRD must be reviewed and approved by the relevant business stakeholders before requirements move into detailed solution design and implementation.

| Stakeholder | Responsibility | Approval Status |
|---|---|---|
| Marketing Head | Marketing requirements, campaign definitions and attribution | 🟠 Pending |
| Finance Manager | Financial definitions, costs and ROI methodology | 🟠 Pending |
| Product Manager | Product and website analytics requirements | 🟠 Pending |
| Data/BI Lead | Data and technical feasibility | 🟠 Pending |
| Project Owner | Overall project approval | 🟠 Pending |

---

## 18.2 Approval Criteria

Approval should confirm that:

- Business requirements are understood.
- Project scope is agreed.
- KPI definitions are documented.
- Data requirements are understood.
- Dashboard requirements are understood.
- UAT expectations are defined.
- Open decisions have assigned owners.
- Risks and dependencies are acknowledged.

---

## 18.3 Sign-off Record

| Version | Date | Approver | Role | Decision |
|---|---|---|---|---|
| 1.0 | August 2026 | Pending | Marketing | Pending |
| 1.0 | August 2026 | Pending | Finance | Pending |
| 1.0 | August 2026 | Pending | Product | Pending |
| 1.0 | August 2026 | Pending | Data/BI | Pending |
| 1.0 | August 2026 | Pending | Project Owner | Pending |

---

# 19. Change Log

| Version | Date | Change | Author | Status |
|---|---|---|---|---|
| 1.0 | August 2026 | Initial BRD created | Business Analyst | Draft |
| 1.1 | August 2026 | Business and functional requirements added | Business Analyst | Draft |
| 1.2 | August 2026 | Data and dashboard requirements added | Business Analyst | Draft |
| 1.3 | August 2026 | UAT, assumptions, dependencies and risks added | Business Analyst | Draft |
| 1.4 | August 2026 | Open questions and decisions documented | Business Analyst | Draft |
| 1.5 | August 2026 | Approval and sign-off section added | Business Analyst | Draft |

---

# 20. BRD Completion Status

## 20.1 Current Status

**BRD Status:** 🟢 Draft Complete

The BRD currently contains:

- Project Background
- Business Problem
- Business Objective
- Project Scope
- Business Requirements
- Functional Requirements
- Non-Functional Requirements
- Data Requirements
- Data Sources
- Dashboard Requirements
- UAT & Acceptance Criteria
- Assumptions
- Dependencies
- Risks & Mitigation
- Open Questions
- Agreed Decisions
- Approval & Sign-off
- Change Log

## 20.2 Outstanding Items

The following remain subject to stakeholder confirmation:

- Final ROI methodology
- Final financial cost classification
- Final historical-data availability
- Final KPI targets and thresholds
- Final source-system and access details
- Final stakeholder sign-off

## 20.3 Next Project Phase

**BRD → Data Mapping & Source Assessment → Technical/Data Design → SQL Implementation → Dashboard Development → UAT → Production Release**

---

# 21. Document Status

**Document:** BRD — Walmart Centralized Analytics Platform

**Version:** 1.5

**Status:** Draft Complete — Pending Stakeholder Approval

**Next Action:** Stakeholder Review & Sign-off