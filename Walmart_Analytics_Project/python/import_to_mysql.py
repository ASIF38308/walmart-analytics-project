import os
import pandas as pd
import mysql.connector
from db_config import HOST, USER, PASSWORD, DATABASE

# ==========================================
# CONNECT TO MYSQL
# ==========================================

conn = mysql.connector.connect(
    host=HOST,
    user=USER,
    password=PASSWORD,
    database=DATABASE
)

cursor = conn.cursor()

print("=" * 60)
print("WALMART ETL IMPORT")
print("=" * 60)

# ==========================================
# FIND PROJECT PATH
# ==========================================

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_FOLDER = os.path.join(BASE_DIR, "..", "data", "generated")

print(f"CSV Folder: {DATA_FOLDER}")

# ==========================================
# TABLE IMPORT ORDER
# (Parent tables first)
# ==========================================

TABLES = [

    "customers",
    "categories",
    "brands",
    "suppliers",
    "products",

    "stores",
    "warehouses",

    "marketing_channels",
    "marketing_campaigns",

    "inventory",

    "orders",
    "order_items",

    "payments",
    "shipments",
    "returns"

]

# ==========================================
# DISABLE FOREIGN KEY CHECKS
# ==========================================

cursor.execute("SET FOREIGN_KEY_CHECKS = 0;")
conn.commit()

# ==========================================
# IMPORT LOOP
# ==========================================

for table in TABLES:

    csv_file = os.path.join(DATA_FOLDER, f"{table}.csv")

    if not os.path.exists(csv_file):
        print(f"⚠️  {table}.csv not found. Skipping.")
        continue

    print(f"\n📥 Importing {table}...")

    try:

        df = pd.read_csv(csv_file)

        columns = ",".join(df.columns)

        placeholders = ",".join(["%s"] * len(df.columns))

        sql = f"""
        INSERT INTO {table}
        ({columns})
        VALUES ({placeholders})
        """

        rows = [tuple(row) for row in df.itertuples(index=False, name=None)]

        cursor.execute(f"DELETE FROM {table}")

        cursor.executemany(sql, rows)

        conn.commit()

        print(f"✅ {table}: {len(rows)} rows imported")

    except Exception as e:

        conn.rollback()

        print(f"❌ Error importing {table}")

        print(e)

# ==========================================
# ENABLE FOREIGN KEY CHECKS
# ==========================================

cursor.execute("SET FOREIGN_KEY_CHECKS = 1;")
conn.commit()

cursor.close()
conn.close()

print("\n🎉 ETL COMPLETED SUCCESSFULLY")
print("=" * 60)
print("Current Working Directory:", os.getcwd())
print("Script Location:", BASE_DIR)
print("Data Folder:", DATA_FOLDER)
print("=" * 60)