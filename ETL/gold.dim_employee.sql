-- check duplicate
	select 
		employee_id,
		count(*) as total_rows
	from silver.employee
	group by employee_id 
	having count(*)>1;
--create gold.dim_employee
	create table gold.dim_employee as
		select * 
		from silver.employee;
--update primary key
	alter table gold.dim_employee 
		add primary key (employee_id);
-- view all
	select * from gold.dim_employee;