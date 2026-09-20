/*
=========================================================
Project : Walmart Retail Analytics
File    : 11_financial_analysis.sql
Purpose : Financial Analytics
=========================================================
*/

USE walmart_analytics;

-- =====================================================
-- 1. TOTAL REVENUE
-- Business Question:
-- What is the total revenue generated?
-- =====================================================

SELECT
    ROUND(SUM(total_amount),2) AS total_revenue
FROM orders;

-- =====================================================
-- 2. TOTAL COST OF GOODS SOLD (COGS)
-- Business Question:
-- What is the total cost of products sold?
-- =====================================================

SELECT
    ROUND(SUM(oi.quantity * p.cost_price),2) AS total_cogs
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id;

-- =====================================================
-- 3. GROSS PROFIT
-- Business Question:
-- What is the gross profit?
-- =====================================================

SELECT
    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS gross_profit
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id;

-- =====================================================
-- 4. GROSS PROFIT MARGIN (%)
-- Business Question:
-- What percentage of revenue is retained as gross profit?
-- =====================================================

SELECT
    ROUND(
        (
            SUM(oi.total_price - (oi.quantity * p.cost_price))
            /
            SUM(oi.total_price)
        ) * 100,
        2
    ) AS gross_profit_margin
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id;

-- =====================================================
-- 5. TOTAL DISCOUNT GIVEN
-- Business Question:
-- How much discount has been offered?
-- =====================================================

SELECT
    ROUND(SUM(discount),2) AS total_discount
FROM order_items;

-- =====================================================
-- 6. TOTAL TAX COLLECTED
-- Business Question:
-- How much tax has been collected?
-- =====================================================

SELECT
    ROUND(SUM(tax),2) AS total_tax
FROM orders;

-- =====================================================
-- 7. AVERAGE PROFIT PER ORDER
-- Business Question:
-- What is the average gross profit per order?
-- =====================================================

SELECT
    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price))
        /
        COUNT(DISTINCT oi.order_id),
        2
    ) AS average_profit_per_order
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id;
-- =====================================================
-- 8. TOP 10 MOST PROFITABLE PRODUCTS
-- Business Question:
-- Which products generate the highest gross profit?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,

    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS gross_profit

FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.product_id, p.product_name

ORDER BY gross_profit DESC

LIMIT 10;

-- =====================================================
-- 9. TOP 10 LEAST PROFITABLE PRODUCTS
-- Business Question:
-- Which products generate the lowest gross profit?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,

    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS gross_profit

FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.product_id, p.product_name

ORDER BY gross_profit ASC

LIMIT 10;

-- =====================================================
-- 10. PROFIT BY BRAND
-- Business Question:
-- Which brands generate the highest profit?
-- =====================================================

SELECT
    p.brand,

    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS gross_profit

FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.brand

ORDER BY gross_profit DESC;

-- =====================================================
-- 11. PROFIT BY DEPARTMENT
-- Business Question:
-- Which departments are most profitable?
-- =====================================================

SELECT
    p.department,

    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS gross_profit

FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.department

ORDER BY gross_profit DESC;

-- =====================================================
-- 12. PROFIT BY STORE
-- Business Question:
-- Which stores generate the highest profit?
-- =====================================================
SELECT
    s.store_name,

    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS gross_profit

FROM orders o

JOIN order_items oi
ON o.order_id = oi.order_id

JOIN products p
ON oi.product_id = p.product_id

JOIN stores s
ON o.store_id = s.store_id

GROUP BY s.store_name

ORDER BY gross_profit DESC;

-- =====================================================
-- 13. PROFIT MARGIN BY BRAND
-- Business Question:
-- Which brands have the highest profit margin?
-- =====================================================

SELECT
    p.brand,

    ROUND(
        (
            SUM(oi.total_price - (oi.quantity * p.cost_price))
            /
            SUM(oi.total_price)
        ) * 100,
        2
    ) AS profit_margin_percentage

FROM order_items oi

JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.brand

ORDER BY profit_margin_percentage DESC;

-- =====================================================
-- 14. TOP 10 HIGHEST PROFIT ORDERS
-- Business Question:
-- Which individual orders generated the most profit?
-- =====================================================

