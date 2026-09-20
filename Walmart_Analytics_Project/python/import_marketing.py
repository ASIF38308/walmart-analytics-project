import mysql.connector
import pandas as pd
import os

# -----------------------------
# MySQL Connection
# -----------------------------
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="MyNewSecurePassword123!",
    database="walmart_analytics"
)

cursor = conn.cursor()

# -----------------------------
# CSV Location
# -----------------------------
csv_path = os.path.join(
    os.path.dirname(__file__),
    "../data/generated/marketing_channels.csv"
)

print("CSV Path:", csv_path)

# -----------------------------
# Read CSV
# -----------------------------
df = pd.read_csv(csv_path)

# -----------------------------
# Clear Existing Data
# -----------------------------
cursor.execute("DELETE FROM marketing_channels")

# -----------------------------
# Insert Data
# -----------------------------
sql = """
INSERT INTO marketing_channels
(channel_id, channel_name)
VALUES (%s, %s)
"""

data = list(df.itertuples(index=False, name=None))

cursor.executemany(sql, data)

conn.commit()
cursor.execute("SELECT COUNT(*) FROM marketing_channels")
print("Rows in table after commit:", cursor.fetchone()[0])

print(f"✅ Imported {cursor.rowcount} rows into marketing_channels")

cursor.close()
conn.close()

