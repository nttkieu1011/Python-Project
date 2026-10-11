--check overview (119101 - 50000 - 1802 - 108 - 92)
	select 
		count(*) as total_rows,
		count(distinct order_id) as total_orders,
		count(distinct customer_id) as total_customers,
		count(distinct employee_id) as total_employees,
		count(distinct product_id) as total_products
	from silver."Sale Transaction";
--tìm pk, xem order_id +product_id có unique k 
	select 	
		order_id,
		product_id,
		count(*) as record_count
	from silver."Sale Transaction"
	group by order_id, product_id 
	having count(*)>1;
--kiểm tra FK
---customer_id
	select count(*) as unmatched_customers
	from silver."Sale Transaction" st 
	left join gold.dim_customer dc 
		on st.customer_id = dc.customer_id 
	where dc.customer_id  is null;
--- employee_id
	select count(*) as unmatched_employees
	from silver."Sale Transaction" st 
	left join gold.dim_employee de  
		on st.employee_id = de.employee_id 
	where de.employee_id   is null;
---product_id
	select count(*) as unmatched_products
	from silver."Sale Transaction" st 
	left join gold.dim_product dp 
		on st.product_id = dp.product_id 
	where dp.product_id  is null;
--create fact_sales
	create table gold.fact_sales as 	
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
--update PK
	alter table gold.fact_sales 
		add primary key (order_id, product_id);
--check 
	--rows
	select count(*) from gold.fact_sales;
	--totals
	select 	
		'silver' as source,
		sum(gross_amount) as total_gross_amount,
		sum(net_amount) as total_net_amout
	from silver. "Sale Transaction"
	union all 
	select 
		'gold' as source,
		sum(gross_amount) as total_gross_amount,
		sum(net_amount) as total_net_amout
	from gold.fact_sales;


			