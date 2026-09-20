/*
=========================================================
Project : Walmart Retail Analytics
File    : 08_sales_analysis.sql
Purpose : Sales Analytics
=========================================================
*/

USE walmart_analytics;

-- =====================================================
-- 1. TOTAL REVENUE
-- Business Question:
-- How much revenue has Walmart generated?
-- =====================================================

SELECT
    ROUND(SUM(total_amount),2) AS total_revenue
FROM orders;

-- =====================================================
-- 2. TOTAL ORDERS
-- Business Question:
-- How many orders were placed?
-- =====================================================

SELECT
    COUNT(*) AS total_orders
FROM orders;

-- =====================================================
-- 3. TOTAL CUSTOMERS
-- Business Question:
-- How many customers do we have?
-- =====================================================

SELECT
    COUNT(*) AS total_customers
FROM customers;

-- =====================================================
-- 4. AVERAGE ORDER VALUE (AOV)
-- Business Question:
-- What is the average amount spent per order?
-- =====================================================

SELECT
    ROUND(AVG(total_amount),2) AS average_order_value
FROM orders;

-- =====================================================
-- 5. HIGHEST VALUE ORDER
-- Business Question:
-- Which order generated the highest revenue?
-- =====================================================

SELECT
    order_id,
    total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 1;

-- =====================================================
-- 6. LOWEST VALUE ORDER
-- Business Question:
-- Which order generated the lowest revenue?
-- =====================================================

SELECT
    order_id,
    total_amount
FROM orders
ORDER BY total_amount ASC
LIMIT 1;

-- =====================================================
-- 7. MONTHLY REVENUE
-- Business Question:
-- How much revenue was generated each month?
-- =====================================================

SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    ROUND(SUM(total_amount),2) AS monthly_revenue
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- =====================================================
-- 8. MONTHLY ORDER COUNT
-- Business Question:
-- How many orders were placed each month?
-- =====================================================

SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- =====================================================
-- 9. DAILY SALES TREND
-- Business Question:
-- What is the daily revenue trend?
-- =====================================================

SELECT
    order_date,
    ROUND(SUM(total_amount),2) AS daily_revenue
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- =====================================================
-- 10. SALES BY WEEKDAY
-- Business Question:
-- Which day of the week generates the most revenue?
-- =====================================================

SELECT
    DAYNAME(order_date) AS weekday,
    ROUND(SUM(total_amount),2) AS revenue
FROM orders
GROUP BY DAYNAME(order_date)
ORDER BY revenue DESC;

-- =====================================================
-- 11. BEST SALES DAY
-- Business Question:
-- Which single day generated the highest revenue?
-- =====================================================

SELECT
    order_date,
    ROUND(SUM(total_amount),2) AS revenue
FROM orders
GROUP BY order_date
ORDER BY revenue DESC
LIMIT 1;

-- =====================================================
-- 12. WORST SALES DAY
-- Business Question:
-- Which single day generated the lowest revenue?
-- =====================================================

SELECT
    order_date,
    ROUND(SUM(total_amount),2) AS revenue
FROM orders
GROUP BY order_date
ORDER BY revenue ASC
LIMIT 1;
-- =====================================================
-- 13. REVENUE BY STORE
-- Business Question:
-- Which stores generate the highest revenue?
-- =====================================================

SELECT
    s.store_id,
    s.store_name,
    ROUND(SUM(o.total_amount),2) AS total_revenue
FROM stores s
JOIN orders o
    ON s.store_id = o.store_id
GROUP BY s.store_id, s.store_name
ORDER BY total_revenue DESC;

-- =====================================================
-- 14. TOP 10 STORES BY REVENUE
-- Business Question:
-- Which are the top 10 performing stores?
-- =====================================================
SELECT
    s.store_id,
    s.store_name,
    ROUND(SUM(o.total_amount),2) AS total_revenue
FROM stores s
JOIN orders o
    ON s.store_id = o.store_id
GROUP BY s.store_id, s.store_name
ORDER BY total_revenue DESC
LIMIT 10;

-- =====================================================
-- 15. BOTTOM 10 STORES BY REVENUE
-- Business Question:
-- Which stores need attention?
-- =====================================================

