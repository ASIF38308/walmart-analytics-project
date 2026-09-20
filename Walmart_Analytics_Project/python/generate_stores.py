from faker import Faker
import pandas as pd,random
fake=Faker('en_IN')
cities=[('Bengaluru','Karnataka','South'),('Mumbai','Maharashtra','West'),('Delhi','Delhi','North'),('Hyderabad','Telangana','South'),('Chennai','Tamil Nadu','South'),('Kolkata','West Bengal','East')]
rows=[]
for i in range(1,101):
 c,s,r=random.choice(cities); rows.append([i,f'Walmart {c} Store {i:03}',c,s,r,fake.date_between(start_date='-15y',end_date='today'),random.randint(20000,100000),fake.name(),fake.phone_number(),f'store{i}@walmartdemo.com','Active'])
cols=['store_id','store_name','city','state','region','opening_date','store_size_sqft','manager_name','phone','email','status']
pd.DataFrame(rows,columns=cols).to_csv('stores.csv',index=False)
print('stores.csv created')
