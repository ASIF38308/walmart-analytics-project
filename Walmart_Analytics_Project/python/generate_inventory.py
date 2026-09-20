import pandas as pd
import random
from datetime import datetime

# ==========================
# LOAD DATA
# ==========================

products = pd.read_csv("../data/generated/products.csv")
stores = pd.read_csv("../data/generated/stores.csv")
warehouses = pd.read_csv("../data/generated/warehouses.csv")

inventory = []

inventory_id = 1

# ==========================
# GENERATE INVENTORY
# ==========================

for _, product in products.iterrows():

    # Every product will be available in 8-20 stores
    selected_stores = stores.sample(random.randint(8, 20))

    for _, store in selected_stores.iterrows():

        warehouse = warehouses.sample(1).iloc[0]

        stock = random.randint(20, 500)

        reorder_level = int(stock * 0.30)

        max_stock = stock + random.randint(100, 500)

        reserved = random.randint(0, int(stock * 0.20))

        available = stock - reserved

        if available <= reorder_level:
            status = "Reorder Required"
        else:
            status = "In Stock"

        inventory.append({

            "inventory_id": inventory_id,

            "product_id": product["product_id"],

            "store_id": store["store_id"],

            "warehouse_id": warehouse["warehouse_id"],

            "stock_quantity": stock,

            "reserved_quantity": reserved,

            "available_quantity": available,

            "reorder_level": reorder_level,

            "max_stock": max_stock,

            "last_stock_update": datetime.today().strftime("%Y-%m-%d"),

            "inventory_status": status

        })

        inventory_id += 1

# ==========================
# SAVE CSV
# ==========================

inventory_df = pd.DataFrame(inventory)

inventory_df.to_csv("../data/generated/inventory.csv", index=False)

print("===================================")
print("Inventory Generated Successfully")
print("Total Records :", len(inventory_df))
print("===================================")