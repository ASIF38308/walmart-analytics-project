CREATE DATABASE IF NOT EXISTS walmart_analytics;

USE walmart_analytics;

-- ===========================
-- CUSTOMERS
-- ===========================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(20),
    email VARCHAR(100)
);

-- ===========================
-- CATEGORIES
-- ===========================
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- ===========================
-- BRANDS
-- ===========================
CREATE TABLE brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(100)
);

-- ===========================
-- SUPPLIERS
-- ===========================
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100)
);

-- ===========================
-- PRODUCTS
-- ===========================
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
    rating DECIMAL(3,1),
    review_count INT,
    status VARCHAR(30)
);

-- ===========================
-- STORES
-- ===========================
CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(150),
    city VARCHAR(100),
    state VARCHAR(100),
    region VARCHAR(50),
    opening_date DATE,
    store_size_sqft INT,
    manager_name VARCHAR(100),
    phone VARCHAR(30),
    email VARCHAR(100),
    status VARCHAR(30)
);

-- ===========================
-- WAREHOUSES
-- ===========================
CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY,
    warehouse_name VARCHAR(150),
    city VARCHAR(100),
    state VARCHAR(100),
    region VARCHAR(50),
    capacity INT,
    manager_name VARCHAR(100),
    phone VARCHAR(30)
);

-- ===========================
-- INVENTORY
-- ===========================
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

-- ===========================
-- ORDERS
-- ===========================
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

-- ===========================
-- ORDER ITEMS
-- ===========================
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(10,2),
    total_price DECIMAL(10,2)
);

-- ===========================
-- PAYMENTS
-- ===========================
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    transaction_id VARCHAR(100),
    payment_date DATE,
    amount DECIMAL(10,2)
);

-- ===========================
-- SHIPMENTS
-- ===========================
CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY,
    order_id INT,
    courier VARCHAR(100),
    shipment_date DATE,
    delivery_date DATE,
    shipping_status VARCHAR(50)
);

-- ===========================
-- RETURNS
-- ===========================
CREATE TABLE returns (
    return_id INT PRIMARY KEY,
    order_id INT,
    return_reason VARCHAR(100),
    refund_amount DECIMAL(10,2),
    return_status VARCHAR(50)
);