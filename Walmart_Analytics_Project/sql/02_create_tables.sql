/*
=========================================================
Project : Walmart Retail Analytics
File    : 02_create_tables.sql
Author  : Mohd Asif
Purpose : Create All Tables
=========================================================
*/

USE walmart_analytics;

-- =====================================================
-- CUSTOMERS
-- =====================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(20),
    date_of_birth DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    city VARCHAR(100),
    state VARCHAR(100),
    region VARCHAR(50),
    postal_code VARCHAR(20),
    join_date DATE,
    membership_tier VARCHAR(30),
    acquisition_channel VARCHAR(50),
    preferred_channel VARCHAR(50),
    customer_status VARCHAR(30),
    loyalty_points INT,
    annual_income DECIMAL(12,2),
    household_size INT
);

-- =====================================================
-- CATEGORIES
-- =====================================================

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    department VARCHAR(100),
    category VARCHAR(100),
    subcategory VARCHAR(100)
);

-- =====================================================
-- BRANDS
-- =====================================================

CREATE TABLE brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(100)
);

-- =====================================================
-- SUPPLIERS
-- =====================================================

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    rating DECIMAL(3,2),
    lead_time_days INT
);

-- =====================================================
-- PRODUCTS
-- =====================================================

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    sku VARCHAR(50),
    barcode VARCHAR(50),
    product_name VARCHAR(200),
    department VARCHAR(100),
    brand VARCHAR(100),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    mrp DECIMAL(10,2),
    gst_percent DECIMAL(5,2),
    color VARCHAR(50),
    size VARCHAR(20),
    warranty_months INT,
    rating DECIMAL(3,2),
    review_count INT,
    status VARCHAR(30)
);

-- =====================================================
-- STORES
-- =====================================================

CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(150),
    city VARCHAR(100),
    state VARCHAR(100),
    region VARCHAR(50),
    opening_date DATE,
    store_size_sqft INT,
    manager_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    status VARCHAR(30)
);

-- =====================================================
-- WAREHOUSES
-- =====================================================

CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY,
    warehouse_name VARCHAR(150),
    city VARCHAR(100),
    state VARCHAR(100),
    region VARCHAR(50),
    capacity INT,
    manager_name VARCHAR(100),
    phone VARCHAR(20)
);

-- =====================================================
-- INVENTORY
-- =====================================================

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    store_id INT,
    warehouse_id INT,
    stock_quantity INT,
    reserved_quantity INT,
    available_quantity INT,
    reorder_level INT,
    max_stock INT,
    last_stock_update DATE,
    inventory_status VARCHAR(50)
);

-- =====================================================
-- ORDERS
-- =====================================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    store_id INT,
    order_date DATE,
    payment_method VARCHAR(50),
    order_status VARCHAR(50),
    subtotal DECIMAL(10,2),
    discount DECIMAL(10,2),
    tax DECIMAL(10,2),
    shipping_charge DECIMAL(10,2),
    total_amount DECIMAL(10,2)
);

-- =====================================================
-- ORDER ITEMS
-- =====================================================

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(10,2),
    total_price DECIMAL(10,2)
);

-- =====================================================
-- PAYMENTS
-- =====================================================

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    transaction_id VARCHAR(100),
    payment_date DATE,
    amount DECIMAL(10,2)
);

-- =====================================================
-- SHIPMENTS
-- =====================================================

CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY,
    order_id INT,
    courier VARCHAR(100),
    shipment_date DATE,
    delivery_date DATE,
    shipping_status VARCHAR(50)
);

-- =====================================================
-- RETURNS
-- =====================================================

CREATE TABLE returns (
    return_id INT PRIMARY KEY,
    order_id INT,
    return_reason VARCHAR(100),
    refund_amount DECIMAL(10,2),
    return_status VARCHAR(50)
);

USE walmart_analytics;

SELECT COUNT(*) AS customers FROM customers;
SELECT COUNT(*) AS products FROM products;
SELECT COUNT(*) AS orders FROM orders;
SELECT COUNT(*) AS inventory FROM inventory;
SELECT COUNT(*) AS order_items FROM order_items;