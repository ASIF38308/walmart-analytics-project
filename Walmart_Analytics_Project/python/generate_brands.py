import pandas as pd
from config import BRANDS
df=pd.DataFrame({'brand_id':range(1,len(BRANDS)+1),'brand_name':BRANDS})
df.to_csv('brands.csv',index=False)
print(df)
