# Data Model Design

## Walmart Centralized Analytics Platform

---

## 1. Purpose

Define the analytical data model required to support approved KPIs, dashboards and reporting.

---

## 2. Modelling Approach

The solution will use a **star-schema approach** consisting of:

- Fact tables for measurable business events.
- Dimension tables for descriptive attributes.
- Shared dimensions for consistent reporting across facts.

---

## 3. Proposed Fact Tables

| Fact Table | Grain | Primary Purpose |
|---|---|---|
| `fact_orders` | One row per order | Revenue, orders and AOV |
| `fact_order_items` | One row per order item | Product-level analysis |
| `fact_marketing_spend` | One row per campaign/platform/day | Marketing spend and CPC |
| `fact_campaign_performance` | One row per campaign/day | Campaign KPIs and attribution |
| `fact_finance_cost` | One row per financial cost record | Financial ROAS, ROI and CAC |
| `fact_web_sessions` | One row per session/day | Sessions, visitors and conversion |

---

## 4. Proposed Dimension Tables

| Dimension | Purpose |
|---|---|
| `dim_customer` | Customer and acquisition attributes |
| `dim_campaign` | Campaign classification and channel |
| `dim_product` | Product, brand and category |
| `dim_date` | Standardized date reporting |
| `dim_region` | Geographic reporting |
| `dim_channel` | Marketing channel classification |
| `dim_platform` | Advertising platform |

---

## 5. Core Relationships

### Orders

`fact_orders.customer_id → dim_customer.customer_id`

`fact_orders.order_date → dim_date.date_key`

`fact_orders.region_id → dim_region.region_id`

### Order Items

`fact_order_items.order_id → fact_orders.order_id`

`fact_order_items.product_id → dim_product.product_id`

### Marketing

`fact_marketing_spend.campaign_id → dim_campaign.campaign_id`

`fact_marketing_spend.platform_id → dim_platform.platform_id`

`fact_marketing_spend.date_key → dim_date.date_key`

### Campaign Performance

`fact_campaign_performance.campaign_id → dim_campaign.campaign_id`

`fact_campaign_performance.date_key → dim_date.date_key`

### Finance

`fact_finance_cost.campaign_id → dim_campaign.campaign_id`

`fact_finance_cost.date_key → dim_date.date_key`

### Website

`fact_web_sessions.date_key → dim_date.date_key`

`fact_web_sessions.campaign_id → dim_campaign.campaign_id`

---

## 6. Fact Table Grain

The grain of each fact table must be clearly defined before implementation.

| Fact | Grain |
|---|---|
| `fact_orders` | One row per order |
| `fact_order_items` | One row per order item |
| `fact_marketing_spend` | One campaign × platform × day |
| `fact_campaign_performance` | One campaign × day |
| `fact_finance_cost` | One financial cost record |
| `fact_web_sessions` | One session |

---

## 7. KPI Data Sources

| KPI | Primary Fact / Source |
|---|---|
| Revenue | `fact_orders` + Finance |
| Campaign-Attributed Sales | `fact_campaign_performance` |
| Operational ROAS | Campaign Sales + `fact_marketing_spend` |
| Financial ROAS | Campaign Sales + `fact_finance_cost` |
| ROI | Finance data |
| CAC | `fact_finance_cost` + `dim_customer` |
| Conversion Rate | Orders + `fact_web_sessions` |
| CTR | Campaign Performance |
| CPC | Marketing Spend |
| AOV | Orders |
| Revenue per Visitor | Orders + Web Sessions |
| Revenue per Session | Orders + Web Sessions |

---

## 8. Data Model Principles

1. Each fact table must have a clearly defined grain.
2. Shared dimensions should use consistent keys.
3. Financial and operational costs must remain separate.
4. KPI calculations must follow the approved KPI Dictionary.
5. Source data should not be overwritten during transformation.
6. Historical records should be retained where required.
7. Relationships must support dashboard filtering and drill-down.
8. Data quality checks must occur before reporting.

