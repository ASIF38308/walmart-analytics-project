CREATE TABLE IF NOT EXISTS order_campaign_attribution (
    attribution_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    campaign_id INT NOT NULL,
    attribution_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (campaign_id) REFERENCES marketing_campaigns(campaign_id)
);

LOAD DATA LOCAL INFILE '/Users/apple/Desktop/Analytics_carrer/Portfolio/Walmart_Analytics_Project/data/generated/order_campaign_attribution.csv'
INTO TABLE order_campaign_attribution
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM order_campaign_attribution;