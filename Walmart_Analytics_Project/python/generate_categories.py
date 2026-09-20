import pandas as pd
from config import DEPARTMENTS
rows=[];i=1
for d,cats in DEPARTMENTS.items():
    for c,subs in cats.items():
        for s in subs:
            rows.append([i,d,c,s]);i+=1
df=pd.DataFrame(rows,columns=['category_id','department','category','subcategory'])
df.to_csv('categories.csv',index=False)
print(df.head());print('Created',len(df),'categories')
