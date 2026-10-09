import pandas as pd
from sqlalchemy import create_engine
engine =create_engine( 'postgresql+psycopg2://postgres:101110@localhost:5432/postgres')

data = pd.read_csv(r'C:\Users\Admin\Documents\slide unigap\python1\DAC_K49\Sales Transaction.csv')
data['ingestion_at'] =pd.Timestamp.now()
print(data.head())

print('Connecting to PostgreSQL database successfully')

data.to_sql(
    name = 'Sales Transaction',
    con = engine,
    schema = 'bronze',
    if_exists = 'append'
)
