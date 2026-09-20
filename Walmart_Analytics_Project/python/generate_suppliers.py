from faker import Faker
import pandas as pd, random
fake=Faker('en_IN')
rows=[]
for i in range(1,101):
    rows.append([i,fake.company(),fake.city(),fake.state(),fake.name(),fake.email(),fake.phone_number(),random.randint(3,5),random.randint(2,15)])
df=pd.DataFrame(rows,columns=['supplier_id','supplier_name','city','state','contact_person','email','phone','rating','lead_time_days'])
df.to_csv('suppliers.csv',index=False)
print(df.head())
