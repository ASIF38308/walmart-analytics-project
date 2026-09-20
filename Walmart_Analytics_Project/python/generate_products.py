import pandas as pd,random,string
from product_name_generator import make_product
from config_products import COLORS,SIZES,GST
rows=[]
for i in range(1,5001):
 dept,brand,name=make_product(); cost=random.randint(100,50000); sell=round(cost*random.uniform(1.1,1.4),2); mrp=round(sell*1.05,2); rows.append([i,'SKU'+str(i).zfill(6),''.join(random.choices(string.digits,k=12)),name,dept,brand,cost,sell,mrp,GST[dept],random.choice(COLORS),random.choice(SIZES),random.randint(0,24),round(random.uniform(3.5,5.0),1),random.randint(0,5000),random.choice(['Active','Discontinued'])])
cols=['product_id','sku','barcode','product_name','department','brand','cost_price','selling_price','mrp','gst_percent','color','size','warranty_months','rating','review_count','status']
pd.DataFrame(rows,columns=cols).to_csv('products.csv',index=False)
print('Generated products.csv')