---

## 9. Initial Model Status

**Status:** 🟢 Conceptual Data Model Defined

**Next:** Detailed table and column design.
# 10. Detailed Table Design

## 10.1 Customer Dimension

**Table:** `dim_customer`  
**Grain:** One row per customer

| Column | Type | Key | Purpose |
|---|---|---|---|
| customer_key | INT | PK | Surrogate key |
| customer_id | INT | Business Key | Source customer ID |
| first_purchase_date | DATE | | First valid purchase |
| acquisition_channel | VARCHAR | | Acquisition channel |
| customer_segment | VARCHAR | | Customer segment |
| region_id | INT | FK | Customer region |

---

## 10.2 Campaign Dimension

**Table:** `dim_campaign`  
**Grain:** One row per campaign

| Column | Type | Key | Purpose |
|---|---|---|---|
| campaign_key | INT | PK | Surrogate key |
| campaign_id | VARCHAR | Business Key | Source campaign ID |
| campaign_name | VARCHAR | | Campaign name |
| campaign_type | VARCHAR | | Campaign classification |
| channel_id | INT | FK | Marketing channel |
| start_date | DATE | | Campaign start |
| end_date | DATE | | Campaign end |
| campaign_status | VARCHAR | | Campaign status |

---

## 10.3 Order Fact

**Table:** `fact_orders`  
**Grain:** One row per order

| Column | Type | Key | Purpose |
|---|---|---|---|
| order_key | BIGINT | PK | Surrogate key |
| order_id | BIGINT | Business Key | Source order |
| customer_key | INT | FK | Customer |
| date_key | INT | FK | Order date |
| region_id | INT | FK | Region |
| order_status | VARCHAR | | Order status |
| gross_order_value | DECIMAL | | Gross order value |
| recognized_revenue | DECIMAL | | Finance-recognized revenue |
| refund_amount | DECIMAL | | Refunds |
| return_amount | DECIMAL | | Returns |
| discount_amount | DECIMAL | | Discounts |

---

## 10.4 Marketing Spend Fact

**Table:** `fact_marketing_spend`  
**Grain:** One campaign × platform × day

| Column | Type | Key | Purpose |
|---|---|---|---|
| spend_key | BIGINT | PK | Surrogate key |
| campaign_key | INT | FK | Campaign |
| platform_id | INT | FK | Advertising platform |
| date_key | INT | FK | Spend date |
| impressions | BIGINT | | Impressions |
| clicks | BIGINT | | Clicks |
| platform_spend | DECIMAL | | Platform spend |

---

## 10.5 Campaign Performance Fact

**Table:** `fact_campaign_performance`  
**Grain:** One campaign × day

| Column | Type | Key | Purpose |
|---|---|---|---|
| performance_key | BIGINT | PK | Surrogate key |
| campaign_key | INT | FK | Campaign |
| date_key | INT | FK | Performance date |
| attributed_orders | INT | | Attributed conversions |
| campaign_attributed_sales | DECIMAL | | Attributed sales |
| attributed_revenue | DECIMAL | | Attributed revenue |

---

## 10.6 Finance Cost Fact

**Table:** `fact_finance_cost`  
**Grain:** One financial cost record

| Column | Type | Key | Purpose |
|---|---|---|---|
| cost_key | BIGINT | PK | Surrogate key |
| campaign_key | INT | FK | Campaign |
| date_key | INT | FK | Cost date |
| channel_id | INT | FK | Channel |
| cost_category | VARCHAR | | Cost classification |
| marketing_cost | DECIMAL | | Finance-recognized cost |
| agency_cost | DECIMAL | | Agency cost |
| creative_cost | DECIMAL | | Creative cost |
| campaign_expense | DECIMAL | | Campaign expense |

---

## 10.7 Web Session Fact

