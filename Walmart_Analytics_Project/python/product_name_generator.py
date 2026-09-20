import random
from config_products import PRODUCTS,BRANDS_BY_DEPT

def make_product():
 dept=random.choice(list(PRODUCTS.keys())); item=random.choice(PRODUCTS[dept]); brand=random.choice(BRANDS_BY_DEPT[dept]); return dept,brand,f'{brand} {item}'
