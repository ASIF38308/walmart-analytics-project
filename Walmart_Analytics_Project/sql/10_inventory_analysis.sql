/*
=========================================================
Project : Walmart Retail Analytics
File    : 10_inventory_analysis.sql
Purpose : Inventory Analytics
=========================================================
*/

USE walmart_analytics;

-- =====================================================
-- 1. TOTAL INVENTORY ITEMS
-- Business Question:
-- How many inventory records exist?
-- =====================================================

SELECT
    COUNT(*) AS total_inventory_records
FROM inventory;

-- =====================================================
-- 2. TOTAL AVAILABLE STOCK
-- Business Question:
-- How much stock is currently available?
-- =====================================================

SELECT
    SUM(available_quantity) AS total_available_stock
FROM inventory;

-- =====================================================
-- 3. TOTAL RESERVED STOCK
-- Business Question:
-- How much stock is reserved for orders?
-- =====================================================

SELECT
    SUM(reserved_quantity) AS total_reserved_stock
FROM inventory;

-- =====================================================
-- 4. INVENTORY STATUS DISTRIBUTION
-- Business Question:
-- How many inventory records fall into each status?
-- =====================================================

SELECT
    inventory_status,
    COUNT(*) AS total_records
FROM inventory
GROUP BY inventory_status
ORDER BY total_records DESC;

-- =====================================================
-- 5. TOP 10 PRODUCTS WITH HIGHEST STOCK
-- Business Question:
-- Which products have the highest available inventory?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(i.available_quantity) AS total_stock
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_stock DESC
LIMIT 10;

-- =====================================================
-- 6. TOP 10 PRODUCTS WITH LOWEST STOCK
-- Business Question:
-- Which products are closest to running out?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(i.available_quantity) AS total_stock
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_stock ASC
LIMIT 10;

-- =====================================================
-- 7. AVERAGE STOCK PER PRODUCT
-- Business Question:
-- What is the average available stock per product?
-- =====================================================

SELECT
	 p.product_id,
    p.product_name,
    ROUND(AVG(available_quantity),2) AS average_stock
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY average_stock desc;
-- =====================================================
-- 8. PRODUCTS BELOW REORDER LEVEL
-- Business Question:
-- Which products need to be reordered?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,
    i.available_quantity,
    i.reorder_level
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
WHERE i.available_quantity <= i.reorder_level
ORDER BY i.available_quantity;

-- =====================================================
-- 9. PRODUCTS ABOVE MAXIMUM STOCK
-- Business Question:
-- Which products are overstocked?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,
    i.available_quantity,
    i.max_stock
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
WHERE i.available_quantity > i.max_stock
ORDER BY i.available_quantity DESC;

-- =====================================================
-- 10. INVENTORY UTILIZATION
-- Business Question:
-- What percentage of inventory is currently available?
-- =====================================================

SELECT
    ROUND(
        SUM(available_quantity) * 100 /
        SUM(max_stock),
        2
    ) AS inventory_utilization_percentage
FROM inventory;

-- =====================================================
-- 11. AVERAGE STOCK BY INVENTORY STATUS
-- Business Question:
-- What is the average available stock for each inventory status?
-- =====================================================

SELECT
    inventory_status,
    ROUND(AVG(available_quantity),2) AS average_stock
FROM inventory
GROUP BY inventory_status
ORDER BY average_stock DESC;

-- =====================================================
-- 12. PRODUCTS WITH ZERO AVAILABLE STOCK
-- Business Question:
-- Which products are out of stock?
-- =====================================================

SELECT
    p.product_id,
    p.product_name
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
WHERE i.available_quantity = 0;

-- =====================================================
-- 13. STOCK DISTRIBUTION BY WAREHOUSE
-- Business Question:
-- Which warehouses hold the most inventory?
-- =====================================================

SELECT
    w.warehouse_name,
    SUM(i.available_quantity) AS total_stock
FROM inventory i
JOIN warehouses w
ON i.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_name
ORDER BY total_stock DESC;