SELECT
    s.store_id,
    s.store_name,
    ROUND(SUM(o.total_amount),2) AS total_revenue
FROM stores s
JOIN orders o
    ON s.store_id = o.store_id
GROUP BY s.store_id, s.store_name
ORDER BY total_revenue ASC
LIMIT 10;

-- =====================================================
-- 16. TOTAL ORDERS BY STORE
-- Business Question:
-- Which stores receive the highest number of orders?
-- =====================================================

SELECT
    s.store_id,
    s.store_name,
    COUNT(o.order_id) AS total_orders
FROM stores s
JOIN orders o
    ON s.store_id = o.store_id
GROUP BY s.store_id, s.store_name
ORDER BY total_orders DESC;

-- =====================================================
-- 17. AVERAGE ORDER VALUE BY STORE
-- Business Question:
-- Which stores have the highest average customer spend?
-- =====================================================

SELECT
    s.store_id,
    s.store_name,
    ROUND(AVG(o.total_amount),2) AS average_order_value
FROM stores s
JOIN orders o
    ON s.store_id = o.store_id
GROUP BY s.store_id, s.store_name
ORDER BY average_order_value DESC;

-- =====================================================
-- 18. STORE REVENUE CONTRIBUTION (%)
-- Business Question:
-- What percentage of total revenue does each store contribute?
-- =====================================================

SELECT
    s.store_name,
    ROUND(SUM(o.total_amount),2) AS revenue,
    ROUND(
        SUM(o.total_amount) * 100 /
        (SELECT SUM(total_amount) FROM orders),
        2
    ) AS revenue_percentage
FROM stores s
JOIN orders o
    ON s.store_id = o.store_id
GROUP BY s.store_name
ORDER BY revenue DESC;
-- =====================================================
-- 19. TOP 10 BEST-SELLING PRODUCTS (BY QUANTITY)
-- Business Question:
-- Which products sell the most units?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_units_sold DESC
LIMIT 10;

-- =====================================================
-- 20. TOP 10 PRODUCTS BY REVENUE
-- Business Question:
-- Which products generate the highest revenue?
-- =====================================================

SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.total_price),2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 10;

-- =====================================================
-- 21. REVENUE BY BRAND
-- Business Question:
-- Which brands contribute the most revenue?
-- =====================================================

