import pandas as pd
import random
from faker import Faker
from datetime import timedelta

fake = Faker("en_IN")

orders = pd.read_csv("../data/generated/orders.csv")

shipments = []

couriers = [
    "BlueDart",
    "Delhivery",
    "Ecom Express",
    "XpressBees",
    "India Post"
]

for _, order in orders.iterrows():

    delivery_days = random.randint(1,7)

    shipment_date = pd.to_datetime(order["order_date"])

    delivery_date = shipment_date + timedelta(days=delivery_days)

    shipments.append({

        "shipment_id": order["order_id"],

        "order_id": order["order_id"],

        "courier": random.choice(couriers),

        "shipment_date": shipment_date,

        "delivery_date": delivery_date,

        "shipping_status": random.choice([
            "Delivered",
            "Delivered",
            "Delivered",
            "In Transit"
        ])

    })

shipment_df = pd.DataFrame(shipments)

shipment_df.to_csv("../data/generated/shipments.csv",index=False)

print("Shipments Generated:",len(shipment_df))