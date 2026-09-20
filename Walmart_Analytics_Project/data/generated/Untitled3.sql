USE walmart_analytics;

CREATE TABLE marketing_campaigns (

    campaign_id INT PRIMARY KEY,

    campaign_name VARCHAR(150) NOT NULL,

    channel_id INT NOT NULL,

    campaign_type VARCHAR(50) NOT NULL,

    start_date DATE NOT NULL,

    end_date DATE NOT NULL,

    budget DECIMAL(12,2) NOT NULL,

    spend DECIMAL(12,2) NOT NULL,

    impressions INT NOT NULL,

    clicks INT NOT NULL,

    conversions INT NOT NULL,

    revenue_generated DECIMAL(12,2) NOT NULL,

    roas DECIMAL(5,2) NOT NULL,

    campaign_status VARCHAR(20) NOT NULL,

    CONSTRAINT fk_marketing_channel
        FOREIGN KEY (channel_id)
        REFERENCES marketing_channels(channel_id)

);

SELECT COUNT(*) AS total_campaigns
FROM marketing_campaigns;