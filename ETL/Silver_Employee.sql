--create table
	create table silver.Employee as
--khử duplicate
	WITH cte AS (
	SELECT
		*,
		row_number() over(PARTITION BY employee_id ORDER BY ingestion_at DESC) AS row_number
	from bronze."Employee"
	)
	SELECT *
	FROM cte
	WHERE ROW_NUMBER = 1;
--view table
	select *
	from bronze."Employee";

--update table
	alter table silver.Employee 
		alter column date_of_birth type date 
			using date_of_birth::DATE,
		alter column join_date type date
			using join_date::DATE,
		alter column phone type text,
		alter column effective_date type date
			using effective_date::DATE,
		drop column index,
		drop column ingestion_at,
		drop column row_number;
