# Walmart Centralized Analytics Platform

An end-to-end retail + marketing analytics portfolio project — from
business requirements through SQL development, validation, business
analysis, and a Tableau dashboard.

## What this project demonstrates

- Business analysis: requirements gathering, KPI definition, stakeholder
  dashboard scoping (see `01_Project_Management/`)
- SQL development: analytical schema design, reusable KPI views,
  validation queries (see `sql/`)
- Data quality investigation: two real data-generation bugs were found
  and fixed mid-project (order line-items not reconciling to order
  totals; product brands randomly mismatched to departments) — see
  `01_Project_Management/07_Business_Analysis_Findings.md`
- Honest scope-tracking: not every KPI stakeholders asked for could be
  built — missing Finance data and (initially) missing attribution
  data are tracked explicitly rather than glossed over, see
  `01_Project_Management/Requirements_Register.md`
- A working synthetic Last-Touch attribution layer, built after
  confirming it was in-scope per the BRD (see below)
- Business analysis and insights translated into concrete
  recommendations (see `08_Insights_and_Recommendations.md`)
- A Tableau dashboard covering what's deliverable from the available
  data

## Project structure

```
01_Project_Management/       Business requirements, KPI dictionary,
                              meeting minutes, findings, requirements
                              register, recommendations
sql/
  schema.sql, 02_create_tables.sql   OLTP table definitions
  analytics/
    analytical_schema.sql            Star schema (structural, ETL pending)
    kpi_views.sql                    10 reusable KPI views
    validation_queries.sql           Reconciliation & data-quality checks
python/                      Synthetic data generators + ETL scripts
data/generated/               Generated CSVs (source data)
```

## Key honest limitations (see Requirements Register for full detail)

- **No Finance data source exists** — Revenue/AOV are built from
  transactional data as an interim measure, not Finance's official
  recognized figures. Financial ROAS, ROI, CAC, and Financial CPC
  remain blocked for the same reason.
- **The dashboard is one combined view**, not the 4 role-based
  dashboards (Executive/Marketing/Finance/Product) the BRD specifies —
  because most requested KPIs for those dashboards depend on the
  missing Finance data. What's built covers what's actually available.
- **Campaign attribution is synthetic** — no real click/session
  tracking data exists, so `order_campaign_attribution` simulates
  Last-Touch Attribution with a documented, reasonable rule rather
  than real user behavior data.

These aren't oversights — they're the kind of data-availability gaps
a real Data/BI team runs into, tracked the way a real team would track
them: documented, not faked.

## Tech stack

MySQL 8.0.32 · Python (synthetic data generation) · Tableau Public ·
MySQL Workbench · VS Code
