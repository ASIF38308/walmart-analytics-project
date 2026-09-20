import pandas as pd
import random

# ============================================================
# Purpose: builds the order-to-campaign link needed for
# Last-Touch Attribution (KPI-002), which the BRD marks as
# in-scope for Phase 1 (only multi-touch is excluded, per
# BRD section 8.2). No such link existed before - this was
# the reason KPI-002/004/008 were blocked in kpi_views.sql.
#
# Logic:
# - An order can only be attributed to a campaign that was
#   active on its order_date (start_date <= order_date <=
#   end_date). Per BRD 8.4, campaign data only covers Jan
#   2024 onward, so 2023 orders will correctly show zero
#   attribution (organic) - this is expected, not a bug.
# - Not every order with an active campaign gets attributed -
#   real traffic is a mix of campaign-driven and organic/
#   direct. ATTRIBUTION_RATE controls this split.
# - When multiple campaigns are active on the same date, the
#   campaign is chosen with probability weighted by its
#   spend - a higher-spend campaign is more likely to be the
#   one that drove the "last touch", which is a reasonable
#   real-world assumption.
# ============================================================

ATTRIBUTION_RATE = 0.40  # 40% of eligible orders get attributed

orders = pd.read_csv("../data/generated/orders.csv")
campaigns = pd.read_csv("../data/generated/marketing_campaigns.csv")

orders["order_date"] = pd.to_datetime(orders["order_date"])
campaigns["start_date"] = pd.to_datetime(campaigns["start_date"])
campaigns["end_date"] = pd.to_datetime(campaigns["end_date"])

attributions = []
attribution_id = 1

for _, order in orders.iterrows():
    active = campaigns[
        (campaigns["start_date"] <= order["order_date"]) &
        (campaigns["end_date"] >= order["order_date"])
    ]

    if active.empty:
        continue  # no campaign running on this date - organic

    if random.random() > ATTRIBUTION_RATE:
        continue  # this order wasn't campaign-driven - organic

    weights = active["spend"].tolist()
    chosen = active.sample(n=1, weights=weights).iloc[0]

    attributions.append({
        "attribution_id": attribution_id,
        "order_id": order["order_id"],
        "campaign_id": chosen["campaign_id"],
        "attribution_method": "Last-Touch"
    })
    attribution_id += 1

attribution_df = pd.DataFrame(attributions)
attribution_df.to_csv("../data/generated/order_campaign_attribution.csv", index=False)

print("=" * 40)
print("Order-Campaign Attribution Generated")
print("Total attributed orders:", len(attribution_df))
print("Total orders:", len(orders))
print("Attribution coverage: {:.1f}%".format(len(attribution_df) / len(orders) * 100))
print("=" * 40)
