import pandas as pd
import random
from faker import Faker

fake = Faker("en_IN")

orders = pd.read_csv("../data/generated/orders.csv")

payment_statuses = [
    "Success",
    "Success",
    "Success",
    "Success",
    "Pending",
    "Failed"
]

payments = []

for _, order in orders.iterrows():

    payments.append({

        "payment_id": order["order_id"],

        "order_id": order["order_id"],

        "payment_method": order["payment_method"],

        "payment_status": random.choice(payment_statuses),

        "transaction_id": fake.uuid4(),

        "payment_date": order["order_date"],

        "amount": order["total_amount"]

    })

payments_df = pd.DataFrame(payments)

payments_df.to_csv("../data/generated/payments.csv", index=False)

print("="*40)
print("Payments Generated Successfully")
print("Total Payments :", len(payments_df))
print("="*40)