**Table:** `fact_web_sessions`  
**Grain:** One session

| Column | Type | Key | Purpose |
|---|---|---|---|
| session_key | BIGINT | PK | Session identifier |
| date_key | INT | FK | Session date |
| visitor_id | VARCHAR | | Unique visitor |
| campaign_key | INT | FK | Campaign |
| channel_id | INT | FK | Marketing channel |

---

## 10.8 Status

**Status:** 🟢 Initial Table Design Complete

**Next:** Existing Walmart database → Analytical model mapping.
# 11. Existing Walmart Database Mapping

## 11.1 Source-to-Analytics Mapping

| Existing Walmart Table | Analytical Target | Usage |
|---|---|---|
| `customers` | `dim_customer` | Customer and acquisition analysis |
| `orders` | `fact_orders` | Orders and revenue |
| `order_items` | `fact_order_items` | Product-level analysis |
| `products` | `dim_product` | Product/category analysis |
| `categories` | `dim_product` | Category classification |
| `brands` | `dim_product` | Brand classification |
| `stores` | `dim_region` | Store/geographic analysis |
| `inventory` | Future inventory model | Inventory analysis |
| `payments` | Financial validation | Payment analysis |
| `returns` | `fact_orders` / returns model | Return adjustments |
| `shipments` | Future logistics model | Shipment analysis |
| `warehouses` | Future inventory model | Warehouse analysis |
| `suppliers` | Future procurement model | Supplier analysis |

---

## 11.2 Marketing Data Gap

The current Walmart transactional database does not contain all required marketing-performance data.

Additional sources will be required for:

- Campaigns
- Advertising platforms
- Impressions
- Clicks
- Platform spend
- Campaign attribution
- Website sessions
- Unique visitors
- Finance-recognized marketing costs
- Marketing budgets

These will be integrated with the existing Walmart transactional data.

---

## 11.3 Finance Data Gap

The current transactional model should not be treated as the authoritative Finance source.

Finance data is required for:

- Recognized revenue
- Finance-recognized marketing cost
- Agency costs
- Creative costs
- Campaign expenses
- Financial adjustments
- ROI methodology

Finance will remain the authoritative source for financial definitions.

---

## 11.4 Key Integration Relationships

