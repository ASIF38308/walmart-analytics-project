/*
=========================================================
Project : Walmart Retail Analytics
File    : 03_foreign_keys.sql
Purpose : Create Foreign Key Relationships
=========================================================
*/

USE walmart_analytics;

-- =====================================================
-- ORDERS
-- =====================================================

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_store
FOREIGN KEY (store_id)
REFERENCES stores(store_id);

-- =====================================================
-- ORDER ITEMS
-- =====================================================

ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_orderitems_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- =====================================================
-- PAYMENTS
-- =====================================================

ALTER TABLE payments
ADD CONSTRAINT fk_payments_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- =====================================================
-- SHIPMENTS
-- =====================================================

ALTER TABLE shipments
ADD CONSTRAINT fk_shipments_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- =====================================================
-- RETURNS
-- =====================================================

ALTER TABLE returns
ADD CONSTRAINT fk_returns_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- =====================================================
-- INVENTORY
-- =====================================================

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_store
FOREIGN KEY (store_id)
REFERENCES stores(store_id);

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_warehouse
FOREIGN KEY (warehouse_id)
REFERENCES warehouses(warehouse_id);

SELECT
    TABLE_NAME,
    CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'walmart_analytics'
AND REFERENCED_TABLE_NAME IS NOT NULL;