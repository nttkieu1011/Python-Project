--check duplicate
	select 
		customer_id,
		count(*) as total_rows
	from silver.customer 
	group by customer_id 
	having count(*)>1;
--create gold.dim_customer
	create table gold.dim_customer as
		select *
		from silver.customer;
--update primary key
	alter table gold.dim_customer 
		add primary key (customer_id);
--view all	
	select *
	from gold.dim_customer;