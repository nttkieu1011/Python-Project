
	create view gold.dim_product as 
	select distinct
		product_id,
		product_category
	from silver."Sale Transaction";

