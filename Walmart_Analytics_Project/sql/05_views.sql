/*
=========================================================
Project : Walmart Retail Analytics
File    : 05_views.sql
Purpose : Business Analytics Views
=========================================================
*/

USE walmart_analytics;

-- ============================================
-- 1. SALES OVERVIEW
-- ============================================

CREATE OR REPLACE VIEW vw_sales_overview AS
SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    s.store_name,
    o.payment_method,
    o.order_status,
    o.total_amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN stores s
    ON o.store_id = s.store_id;

-- ============================================
-- 2. PRODUCT SALES
-- ============================================

CREATE OR REPLACE VIEW vw_product_sales AS
SELECT
    p.product_id,
    p.product_name,
    p.brand,
    p.department,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.total_price) AS total_sales
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY
p.product_id,
p.product_name,
p.brand,
p.department;

-- ============================================
-- 3. CUSTOMER SUMMARY
-- ============================================

CREATE OR REPLACE VIEW vw_customer_summary AS
SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    c.membership_tier,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY
c.customer_id,
customer_name,
c.membership_tier;

-- ============================================
-- 4. INVENTORY STATUS
-- ============================================

CREATE OR REPLACE VIEW vw_inventory_status AS
SELECT
    i.inventory_id,
    p.product_name,
    s.store_name,
    w.warehouse_name,
    i.stock_quantity,
    i.available_quantity,
    i.inventory_status
FROM inventory i
JOIN products p
ON i.product_id=p.product_id
JOIN stores s
ON i.store_id=s.store_id
JOIN warehouses w
ON i.warehouse_id=w.warehouse_id;

-- ============================================
-- 5. STORE PERFORMANCE
-- ============================================

CREATE OR REPLACE VIEW vw_store_performance AS
SELECT
    s.store_id,
    s.store_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue
FROM stores s
LEFT JOIN orders o
ON s.store_id=o.store_id
GROUP BY
s.store_id,
s.store_name;

SHOW FULL TABLES
WHERE Table_type='VIEW';

SELECT *
FROM vw_sales_overview
LIMIT 10;