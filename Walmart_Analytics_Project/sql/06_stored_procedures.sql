/*
=========================================================
Project : Walmart Retail Analytics
File    : 06_stored_procedures.sql
Purpose : Business Stored Procedures
=========================================================
*/

USE walmart_analytics;

DELIMITER $$

-- =====================================================
-- 1. SALES BY STORE
-- =====================================================

CREATE PROCEDURE sp_store_sales(IN p_store_id INT)
BEGIN

    SELECT
        s.store_name,
        COUNT(o.order_id) AS total_orders,
        ROUND(SUM(o.total_amount),2) AS total_sales,
        ROUND(AVG(o.total_amount),2) AS average_order_value

    FROM stores s
    JOIN orders o
        ON s.store_id = o.store_id

    WHERE s.store_id = p_store_id

    GROUP BY s.store_name;

END $$

-- =====================================================
-- 2. CUSTOMER PURCHASE HISTORY
-- =====================================================

CREATE PROCEDURE sp_customer_history(IN p_customer_id INT)
BEGIN

    SELECT
        o.order_id,
        o.order_date,
        o.payment_method,
        o.order_status,
        o.total_amount

    FROM orders o

    WHERE o.customer_id = p_customer_id

    ORDER BY o.order_date DESC;

END $$

-- =====================================================
-- 3. LOW STOCK PRODUCTS
-- =====================================================

CREATE PROCEDURE sp_low_stock()
BEGIN

    SELECT
        inventory_id,
        product_id,
        store_id,
        available_quantity,
        reorder_level

    FROM inventory

    WHERE available_quantity <= reorder_level

    ORDER BY available_quantity;

END $$

-- =====================================================
-- 4. TOP SELLING PRODUCTS
-- =====================================================

CREATE PROCEDURE sp_top_products(IN p_limit INT)
BEGIN

    SELECT
        p.product_name,
        SUM(oi.quantity) AS total_units_sold,
        ROUND(SUM(oi.total_price),2) AS total_sales

    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id

    GROUP BY p.product_name

    ORDER BY total_units_sold DESC

    LIMIT p_limit;

END $$

DELIMITER ;
SHOW PROCEDURE STATUS
WHERE Db='walmart_analytics';

CALL sp_store_sales(10);

CALL sp_customer_history(100);