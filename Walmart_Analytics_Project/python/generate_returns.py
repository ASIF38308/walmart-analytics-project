import pandas as pd
import random

orders = pd.read_csv("../data/generated/orders.csv")

returns=[]

reasons=[
"Damaged",
"Wrong Product",
"Customer Changed Mind",
"Late Delivery",
"Quality Issue"
]

return_orders=orders.sample(frac=0.15)

return_id=1

for _,order in return_orders.iterrows():

    returns.append({

        "return_id":return_id,

        "order_id":order["order_id"],

        "return_reason":random.choice(reasons),

        "refund_amount":round(order["total_amount"],2),

        "return_status":"Refunded"

    })

    return_id+=1

returns_df=pd.DataFrame(returns)

returns_df.to_csv("../data/generated/returns.csv",index=False)

print("Returns Generated:",len(returns_df))