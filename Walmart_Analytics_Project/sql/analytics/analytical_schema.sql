USE walmart_analytics;

-- ============================================
-- ANALYTICAL SCHEMA
-- Dimension Tables
-- ============================================

-- 1. Customer Dimension
CREATE TABLE IF NOT EXISTS dim_customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    first_purchase_date DATE,
    acquisition_channel VARCHAR(100),
    customer_segment VARCHAR(100),
    region_id INT,
    
    UNIQUE KEY uq_dim_customer_customer_id (customer_id)
);


-- 2. Campaign Dimension
CREATE TABLE IF NOT EXISTS dim_campaign (
    campaign_key INT AUTO_INCREMENT PRIMARY KEY,
    campaign_id VARCHAR(100) NOT NULL,
    campaign_name VARCHAR(255),
    campaign_type VARCHAR(100),
    channel_id INT,
    start_date DATE,
    end_date DATE,
    campaign_status VARCHAR(50),

    UNIQUE KEY uq_dim_campaign_campaign_id (campaign_id)
);


-- 3. Product Dimension
CREATE TABLE IF NOT EXISTS dim_product (
    product_key INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255),
    category_id INT,
    brand_id INT,
    price DECIMAL(12,2),

    UNIQUE KEY uq_dim_product_product_id (product_id)
);


-- 4. Date Dimension
CREATE TABLE IF NOT EXISTS dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(20),
    week INT,
    day_of_month INT,
    day_name VARCHAR(20)
);


-- 5. Region Dimension
CREATE TABLE IF NOT EXISTS dim_region (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(100),
    state VARCHAR(100),
    city VARCHAR(100)
);


-- 6. Channel Dimension
CREATE TABLE IF NOT EXISTS dim_channel (
    channel_id INT AUTO_INCREMENT PRIMARY KEY,
    channel_name VARCHAR(100) NOT NULL,

    UNIQUE KEY uq_dim_channel_channel_name (channel_name)
);


-- 7. Platform Dimension
CREATE TABLE IF NOT EXISTS dim_platform (
    platform_id INT AUTO_INCREMENT PRIMARY KEY,
    platform_name VARCHAR(100) NOT NULL,

    UNIQUE KEY uq_dim_platform_platform_name (platform_name)
);

-- ============================================
-- ANALYTICAL SCHEMA
-- Fact Tables
-- ============================================

-- 1. Orders Fact
CREATE TABLE IF NOT EXISTS fact_orders (
    order_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    customer_key INT,
    date_key INT,
    region_id INT,
    order_status VARCHAR(50),
    gross_order_value DECIMAL(14,2),
    recognized_revenue DECIMAL(14,2),
    refund_amount DECIMAL(14,2),
    return_amount DECIMAL(14,2),
    discount_amount DECIMAL(14,2),

    UNIQUE KEY uq_fact_orders_order_id (order_id)
);


-- 2. Order Items Fact
CREATE TABLE IF NOT EXISTS fact_order_items (
    order_item_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_key INT,
    quantity INT,
    unit_price DECIMAL(12,2),
    discount_amount DECIMAL(12,2),
    item_revenue DECIMAL(14,2)
);


-- 3. Marketing Spend Fact
CREATE TABLE IF NOT EXISTS fact_marketing_spend (
    spend_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    campaign_key INT,
    platform_id INT,
    date_key INT,
    impressions BIGINT,
    clicks BIGINT,
    platform_spend DECIMAL(14,2)
);


-- 4. Campaign Performance Fact
CREATE TABLE IF NOT EXISTS fact_campaign_performance (
    performance_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    campaign_key INT,
    date_key INT,
    attributed_orders INT,
    campaign_attributed_sales DECIMAL(14,2),
    attributed_revenue DECIMAL(14,2)
);


-- 5. Finance Cost Fact
CREATE TABLE IF NOT EXISTS fact_finance_cost (
    cost_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    campaign_key INT,
    date_key INT,
    channel_id INT,
    cost_category VARCHAR(100),
    marketing_cost DECIMAL(14,2),
    agency_cost DECIMAL(14,2),
    creative_cost DECIMAL(14,2),
    campaign_expense DECIMAL(14,2)
);


-- 6. Web Sessions Fact
CREATE TABLE IF NOT EXISTS fact_web_sessions (
    session_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    date_key INT,
    visitor_id VARCHAR(255),
    campaign_key INT,
    channel_id INT
);
-- ============================================
-- FOREIGN KEYS & CONSTRAINTS
-- ============================================

