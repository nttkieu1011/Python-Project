--check product_id có thay đổi theo đơn hàng k(1 row - 1product trong oder)
	select 	
		order_id,
		count(*) as line_cnt,
		count(distinct product_id) as product_cnt
	from silver."Sale Transaction"
	group by order_id 
	having count(*)>1
	order by line_cnt desc;
--check product_id có bị lặp trong category k (không)
	select 
		product_id,
		count(distinct product_category) as cate_cnt
	from silver."Sale Transaction"
	group by product_id 
	having count(distinct product_category )>1;
--create dim_product
	create table gold.dim_product as 
		select distinct
			product_id,
			product_category
		from silver."Sale Transaction";
--update key
	alter table gold.dim_product 
		add primary key(product_id);
--view all
	select * from gold.dim_product;
