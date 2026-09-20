SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(recognized_revenue_operational) AS monthly_revenue,
    SUM(gross_order_value) AS monthly_gross,
    SUM(total_refunds) AS monthly_refunds
FROM vw_kpi_revenue_operational_daily
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;


SELECT
    p.department,
    p.brand,
    SUM(oi.total_price) AS category_revenue,
    SUM(oi.quantity) AS units_sold,
    COUNT(DISTINCT oi.order_id) AS orders_count
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.department, p.brand
ORDER BY category_revenue DESC
LIMIT 20;

SELECT o.order_id, o.total_amount, SUM(oi.total_price) AS items_sum,
       o.total_amount - SUM(oi.total_price) AS diff
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.total_amount
HAVING ABS(diff) > 1
LIMIT 20;

TRUNCATE TABLE order_items;

SELECT COUNT(*) FROM order_items;

SELECT o.order_id, o.total_amount, SUM(oi.total_price) AS items_sum,
       o.total_amount - SUM(oi.total_price) AS diff
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.total_amount
HAVING ABS(diff) > 1
LIMIT 20;

SELECT o.order_id, o.total_amount, SUM(oi.total_price) AS items_sum,
       o.total_amount - SUM(oi.total_price) AS diff
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.total_amount
HAVING ABS(diff) > 1
LIMIT 20;

SELECT
    p.department,
    p.brand,
    SUM(oi.total_price) AS category_revenue,
    SUM(oi.quantity) AS units_sold,
    COUNT(DISTINCT oi.order_id) AS orders_count
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.department, p.brand
ORDER BY category_revenue DESC
LIMIT 20;

-- Step 1: clear order_items completely (it got corrupted)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE order_items;

-- Step 2: reload order_items correctly
LOAD DATA LOCAL INFILE '/Users/apple/Desktop/Analytics_carrer/Portfolio/Walmart_Analytics_Project/data/generated/order_items.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Step 3: clear products
TRUNCATE TABLE products;

-- Step 4: reload products correctly
LOAD DATA LOCAL INFILE '/Users/apple/Desktop/Analytics_carrer/Portfolio/Walmart_Analytics_Project/data/generated/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET FOREIGN_KEY_CHECKS = 1;

-- Step 5: verify counts
SELECT (SELECT COUNT(*) FROM order_items) AS order_items_count,
       (SELECT COUNT(*) FROM products) AS products_count;
       
SELECT o.order_id, o.total_amount, SUM(oi.total_price) AS items_sum,
       o.total_amount - SUM(oi.total_price) AS diff
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.total_amount
HAVING ABS(diff) > 1
LIMIT 20;

SELECT
    p.department,
    p.brand,
    SUM(oi.total_price) AS category_revenue,
    SUM(oi.quantity) AS units_sold,
    COUNT(DISTINCT oi.order_id) AS orders_count
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.department, p.brand
ORDER BY category_revenue DESC
LIMIT 20;

-- Business question: Which customer segment drives the most revenue — and are we relying on a small group of high-spenders?
SELECT
    c.membership_tier,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS gross_revenue,
    ROUND(SUM(o.total_amount) / COUNT(DISTINCT c.customer_id), 2) AS revenue_per_customer
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.membership_tier
ORDER BY gross_revenue DESC;

-- Business question: Which regions/stores drive the most revenue — any big gaps?

SELECT
    s.region,
    COUNT(DISTINCT s.store_id) AS store_count,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS gross_revenue,
    ROUND(SUM(o.total_amount) / COUNT(DISTINCT s.store_id), 2) AS revenue_per_store
FROM stores s
JOIN orders o ON o.store_id = s.store_id
WHERE o.order_status <> 'Cancelled'
GROUP BY s.region
ORDER BY gross_revenue DESC;

-- Business question: Which channels are performing best — where is spend working, where isn't it?

SELECT
    channel_name,
    COUNT(*) AS campaign_count,
    SUM(operational_spend) AS total_spend,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    ROUND(SUM(clicks) / NULLIF(SUM(impressions), 0) * 100, 2) AS ctr_pct,
    ROUND(SUM(operational_spend) / NULLIF(SUM(clicks), 0), 2) AS avg_cpc,
    ROUND(AVG(self_reported_roas), 2) AS avg_self_reported_roas
FROM vw_kpi_campaign_performance
GROUP BY channel_name
ORDER BY total_spend DESC;

-- 6A. Returns Analysis
-- Business Question
-- Which products/categories have the highest return activity and potential revenue impact?
SELECT
    p.category_id,
    COUNT(r.return_id) AS return_count,
    SUM(r.return_quantity) AS returned_units,
    ROUND(SUM(r.return_quantity * oi.unit_price), 2) AS estimated_return_value
FROM returns r
JOIN order_items oi
    ON r.order_item_id = oi.order_item_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.category_id
ORDER BY returned_units DESC;

-- Business question: What's driving returns — is it concentrated in specific categories/reasons, or spread evenly?
SELECT
    r.return_reason,
    COUNT(*) AS return_count,
    SUM(r.refund_amount) AS total_refunded,
    ROUND(AVG(r.refund_amount), 2) AS avg_refund
FROM returns r
GROUP BY r.return_reason
ORDER BY return_count DESC;

-- One more angle worth checking — which category has the highest return rate, not just count:

SELECT
    p.department,
    COUNT(DISTINCT oi.order_id) AS orders_with_product,
    COUNT(DISTINCT r.order_id) AS orders_returned,
    ROUND(COUNT(DISTINCT r.order_id) / COUNT(DISTINCT oi.order_id) * 100, 2) AS return_rate_pct
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
LEFT JOIN returns r ON r.order_id = oi.order_id
GROUP BY p.department
ORDER BY return_rate_pct DESC;

SELECT * FROM vw_kpi_campaign_performance;