```text
customers
    │
    └── orders
          │
          └── order_items
                 │
                 └── products
                        │
                        ├── categories
                        └── brands

Marketing Campaigns
        │
        ├── Advertising Spend
        ├── Campaign Performance
        └── Attribution
                │
                ↓
             Orders

Finance
        │
        ├── Recognized Revenue
        └── Marketing Costs


### Important BA insight

This is where our project becomes more realistic.

We discovered that **the existing Walmart database alone cannot answer all the marketing questions**.

So instead of forcing everything into the existing SQL database, we've documented the actual requirement:

**Existing transactional data + Marketing data + Website data + Finance data → Centralized Analytics Layer**

That is exactly the kind of gap a BA should identify before development.

### Next

**Step 4 — Data Integration & Transformation Design**

We'll define how these different sources will be brought together and what transformations are required before the KPIs can be calculated.

# 12. Data Integration & Transformation Design

## 12.1 Integration Approach

The analytics layer will combine:

**Walmart Transactional Data + Marketing Data + Website Analytics + Finance Data**

Data will be validated and transformed before KPI calculation and dashboard reporting.

---

## 12.2 Source Integration

| Source | Target | Integration Key |
|---|---|---|
| Customers | Customer Dimension | Customer ID |
| Orders | Order Fact | Order ID / Customer ID |
| Order Items | Order Item Fact | Order ID / Product ID |
| Products | Product Dimension | Product ID |
| Campaigns | Campaign Dimension | Campaign ID |
| Advertising Platforms | Marketing Spend Fact | Campaign ID / Date |
| Website Analytics | Web Session Fact | Campaign ID / Date |
| Finance Revenue | Revenue Layer | Order ID / Date |
| Finance Costs | Finance Cost Fact | Campaign ID / Date |

---

## 12.3 Key Transformations

| Transformation | Purpose |
|---|---|
| Standardize dates/timezones | Consistent reporting |
| Standardize channel names | Consistent channel reporting |
| Standardize campaign IDs | Cross-source campaign matching |
| Deduplicate records | Data quality |
| Handle NULL values | Reliable calculations |
| Classify order status | Completed/cancelled/refunded |
| Apply Finance revenue rules | Recognized revenue |
| Separate platform vs Finance costs | Operational vs Financial KPIs |
| Apply Last-Touch attribution | Campaign reporting |
| Standardize currencies | Financial consistency |

---

## 12.4 Revenue Transformation

Operational transaction data will be reconciled against Finance-recognized revenue.

**Source Transactions → Adjustments → Recognized Revenue → KPI Layer**

Finance-recognized revenue will be used for financial reporting.

---

## 12.5 Marketing Cost Transformation

Marketing costs will be separated into:

- Platform Spend
- Agency Cost
- Creative Cost
- Campaign Expenses
- Other Finance-approved costs

This supports separate Operational and Financial KPI calculations.

---

## 12.6 Attribution Transformation

Phase 1 will use **Last-Touch Attribution**.

Campaign-attributed transactions must be linked to the most recent eligible marketing touchpoint according to the approved attribution rules.

---

## 12.7 Data Quality Checks

Before data reaches the reporting layer:

- Duplicate records must be identified.
- Required keys must be validated.
- Missing values must be flagged.
- Source totals must be reconciled.
- Invalid dates must be identified.
- Referential integrity must be checked.
- KPI inputs must pass validation.

---

## 12.8 Processing Flow

```text
Source Systems
      ↓
Data Extraction
      ↓
Data Validation
      ↓
Transformation
      ↓
Analytics Tables
      ↓
KPI Calculations
      ↓
Dashboards

# 13. SQL Implementation Design

## 13.1 Implementation Approach

SQL implementation will use the existing `walmart_analytics` database as the primary transactional data source.

The implementation will:

1. Reuse existing validated tables where possible.
2. Create analytical tables/views where required.
3. Apply approved business rules.
4. Create KPI calculation queries.
5. Validate results against source data.

---

## 13.2 SQL Layers

| Layer | Purpose |
|---|---|
| Source Tables | Existing Walmart transactional data |
| Staging / Transformation | Standardization and data preparation |
| Analytical Tables | Reporting-ready data |
| KPI Views | Standardized KPI calculations |
| Business Queries | Business analysis |
| Dashboard Layer | Tableau/reporting consumption |

---

## 13.3 SQL Objects

| Object | Purpose |
|---|---|
| Tables | Store analytical data |
| Views | Standardize reusable KPI logic |
| CTEs | Complex transformations |
| Stored Procedures | Repeatable processing where required |
| Indexes | Query performance |
| Constraints | Data integrity |

---

## 13.4 Initial Analytical Objects

The following objects are proposed:

- `dim_customer`
- `dim_campaign`
- `dim_product`
- `dim_date`
- `dim_region`
- `dim_channel`
- `dim_platform`
- `fact_orders`
- `fact_order_items`
- `fact_marketing_spend`
- `fact_campaign_performance`
- `fact_finance_cost`
- `fact_web_sessions`

---

## 13.5 KPI SQL Layer

KPI calculations should be centralized rather than duplicated across dashboards.

Examples:

```text
Operational ROAS
= Campaign-Attributed Sales / Platform Spend

Financial ROAS
= Campaign-Attributed Sales / Finance-Recognized Marketing Cost

CAC
= Approved Acquisition Cost / New Customers

AOV
= Recognized Revenue / Completed Orders

CTR
= Clicks / Impressions × 100

CPC
= Marketing Spend / Clicks