/*
=========================================================
Project : Walmart Retail Analytics
File    : 12_marketing_analysis.sql
Purpose : Marketing Analytics
=========================================================
*/

USE walmart_analytics;

-- =====================================================
-- 1. CUSTOMERS BY ACQUISITION CHANNEL
-- Business Question:
-- Which channels acquire the most customers?
-- =====================================================

SELECT
    acquisition_channel,
    COUNT(*) AS total_customers
FROM customers
GROUP BY acquisition_channel
ORDER BY total_customers DESC;

-- =====================================================
-- 2. REVENUE BY ACQUISITION CHANNEL
-- Business Question:
-- Which acquisition channels generate the highest revenue?
-- =====================================================

SELECT
    c.acquisition_channel,

    ROUND(
        SUM(o.total_amount),
        2
    ) AS total_revenue

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

GROUP BY c.acquisition_channel

ORDER BY total_revenue DESC;

-- =====================================================
-- 3. AVERAGE ORDER VALUE BY ACQUISITION CHANNEL
-- Business Question:
-- Which channels bring higher-value customers?
-- =====================================================

SELECT
    c.acquisition_channel,

    ROUND(
        AVG(o.total_amount),
        2
    ) AS average_order_value

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

GROUP BY c.acquisition_channel

ORDER BY average_order_value DESC;

-- =====================================================
-- 4. CUSTOMER LIFETIME VALUE BY ACQUISITION CHANNEL
-- Business Question:
-- Which channels bring the most valuable customers?
-- =====================================================

SELECT
    c.acquisition_channel,

    ROUND(
        SUM(o.total_amount),
        2
    ) AS customer_lifetime_value

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

GROUP BY c.acquisition_channel

ORDER BY customer_lifetime_value DESC;

-- =====================================================
-- 5. ACTIVE CUSTOMERS BY ACQUISITION CHANNEL
-- Business Question:
-- Which channels have the most active customers?
-- =====================================================

SELECT
    acquisition_channel,

    COUNT(*) AS active_customers

FROM customers

WHERE customer_status='Active'

GROUP BY acquisition_channel

ORDER BY active_customers DESC;

-- =====================================================
-- 6. CUSTOMER DISTRIBUTION BY PREFERRED CHANNEL
-- Business Question:
-- Which shopping channel do customers prefer?
-- =====================================================

SELECT
    preferred_channel,

    COUNT(*) AS total_customers

FROM customers

GROUP BY preferred_channel

ORDER BY total_customers DESC;

-- =====================================================
-- 7. REVENUE BY PREFERRED CHANNEL
-- Business Question:
-- Which shopping channel generates the highest revenue?
-- =====================================================

SELECT
    c.preferred_channel,

    ROUND(
        SUM(o.total_amount),
        2
    ) AS total_revenue

FROM customers c

JOIN orders o
ON c.customer_id=o.customer_id

GROUP BY c.preferred_channel

ORDER BY total_revenue DESC;
-- =====================================================
-- 8. CUSTOMER ACQUISITION COST (CAC)
-- Business Question:
-- What is the average cost to acquire one customer?
-- =====================================================

SELECT
    500000 AS total_marketing_spend,
    COUNT(*) AS new_customers,

    ROUND(
        500000 / COUNT(*),
        2
    ) AS customer_acquisition_cost

FROM customers;

-- =====================================================
-- 9. RETURN ON AD SPEND (ROAS)
-- Business Question:
-- How much revenue is generated for every ₹1 spent?
-- =====================================================

SELECT

    ROUND(SUM(o.total_amount),2) AS revenue,

    500000 AS marketing_spend,

    ROUND(
        SUM(o.total_amount)/500000,
        2
    ) AS roas

FROM orders o;

-- =====================================================
-- 10. RETURN ON INVESTMENT (ROI)
-- Business Question:
-- What is the return on marketing investment?
-- =====================================================

SELECT

    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS profit,

    500000 AS marketing_spend,

    ROUND(

        (
            SUM(oi.total_price - (oi.quantity * p.cost_price))
            - 500000
        )

        /500000*100,

        2

    ) AS roi_percentage

FROM order_items oi

JOIN products p
ON oi.product_id=p.product_id;

-- =====================================================
-- 11. REVENUE PER CUSTOMER
-- Business Question:
-- How much revenue does each customer generate on average?
-- =====================================================

SELECT

    ROUND(
        SUM(total_amount)/
        COUNT(DISTINCT customer_id),
        2
    ) AS revenue_per_customer

FROM orders;

-- =====================================================
-- 12. TOP ACQUISITION CHANNELS BY CLV
-- Business Question:
-- Which marketing channels acquire
-- the highest-value customers?
-- =====================================================

SELECT

    c.acquisition_channel,

    ROUND(
        AVG(customer_total),
        2
    ) AS average_clv

FROM
(
    SELECT

        customer_id,

        SUM(total_amount) AS customer_total

    FROM orders

    GROUP BY customer_id

) customer_clv

JOIN customers c
ON customer_clv.customer_id=c.customer_id

GROUP BY c.acquisition_channel

ORDER BY average_clv DESC;

-- =====================================================
-- 13. CHANNEL PERFORMANCE RANKING
-- Business Question:
-- Rank acquisition channels by revenue.
-- =====================================================

SELECT

    acquisition_channel,

    revenue,

    RANK() OVER
    (
        ORDER BY revenue DESC
    ) AS channel_rank

FROM
(
    SELECT

        c.acquisition_channel,

        SUM(o.total_amount) AS revenue

    FROM customers c

    JOIN orders o
    ON c.customer_id=o.customer_id

    GROUP BY acquisition_channel

) channel_summary;

-- =====================================================
-- 14. EXECUTIVE MARKETING KPI DASHBOARD
-- Business Question:
-- Display important marketing KPIs.
-- =====================================================

SELECT

    COUNT(*) AS total_customers,

    COUNT(
        DISTINCT acquisition_channel
    ) AS acquisition_channels,

    ROUND(
        (
            SELECT SUM(total_amount)
            FROM orders
        ),
        2
    ) AS total_revenue,

    ROUND(
        (
            SELECT AVG(total_amount)
            FROM orders
        ),
        2
    ) AS average_order_value,

    ROUND(
        500000/COUNT(*),
        2
    ) AS customer_acquisition_cost

FROM customers;