/*
=========================================================
Project : Walmart Retail Analytics
File    : 04_indexes.sql
Purpose : Create Indexes for Faster Query Performance
=========================================================
*/

USE walmart_analytics;

-- =============================
-- ORDERS
-- =============================

CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_orders_store
ON orders(store_id);

CREATE INDEX idx_orders_date
ON orders(order_date);

-- =============================
-- ORDER ITEMS
-- =============================

CREATE INDEX idx_orderitems_order
ON order_items(order_id);

CREATE INDEX idx_orderitems_product
ON order_items(product_id);

-- =============================
-- INVENTORY
-- =============================

CREATE INDEX idx_inventory_product
ON inventory(product_id);

CREATE INDEX idx_inventory_store
ON inventory(store_id);

CREATE INDEX idx_inventory_warehouse
ON inventory(warehouse_id);

-- =============================
-- PAYMENTS
-- =============================

CREATE INDEX idx_payments_order
ON payments(order_id);

-- =============================
-- SHIPMENTS
-- =============================

CREATE INDEX idx_shipments_order
ON shipments(order_id);

-- =============================
-- RETURNS
-- =============================

CREATE INDEX idx_returns_order
ON returns(order_id);

SHOW INDEX FROM orders;