-- =====================================================
-- 14. STOCK DISTRIBUTION BY STORE
-- Business Question:
-- Which stores currently hold the most inventory?
-- =====================================================

SELECT
    s.store_name,
    SUM(i.available_quantity) AS total_stock
FROM inventory i
JOIN stores s
ON i.store_id = s.store_id
GROUP BY s.store_name
ORDER BY total_stock DESC;
-- =====================================================
-- 15. TOP 20 FASTEST MOVING PRODUCTS
-- Business Question:
-- Which products have sold the highest quantity?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY units_sold DESC
LIMIT 20;

-- =====================================================
-- 16. TOP 20 SLOWEST MOVING PRODUCTS
-- Business Question:
-- Which products have sold the least quantity?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY units_sold ASC
LIMIT 20;

-- =====================================================
-- 17. INVENTORY TURNOVER BY PRODUCT
-- Business Question:
-- How efficiently is inventory being sold?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,

    SUM(oi.quantity) AS units_sold,

    SUM(i.available_quantity) AS available_stock,

    ROUND(
        SUM(oi.quantity) /
        NULLIF(SUM(i.available_quantity),0),
        2
    ) AS inventory_turnover_ratio

FROM products p

JOIN order_items oi
ON p.product_id = oi.product_id

JOIN inventory i
ON p.product_id = i.product_id

GROUP BY p.product_id, p.product_name

ORDER BY inventory_turnover_ratio DESC;

-- =====================================================
-- 18. DEAD STOCK PRODUCTS
-- Business Question:
-- Which products have inventory but no sales?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(i.available_quantity) AS available_stock

FROM products p

JOIN inventory i
ON p.product_id = i.product_id

LEFT JOIN order_items oi
ON p.product_id = oi.product_id

GROUP BY p.product_id, p.product_name

HAVING COUNT(oi.order_item_id) = 0

ORDER BY available_stock DESC;

-- =====================================================
-- 19. PRODUCTS WITH HIGHEST INVENTORY VALUE
-- Business Question:
-- Which products represent the highest inventory investment?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,

    SUM(i.available_quantity) AS stock,

    ROUND(
        SUM(i.available_quantity * p.cost_price),
        2
    ) AS inventory_value

FROM products p

JOIN inventory i
ON p.product_id = i.product_id

GROUP BY p.product_id, p.product_name

ORDER BY inventory_value DESC

LIMIT 20;

-- =====================================================
-- 20. INVENTORY VALUE BY WAREHOUSE
-- Business Question:
-- Which warehouses hold the highest inventory value?
-- =====================================================

SELECT
    w.warehouse_name,

    ROUND(
        SUM(i.available_quantity * p.cost_price),
        2
    ) AS inventory_value

FROM inventory i

JOIN warehouses w
ON i.warehouse_id = w.warehouse_id

JOIN products p
ON i.product_id = p.product_id

GROUP BY w.warehouse_name

ORDER BY inventory_value DESC;

-- =====================================================
-- 21. INVENTORY RANKING BY STOCK
-- Business Question:
-- Rank products by available inventory.
-- =====================================================

SELECT
    product_id,
    product_name,
    total_stock,

    RANK() OVER
    (
        ORDER BY total_stock DESC
    ) AS stock_rank

FROM
(
    SELECT
        p.product_id,
        p.product_name,
        SUM(i.available_quantity) AS total_stock

    FROM products p

    JOIN inventory i
    ON p.product_id = i.product_id

    GROUP BY p.product_id, p.product_name
) stock_summary;
-- =====================================================
-- 22. ABC INVENTORY CLASSIFICATION
-- Business Question:
-- Classify inventory based on inventory value.
-- =====================================================

WITH inventory_value AS
(
    SELECT
        p.product_id,
        p.product_name,

        ROUND(
            SUM(i.available_quantity * p.cost_price),
            2
        ) AS inventory_value

    FROM products p
    JOIN inventory i
        ON p.product_id = i.product_id

    GROUP BY p.product_id, p.product_name
)

