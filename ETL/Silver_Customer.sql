--create table
create table silver.Customer as 

--view table
select *
from bronze."Customer";

--kiểm tra duplicate
select 
	customer_id,
	count(*) as cnt
from bronze."Customer"
group by customer_id
having count(*) >1;

--khử duplicate
WITH cte AS (
SELECT
	*,
	row_number() over(PARTITION BY customer_id ORDER BY ingestion_at DESC) AS row_number
from bronze."Customer" c 
)
SELECT *
FROM cte
WHERE ROW_NUMBER = 1;

--check null; k có
select *
from bronze."Customer" 
where customer_id is null;

-- check category; 6 cate: nhà hàng, online seller, tạp hoá, cửa hàng tiện lợi, siêu thị,canteen
select distinct customer_type
from bronze."Customer";

--check channel: modern trade, e-commerce, traditional trade
select distinct channel
from bronze."Customer";

--data type: phone, tax_code, join_date

--update data type ở silver.customer
alter table silver.Customer
	alter column phone type text,
	alter column tax_code type text,
	alter column join_date type date
		using to_date(join_date, 'MM/DD/YYYY'),
alter table silver.Customer
	drop column index,
	drop column row_number,
	drop column ingestion_at;



