-- =====================================================
-- MARKETING CAMPAIGNS
-- =====================================================

DROP TABLE IF EXISTS marketing_campaigns;

CREATE TABLE marketing_campaigns
(
    campaign_id INT PRIMARY KEY AUTO_INCREMENT,

    campaign_name VARCHAR(100) NOT NULL,

    channel_id INT NOT NULL,

    campaign_type VARCHAR(50),

    start_date DATE,

    end_date DATE,

    budget DECIMAL(12,2),

    spend DECIMAL(12,2),

    impressions INT,

    clicks INT,

    conversions INT,

    revenue_generated DECIMAL(12,2),

    campaign_status VARCHAR(30),

    FOREIGN KEY(channel_id)
    REFERENCES marketing_channels(channel_id)
);