SELECT
    oi.order_id,

    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS order_profit

FROM order_items oi

JOIN products p
ON oi.product_id = p.product_id

GROUP BY oi.order_id

ORDER BY order_profit DESC

LIMIT 10;
-- =====================================================
-- 15. MONTHLY REVENUE TREND
-- Business Question:
-- How has revenue changed month over month?
-- =====================================================

SELECT
    YEAR(order_date) AS year,
    MONTHNAME(order_date) AS month,
    ROUND(SUM(total_amount),2) AS total_revenue
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date), MONTHNAME(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- =====================================================
-- 16. MONTHLY GROSS PROFIT TREND
-- Business Question:
-- How has gross profit changed over time?
-- =====================================================

SELECT
    YEAR(o.order_date) AS year,
    MONTHNAME(o.order_date) AS month,

    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS gross_profit

FROM orders o

JOIN order_items oi
ON o.order_id = oi.order_id

JOIN products p
ON oi.product_id = p.product_id

GROUP BY YEAR(o.order_date), MONTH(o.order_date), MONTHNAME(o.order_date)

ORDER BY YEAR(o.order_date), MONTH(o.order_date);

-- =====================================================
-- 17. MONTHLY DISCOUNT GIVEN
-- Business Question:
-- How much discount was given each month?
-- =====================================================

SELECT
    YEAR(o.order_date) AS year,
    MONTHNAME(o.order_date) AS month,

    ROUND(SUM(oi.discount),2) AS total_discount

FROM orders o

JOIN order_items oi
ON o.order_id = oi.order_id

GROUP BY YEAR(o.order_date), MONTH(o.order_date), MONTHNAME(o.order_date)

ORDER BY YEAR(o.order_date), MONTH(o.order_date);

-- =====================================================
-- 18. DISCOUNT PERCENTAGE BY BRAND
-- Business Question:
-- Which brands receive the highest discounts?
-- =====================================================

SELECT
    p.brand,

    ROUND(
        AVG(
            (oi.discount / NULLIF(oi.unit_price * oi.quantity,0)) * 100
        ),
        2
    ) AS average_discount_percentage

FROM order_items oi

JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.brand

ORDER BY average_discount_percentage DESC;

-- =====================================================
-- 19. TOP 10 MOST DISCOUNTED PRODUCTS
-- Business Question:
-- Which products received the highest total discounts?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,

    ROUND(SUM(oi.discount),2) AS total_discount

FROM order_items oi

JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.product_id, p.product_name

ORDER BY total_discount DESC

LIMIT 10;

-- =====================================================
-- 20. DISCOUNT IMPACT ON PROFIT
-- Business Question:
-- Compare revenue, discount and profit together.
-- =====================================================

SELECT

    ROUND(SUM(oi.total_price),2) AS revenue,

    ROUND(SUM(oi.discount),2) AS total_discount,

    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS gross_profit

FROM order_items oi

JOIN products p
ON oi.product_id = p.product_id;

-- =====================================================
-- 21. MONTHLY FINANCIAL SUMMARY
-- Business Question:
-- Display monthly Revenue, Profit and Discount together.
-- =====================================================

SELECT
    YEAR(o.order_date) AS year,
    MONTHNAME(o.order_date) AS month,

    ROUND(SUM(oi.total_price),2) AS revenue,

    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS gross_profit,

    ROUND(SUM(oi.discount),2) AS total_discount

FROM orders o

JOIN order_items oi
ON o.order_id = oi.order_id

JOIN products p
ON oi.product_id = p.product_id

GROUP BY YEAR(o.order_date), MONTH(o.order_date), MONTHNAME(o.order_date)

ORDER BY YEAR(o.order_date), MONTH(o.order_date);
-- =====================================================
-- 22. REVENUE CONTRIBUTION BY DEPARTMENT
-- Business Question:
-- Which departments contribute the most revenue?
-- =====================================================

SELECT
    p.department,
    ROUND(SUM(oi.total_price),2) AS revenue,

    ROUND(
        SUM(oi.total_price) * 100 /
        SUM(SUM(oi.total_price)) OVER(),
        2
    ) AS revenue_percentage

FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.department

ORDER BY revenue DESC;

-- =====================================================
-- 23. TOP 10% PRODUCTS BY PROFIT
-- Business Question:
-- Which products belong to the highest profit group?
-- =====================================================

WITH product_profit AS
(
    SELECT
        p.product_id,
        p.product_name,

        ROUND(
            SUM(oi.total_price - (oi.quantity * p.cost_price)),
            2
        ) AS gross_profit,

        NTILE(10) OVER
        (
            ORDER BY
            SUM(oi.total_price - (oi.quantity * p.cost_price)) DESC
        ) AS profit_decile

    FROM order_items oi

    JOIN products p
    ON oi.product_id = p.product_id

    GROUP BY p.product_id, p.product_name
)

SELECT *

FROM product_profit

WHERE profit_decile = 1

ORDER BY gross_profit DESC;

-- =====================================================
-- 24. RUNNING REVENUE
-- Business Question:
-- Calculate cumulative revenue across orders.
-- =====================================================

SELECT
    order_date,

    ROUND(SUM(total_amount),2) AS daily_revenue,

    ROUND(
        SUM(SUM(total_amount))
        OVER
        (
            ORDER BY order_date
        ),
        2
    ) AS cumulative_revenue

FROM orders

GROUP BY order_date

ORDER BY order_date;

-- =====================================================
-- 25. DAILY REVENUE RANKING
-- Business Question:
-- Rank days based on revenue.
-- =====================================================

SELECT
    order_date,

    ROUND(SUM(total_amount),2) AS revenue,

    RANK() OVER
    (
        ORDER BY SUM(total_amount) DESC
    ) AS revenue_rank

FROM orders

GROUP BY order_date;

-- =====================================================
-- 26. EXECUTIVE FINANCIAL KPI DASHBOARD
-- Business Question:
-- Display important financial KPIs.
-- =====================================================

SELECT

    (SELECT ROUND(SUM(total_amount),2)
     FROM orders) AS total_revenue,

    (SELECT ROUND(SUM(oi.quantity * p.cost_price),2)
     FROM order_items oi
     JOIN products p
     ON oi.product_id = p.product_id) AS total_cogs,

    (SELECT ROUND(
            SUM(oi.total_price - (oi.quantity * p.cost_price)),
            2
        )
     FROM order_items oi
     JOIN products p
     ON oi.product_id = p.product_id) AS gross_profit,

    (SELECT ROUND(AVG(total_amount),2)
     FROM orders) AS average_order_value,

    (SELECT ROUND(SUM(discount),2)
     FROM order_items) AS total_discount,

    (SELECT ROUND(SUM(tax),2)
     FROM orders) AS total_tax;

-- =====================================================
-- 27. EXECUTIVE FINANCIAL SUMMARY
-- Business Question:
-- Present the key financial metrics in one result.
-- =====================================================

SELECT
    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT customer_id) AS total_customers,

    ROUND(SUM(total_amount),2) AS revenue,

    ROUND(AVG(total_amount),2) AS average_order_value,

    ROUND(MAX(total_amount),2) AS highest_order,

    ROUND(MIN(total_amount),2) AS lowest_order

FROM orders;

-- =====================================================
-- 28. FINANCIAL HEALTH SNAPSHOT
-- Business Question:
-- Summarize revenue, profit, discounts and taxes.
-- =====================================================

SELECT

    ROUND(SUM(oi.total_price),2) AS revenue,

    ROUND(
        SUM(oi.total_price - (oi.quantity * p.cost_price)),
        2
    ) AS gross_profit,

    ROUND(SUM(oi.discount),2) AS total_discount,

    ROUND(SUM(o.tax),2) AS total_tax,

    ROUND(
        (
            SUM(oi.total_price - (oi.quantity * p.cost_price))
            /
            SUM(oi.total_price)
        ) * 100,
        2
    ) AS gross_margin_percentage

FROM orders o

JOIN order_items oi
ON o.order_id = oi.order_id

JOIN products p
ON oi.product_id = p.product_id;