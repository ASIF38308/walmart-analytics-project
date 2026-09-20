from faker import Faker
import pandas as pd,random
fake=Faker('en_IN')
cities=[('Bengaluru','Karnataka','South'),('Mumbai','Maharashtra','West'),('Delhi','Delhi','North'),('Hyderabad','Telangana','South')]
rows=[]
for i in range(1,21):
 c,s,r=random.choice(cities); rows.append([i,f'{r} DC-{i:02}',c,s,r,random.randint(100000,1000000),fake.name(),fake.phone_number()])
cols=['warehouse_id','warehouse_name','city','state','region','capacity','manager_name','phone']
pd.DataFrame(rows,columns=cols).to_csv('warehouses.csv',index=False)
print('warehouses.csv created')
