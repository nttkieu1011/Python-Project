create view gold.fact_sales as 	
	select
		order_id,
		order_date,
		customer_id,
		employee_id,
		product_id,
		region,
		province,
		channel,
		quantity,
		unit_price,
		discount_pct,
		discount_amount,
		gross_amount,
		net_amount,
		delivery_status,
		payment_method,
		payment_status
from silver. "Sale Transaction";