-- Orders → Customer
ALTER TABLE fact_orders
ADD CONSTRAINT fk_fact_orders_customer
FOREIGN KEY (customer_key)
REFERENCES dim_customer(customer_key);

-- Orders → Date
ALTER TABLE fact_orders
ADD CONSTRAINT fk_fact_orders_date
FOREIGN KEY (date_key)
REFERENCES dim_date(date_key);

-- Orders → Region
ALTER TABLE fact_orders
ADD CONSTRAINT fk_fact_orders_region
FOREIGN KEY (region_id)
REFERENCES dim_region(region_id);


-- Order Items → Product
ALTER TABLE fact_order_items
ADD CONSTRAINT fk_fact_order_items_product
FOREIGN KEY (product_key)
REFERENCES dim_product(product_key);


-- Marketing Spend → Campaign
ALTER TABLE fact_marketing_spend
ADD CONSTRAINT fk_fact_marketing_spend_campaign
FOREIGN KEY (campaign_key)
REFERENCES dim_campaign(campaign_key);

-- Marketing Spend → Platform
ALTER TABLE fact_marketing_spend
ADD CONSTRAINT fk_fact_marketing_spend_platform
FOREIGN KEY (platform_id)
REFERENCES dim_platform(platform_id);

-- Marketing Spend → Date
ALTER TABLE fact_marketing_spend
ADD CONSTRAINT fk_fact_marketing_spend_date
FOREIGN KEY (date_key)
REFERENCES dim_date(date_key);


-- Campaign Performance → Campaign
ALTER TABLE fact_campaign_performance
ADD CONSTRAINT fk_campaign_performance_campaign
FOREIGN KEY (campaign_key)
REFERENCES dim_campaign(campaign_key);

-- Campaign Performance → Date
ALTER TABLE fact_campaign_performance
ADD CONSTRAINT fk_campaign_performance_date
FOREIGN KEY (date_key)
REFERENCES dim_date(date_key);


-- Finance Cost → Campaign
ALTER TABLE fact_finance_cost
ADD CONSTRAINT fk_finance_cost_campaign
FOREIGN KEY (campaign_key)
REFERENCES dim_campaign(campaign_key);

-- Finance Cost → Date
ALTER TABLE fact_finance_cost
ADD CONSTRAINT fk_finance_cost_date
FOREIGN KEY (date_key)
REFERENCES dim_date(date_key);

-- Finance Cost → Channel
ALTER TABLE fact_finance_cost
ADD CONSTRAINT fk_finance_cost_channel
FOREIGN KEY (channel_id)
REFERENCES dim_channel(channel_id);


-- Web Sessions → Campaign
ALTER TABLE fact_web_sessions
ADD CONSTRAINT fk_web_sessions_campaign
FOREIGN KEY (campaign_key)
REFERENCES dim_campaign(campaign_key);

-- Web Sessions → Channel
ALTER TABLE fact_web_sessions
ADD CONSTRAINT fk_web_sessions_channel
FOREIGN KEY (channel_id)
REFERENCES dim_channel(channel_id);

-- Web Sessions → Date
ALTER TABLE fact_web_sessions
ADD CONSTRAINT fk_web_sessions_date
FOREIGN KEY (date_key)
REFERENCES dim_date(date_key);

-- ============================================
-- POPULATE ANALYTICAL DIMENSIONS
-- Customer Dimension
-- ============================================

INSERT INTO dim_customer (
    customer_id,
    first_purchase_date,
    acquisition_channel,
    customer_segment,
    region_id
)
SELECT
    c.customer_id,

    NULL AS first_purchase_date,

    c.acquisition_channel,

    c.membership_tier AS customer_segment,

    NULL AS region_id

FROM customers c
ON DUPLICATE KEY UPDATE
    acquisition_channel = VALUES(acquisition_channel),
    customer_segment = VALUES(customer_segment);
    
    SELECT COUNT(*) AS customer_count
FROM dim_customer;

SELECT *
FROM dim_customer
LIMIT 10;

SELECT
    (SELECT COUNT(*) FROM customers) AS source_count,
    (SELECT COUNT(*) FROM dim_customer) AS target_count;

-- ============================================
-- Product Dimension
-- ============================================

INSERT INTO dim_product (
    product_id,
    product_name,
    category_id,
    brand_id,
    price
)
SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    p.brand_id,
    p.price
FROM products p
ON DUPLICATE KEY UPDATE
    product_name = VALUES(product_name),
    category_id = VALUES(category_id),
    brand_id = VALUES(brand_id),
    price = VALUES(price);
