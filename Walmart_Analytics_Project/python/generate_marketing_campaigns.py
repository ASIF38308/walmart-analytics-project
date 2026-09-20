import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta

fake = Faker("en_IN")
random.seed(42)

# ==========================================
# Helper Functions
# ==========================================

def generate_budget():
    """Generate campaign budget."""
    return random.randint(100000, 2000000)


def generate_spend(budget):
    """Spend is always between 70% and 100% of budget."""
    return round(random.uniform(budget * 0.70, budget), 2)


def generate_impressions(spend):
    """
    Assume CPM between ₹120 and ₹300.
    """
    cpm = random.uniform(120, 300)
    return int((spend / cpm) * 1000)


def generate_clicks(impressions):
    """
    CTR between 1.5% and 5%
    """
    ctr = random.uniform(0.015, 0.05)
    return int(impressions * ctr)


def generate_conversions(clicks):
    """
    Conversion Rate between 2% and 7%
    """
    conversion_rate = random.uniform(0.02, 0.07)
    return int(clicks * conversion_rate)


def generate_revenue(spend):
    """
    Revenue generated using realistic ROAS.
    """
    roas = round(random.uniform(1.5, 7.0), 2)
    revenue = round(spend * roas, 2)
    return revenue


# ==========================================
# Read Marketing Channels
# ==========================================

channels = pd.read_csv("../data/generated/marketing_channels.csv")

# ==========================================
# Master Lists
# ==========================================

campaign_types = [
    "Brand Awareness",
    "Customer Acquisition",
    "Retargeting",
    "Seasonal Sale",
    "Festival Sale",
    "Product Launch",
    "Flash Sale",
    "Email Promotion",
    "App Install",
    "Loyalty Campaign"
]

campaign_prefixes = [
    "Summer",
    "Winter",
    "Monsoon",
    "Mega",
    "Super",
    "Weekend",
    "Republic Day",
    "Diwali",
    "Christmas",
    "New Year",
    "Fashion",
    "Electronics",
    "Home",
    "Grocery",
    "Kids",
    "Back to School",
    "Big Savings",
    "Premium",
    "Smart Shopping",
    "End of Season"
]

campaign_suffixes = [
    "Sale",
    "Festival",
    "Carnival",
    "Offers",
    "Bonanza",
    "Campaign",
    "Launch",
    "Drive",
    "Promotion",
    "Week"
]

# ==========================================
# Generate Campaign Data
# ==========================================

campaigns = []

base_date = datetime(2024, 1, 1)

for campaign_id in range(1, 501):

    channel = channels.sample(1).iloc[0]
    channel_name = channel["channel_name"]

    start_date = base_date + timedelta(days=random.randint(0, 700))
    duration = random.randint(15, 90)
    end_date = start_date + timedelta(days=duration)

    today = datetime.today()

    if today > end_date:
        status = "Completed"
    elif start_date <= today <= end_date:
        status = "Active"
    else:
        status = "Scheduled"

    # 5% campaigns paused
    if random.random() < 0.05:
        status = "Paused"

    # Unique campaign name
    campaign_name = (
        f"{random.choice(campaign_prefixes)} "
        f"{random.choice(campaign_suffixes)} "
        f"{start_date.year} - "
        f"{channel_name} - "
        f"{campaign_id:03d}"
    )

    # Financial Metrics
    budget = generate_budget()
    spend = generate_spend(budget)

    impressions = generate_impressions(spend)
    clicks = generate_clicks(impressions)
    conversions = generate_conversions(clicks)

    revenue = generate_revenue(spend)

    roas = round(revenue / spend, 2)

    campaigns.append({

        "campaign_id": campaign_id,
        "campaign_name": campaign_name,
        "channel_id": int(channel["channel_id"]),
        "campaign_type": random.choice(campaign_types),

        "start_date": start_date.date(),
        "end_date": end_date.date(),

        "budget": budget,
        "spend": spend,

        "impressions": impressions,
        "clicks": clicks,
        "conversions": conversions,

        "revenue_generated": revenue,
        "roas": roas,

        "campaign_status": status

    })

# ==========================================
# Create DataFrame
# ==========================================

df = pd.DataFrame(campaigns)

# ==========================================
# Save CSV
# ==========================================

output_path = "../data/generated/marketing_campaigns.csv"

df.to_csv(output_path, index=False)

print("======================================")
print("Marketing Campaigns Generated")
print("======================================")
print(df.head())

print("\nTotal Campaigns :", len(df))
print("Average ROAS :", round(df["roas"].mean(), 2))
print("Average Budget : ₹", round(df["budget"].mean(), 2))
print("Average Spend : ₹", round(df["spend"].mean(), 2))
print("======================================")