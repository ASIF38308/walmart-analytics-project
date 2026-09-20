import pandas as pd
import random

# Load data
orders = pd.read_csv("../data/generated/orders.csv")
products = pd.read_csv("../data/generated/products.csv")

order_items = []
order_item_id = 1

# FIX: previously unit_price * quantity had no relationship to
# orders.total_amount, causing order_items to sum to ~18x the
# real order revenue. Now each order's line items are scaled to
# sum exactly to that order's total_amount, while quantity and
# unit_price still reflect real product prices (kept for realism).

for _, order in orders.iterrows():

    num_products = random.randint(1, 5)
    selected_products = products.sample(num_products)

    raw_lines = []
    for _, product in selected_products.iterrows():
        quantity = random.randint(1, 4)
        unit_price = product["selling_price"]
        raw_value = quantity * unit_price
        raw_lines.append({
            "product_id": product["product_id"],
            "quantity": quantity,
            "unit_price": unit_price,
            "raw_value": raw_value
        })

    raw_total = sum(line["raw_value"] for line in raw_lines)
    order_total = order["total_amount"]

    running_sum = 0
    for i, line in enumerate(raw_lines):
        weight = line["raw_value"] / raw_total

        if i < len(raw_lines) - 1:
            total_price = round(order_total * weight, 2)
            running_sum += total_price
        else:
            # Last line absorbs rounding remainder so the sum
            # matches order_total exactly, not just approximately.
            total_price = round(order_total - running_sum, 2)

        discount = round(line["raw_value"] - total_price, 2)

        order_items.append({
            "order_item_id": order_item_id,
            "order_id": order["order_id"],
            "product_id": line["product_id"],
            "quantity": line["quantity"],
            "unit_price": line["unit_price"],
            "discount": discount,
            "total_price": total_price
        })

        order_item_id += 1

order_items_df = pd.DataFrame(order_items)
order_items_df.to_csv("../data/generated/order_items.csv", index=False)

print("=" * 40)
print("Order Items Generated Successfully")
print("Total Records :", len(order_items_df))
print("=" * 40)
