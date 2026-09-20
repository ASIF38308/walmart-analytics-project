import pandas as pd
import os

channels = [
    "Google Ads",
    "Facebook Ads",
    "Instagram",
    "YouTube",
    "Email",
    "Organic Search",
    "Referral",
    "Affiliate",
    "LinkedIn",
    "Direct"
]

df = pd.DataFrame({
    "channel_id": range(1, len(channels) + 1),
    "channel_name": channels
})

output_folder = "../data/generated"
os.makedirs(output_folder, exist_ok=True)

output_file = os.path.join(output_folder, "marketing_channels.csv")

df.to_csv(output_file, index=False)

print("✅ marketing_channels.csv created")
print(output_file)