SELECT
    p.brand,
    ROUND(SUM(oi.total_price),2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.brand
ORDER BY total_revenue DESC;

-- =====================================================
-- 22. REVENUE BY DEPARTMENT
-- Business Question:
-- Which department generates the highest sales?
-- =====================================================

SELECT
    p.department,
    ROUND(SUM(oi.total_price),2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.department
ORDER BY total_revenue DESC;

-- =====================================================
-- 23. TOP 10 PRODUCTS BY AVERAGE SELLING PRICE
-- Business Question:
-- Which products have the highest average selling price?
-- =====================================================

SELECT
    p.product_name,
    ROUND(AVG(oi.unit_price),2) AS average_selling_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY average_selling_price DESC
LIMIT 10;

-- =====================================================
-- 24. TOP 10 MOST REVIEWED PRODUCTS
-- Business Question:
-- Which products have received the most reviews?
-- =====================================================

SELECT
    product_id,
    product_name,
    review_count,
    rating
FROM products
ORDER BY review_count DESC
LIMIT 10;
-- =====================================================
-- 25. TOP 10 HIGHEST SPENDING CUSTOMERS
-- Business Question:
-- Who are our most valuable customers?
-- =====================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    ROUND(SUM(o.total_amount),2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- =====================================================
-- 26. TOTAL REVENUE BY MEMBERSHIP TIER
-- Business Question:
-- Which membership tier generates the most revenue?
-- =====================================================

SELECT
    c.membership_tier,
    ROUND(SUM(o.total_amount),2) AS total_revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.membership_tier
ORDER BY total_revenue DESC;

-- =====================================================
-- 27. TOTAL CUSTOMERS BY MEMBERSHIP TIER
-- Business Question:
-- How many customers belong to each membership tier?
-- =====================================================

SELECT
    membership_tier,
    COUNT(*) AS total_customers
FROM customers
GROUP BY membership_tier
ORDER BY total_customers DESC;

-- =====================================================
-- 28. AVERAGE SPEND PER CUSTOMER
-- Business Question:
-- On average, how much does each customer spend?
-- =====================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    ROUND(AVG(o.total_amount),2) AS average_spend
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY average_spend DESC;

-- =====================================================
-- 29. CUSTOMER PURCHASE FREQUENCY
-- Business Question:
-- How many orders has each customer placed?
-- =====================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_orders DESC;

-- =====================================================
-- 30. REVENUE BY CUSTOMER STATUS
-- Business Question:
-- Which customer status contributes the most revenue?
-- =====================================================

SELECT
    c.customer_status,
    ROUND(SUM(o.total_amount),2) AS total_revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_status
ORDER BY total_revenue DESC;
-- =====================================================
-- 31. REVENUE BY PAYMENT METHOD
-- Business Question:
-- Which payment method generates the most revenue?
-- =====================================================

SELECT
    payment_method,
    ROUND(SUM(total_amount),2) AS total_revenue
FROM orders
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- =====================================================
-- 32. TOTAL ORDERS BY PAYMENT METHOD
-- Business Question:
-- Which payment method is used the most?
-- =====================================================

SELECT
    payment_method,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;

-- =====================================================
-- 33. ORDER STATUS DISTRIBUTION
-- Business Question:
-- How many orders fall into each status?
-- =====================================================

SELECT
    order_status,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- =====================================================
-- 34. AVERAGE ORDER VALUE BY PAYMENT METHOD
-- Business Question:
-- Which payment method has the highest average order value?
-- =====================================================

SELECT
    payment_method,
    ROUND(AVG(total_amount),2) AS average_order_value
FROM orders
GROUP BY payment_method
ORDER BY average_order_value DESC;

-- =====================================================
-- 35. PAYMENT METHOD SHARE (%)
-- Business Question:
-- What percentage of total orders comes from each payment method?
-- =====================================================

SELECT
    payment_method,
    COUNT(order_id) AS total_orders,
    ROUND(
        COUNT(order_id) * 100.0 /
        (SELECT COUNT(*) FROM orders),
        2
    ) AS order_percentage
FROM orders
GROUP BY payment_method
ORDER BY order_percentage DESC;

-- =====================================================
-- 36. ORDER STATUS PERCENTAGE
-- Business Question:
-- What percentage of orders are in each status?
-- =====================================================

SELECT
    order_status,
    COUNT(order_id) AS total_orders,
    ROUND(
        COUNT(order_id) * 100.0 /
        (SELECT COUNT(*) FROM orders),
        2
    ) AS percentage
FROM orders
GROUP BY order_status
ORDER BY percentage DESC;
-- =====================================================
-- 37. REVENUE BY CATEGORY
-- Business Question:
-- Which product categories generate the highest revenue?
-- =====================================================

SELECT
    c.category,
    ROUND(SUM(oi.total_price),2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.department = c.department
GROUP BY c.category
ORDER BY total_revenue DESC;

-- =====================================================
-- 38. TOP 10 CATEGORIES BY REVENUE
-- Business Question:
-- Which categories contribute the most revenue?
-- =====================================================

SELECT
    c.category,
    ROUND(SUM(oi.total_price),2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.department = c.department
GROUP BY c.category
ORDER BY total_revenue DESC
LIMIT 10;

-- =====================================================
-- 39. REVENUE BY SUBCATEGORY
-- Business Question:
-- Which subcategories perform the best?
-- =====================================================

SELECT
    c.subcategory,
    ROUND(SUM(oi.total_price),2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.department = c.department
GROUP BY c.subcategory
ORDER BY total_revenue DESC;

-- =====================================================
-- 40. DEPARTMENT PERFORMANCE
-- Business Question:
-- Which departments generate the highest revenue?
-- =====================================================

SELECT
    p.department,
    ROUND(SUM(oi.total_price),2) AS total_revenue,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.department
ORDER BY total_revenue DESC;

-- =====================================================
-- 41. CATEGORY CONTRIBUTION (%)
-- Business Question:
-- What percentage of total revenue comes from each category?
-- =====================================================

SELECT
    c.category,
    ROUND(SUM(oi.total_price),2) AS revenue,
    ROUND(
        SUM(oi.total_price) * 100 /
        (SELECT SUM(total_price) FROM order_items),
        2
    ) AS revenue_percentage
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.department = c.department
GROUP BY c.category
ORDER BY revenue DESC;

-- =====================================================
-- 42. TOP 5 DEPARTMENTS BY AVERAGE SELLING PRICE
-- Business Question:
-- Which departments sell the highest-value products?
-- =====================================================

SELECT
    p.department,
    ROUND(AVG(oi.unit_price),2) AS average_selling_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.department
ORDER BY average_selling_price DESC
LIMIT 5;
-- =====================================================
-- 43. TOP 5 REVENUE-GENERATING STATES
-- Business Question:
-- Which states generate the highest revenue?
-- =====================================================

SELECT
    s.state,
    ROUND(SUM(o.total_amount),2) AS total_revenue
FROM orders o
JOIN stores s
ON o.store_id = s.store_id
GROUP BY s.state
ORDER BY total_revenue DESC
LIMIT 5;

-- =====================================================
-- 44. REVENUE BY REGION
-- Business Question:
-- Which region contributes the most revenue?
-- =====================================================

SELECT
    s.region,
    ROUND(SUM(o.total_amount),2) AS total_revenue
FROM orders o
JOIN stores s
ON o.store_id = s.store_id
GROUP BY s.region
ORDER BY total_revenue DESC;

-- =====================================================
-- 45. TOP 5 CITIES BY REVENUE
-- Business Question:
-- Which cities perform the best?
-- =====================================================

SELECT
    s.city,
    ROUND(SUM(o.total_amount),2) AS total_revenue
FROM orders o
JOIN stores s
ON o.store_id = s.store_id
GROUP BY s.city
ORDER BY total_revenue DESC
LIMIT 5;

-- =====================================================
-- 46. AVERAGE REVENUE PER ORDER
-- Business Question:
-- What is the average revenue generated from one order?
-- =====================================================

SELECT
    ROUND(AVG(total_amount),2) AS average_revenue_per_order
FROM orders;

-- =====================================================
-- 47. HIGHEST REVENUE MONTH
-- Business Question:
-- Which month generated the highest revenue?
-- =====================================================

SELECT
    YEAR(order_date) AS year,
    MONTHNAME(order_date) AS month,
    ROUND(SUM(total_amount),2) AS revenue
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date), MONTHNAME(order_date)
ORDER BY revenue DESC
LIMIT 1;

-- =====================================================
-- 48. STORE RANKING BY REVENUE
-- Business Question:
-- Rank stores based on revenue.
-- =====================================================

SELECT
    s.store_name,
    ROUND(SUM(o.total_amount),2) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(o.total_amount) DESC
    ) AS revenue_rank
FROM stores s
JOIN orders o
ON s.store_id = o.store_id
GROUP BY s.store_name;

-- =====================================================
-- 49. TOP 5 CUSTOMERS BY NUMBER OF ORDERS
-- Business Question:
-- Which customers place the most orders?
-- =====================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_orders DESC
LIMIT 5;

-- =====================================================
-- 50. TOP 5 STORES BY AVERAGE ORDER VALUE
-- Business Question:
-- Which stores achieve the highest spend per order?
-- =====================================================

SELECT
    s.store_name,
    ROUND(AVG(o.total_amount),2) AS average_order_value
FROM stores s
JOIN orders o
ON s.store_id = o.store_id
GROUP BY s.store_name
ORDER BY average_order_value DESC
LIMIT 5;

-- =====================================================
-- 51. EXECUTIVE SALES DASHBOARD SUMMARY
-- Business Question:
-- Display key business KPIs in one result.
-- =====================================================

SELECT
    (SELECT ROUND(SUM(total_amount),2) FROM orders) AS total_revenue,
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT ROUND(AVG(total_amount),2) FROM orders) AS average_order_value,
    (SELECT MAX(total_amount) FROM orders) AS highest_order_value,
    (SELECT MIN(total_amount) FROM orders) AS lowest_order_value;