SELECT
    product_id,
    product_name,
    inventory_value,

    CASE
        WHEN inventory_value >= 100000 THEN 'A Class'
        WHEN inventory_value >= 50000 THEN 'B Class'
        ELSE 'C Class'
    END AS abc_category

FROM inventory_value

ORDER BY inventory_value DESC;

-- =====================================================
-- 23. INVENTORY HEALTH SCORE
-- Business Question:
-- Evaluate inventory health based on stock levels.
-- =====================================================

SELECT
    inventory_status,

    COUNT(*) AS total_records,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM inventory),
        2
    ) AS percentage

FROM inventory

GROUP BY inventory_status

ORDER BY percentage DESC;

-- =====================================================
-- 24. TOP 10 WAREHOUSES BY INVENTORY VALUE
-- Business Question:
-- Which warehouses manage the most inventory value?
-- =====================================================

SELECT
    w.warehouse_name,

    ROUND(
        SUM(i.available_quantity * p.cost_price),
        2
    ) AS inventory_value

FROM inventory i

JOIN warehouses w
    ON i.warehouse_id = w.warehouse_id

JOIN products p
    ON i.product_id = p.product_id

GROUP BY w.warehouse_name

ORDER BY inventory_value DESC

LIMIT 10;

-- =====================================================
-- 25. WAREHOUSE RANKING
-- Business Question:
-- Rank warehouses by inventory value.
-- =====================================================

WITH warehouse_value AS
(
    SELECT
        w.warehouse_name,

        ROUND(
            SUM(i.available_quantity * p.cost_price),
            2
        ) AS inventory_value

    FROM inventory i

    JOIN warehouses w
        ON i.warehouse_id = w.warehouse_id

    JOIN products p
        ON i.product_id = p.product_id

    GROUP BY w.warehouse_name
)

SELECT
    warehouse_name,
    inventory_value,

    RANK() OVER
    (
        ORDER BY inventory_value DESC
    ) AS warehouse_rank

FROM warehouse_value;

-- =====================================================
-- 26. INVENTORY STATUS DASHBOARD
-- Business Question:
-- Provide inventory summary KPIs.
-- =====================================================

SELECT
    COUNT(*) AS total_inventory_records,

    SUM(available_quantity) AS total_available_stock,

    SUM(reserved_quantity) AS total_reserved_stock,

    ROUND(
        AVG(available_quantity),
        2
    ) AS average_stock

FROM inventory;

-- =====================================================
-- 27. PRODUCTS CONTRIBUTING MOST TO INVENTORY VALUE
-- Business Question:
-- Which products account for most inventory investment?
-- =====================================================

WITH inventory_value AS
(
    SELECT
        p.product_id,
        p.product_name,

        ROUND(
            SUM(i.available_quantity * p.cost_price),
            2
        ) AS inventory_value

    FROM products p

    JOIN inventory i
        ON p.product_id = i.product_id

    GROUP BY p.product_id, p.product_name
)

SELECT
    product_id,
    product_name,
    inventory_value,

    ROUND(
        inventory_value * 100 /
        SUM(inventory_value) OVER(),
        2
    ) AS inventory_percentage

FROM inventory_value

ORDER BY inventory_value DESC;

-- =====================================================
-- 28. EXECUTIVE INVENTORY SUMMARY
-- Business Question:
-- Display key inventory KPIs in one result.
-- =====================================================

SELECT
    (SELECT COUNT(*) FROM inventory) AS total_inventory_records,

    (SELECT SUM(available_quantity)
     FROM inventory) AS total_available_stock,

    (SELECT SUM(reserved_quantity)
     FROM inventory) AS total_reserved_stock,

    (SELECT COUNT(*)
     FROM inventory
     WHERE available_quantity <= reorder_level)
     AS products_below_reorder_level,

    (SELECT COUNT(*)
     FROM inventory
     WHERE available_quantity = 0)
     AS out_of_stock_products;