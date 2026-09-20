import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta

fake = Faker("en_IN")

# Load master data
customers = pd.read_csv("../data/generated/customers.csv")
stores = pd.read_csv("../data/generated/stores.csv")

payment_methods = [
    "UPI",
    "Credit Card",
    "Debit Card",
    "Cash",
    "Net Banking",
    "Wallet"
]

order_status = [
    "Delivered",
    "Delivered",
    "Delivered",
    "Delivered",
    "Shipped",
    "Processing",
    "Cancelled"
]

orders = []

start_date = datetime(2023, 1, 1)
end_date = datetime(2025, 12, 31)

for order_id in range(1, 50001):

    customer = customers.sample(1).iloc[0]
    store = stores.sample(1).iloc[0]

    order_date = fake.date_between(
        start_date=start_date,
        end_date=end_date
    )

    subtotal = round(random.uniform(500, 25000), 2)

    discount = round(subtotal * random.uniform(0, 0.20), 2)

    tax = round((subtotal - discount) * 0.18, 2)

    shipping = random.choice([0, 49, 79, 99])

    total = subtotal - discount + tax + shipping

    orders.append({

        "order_id": order_id,

        "customer_id": customer["customer_id"],

        "store_id": store["store_id"],

        "order_date": order_date,

        "payment_method": random.choice(payment_methods),

        "order_status": random.choice(order_status),

        "subtotal": subtotal,

        "discount": discount,

        "tax": tax,

        "shipping_charge": shipping,

        "total_amount": round(total,2)

    })

orders_df = pd.DataFrame(orders)

orders_df.to_csv("../data/generated/orders.csv", index=False)

print("="*40)
print("Orders Generated Successfully")
print("Total Orders :", len(orders_df))
print("="*40)