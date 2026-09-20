import os
import pandas as pd

DATA_FOLDER = "../data/generated"

for file in sorted(os.listdir(DATA_FOLDER)):
    if file.endswith(".csv"):
        path = os.path.join(DATA_FOLDER, file)

        df = pd.read_csv(path)

        print("=" * 80)
        print(file)
        print("-" * 80)

        for col in df.columns:
            print(col)

        print("\nTotal Columns:", len(df.columns))
        print()