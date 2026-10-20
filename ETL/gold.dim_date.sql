--create gold.dim_date
	create table gold.dim_date (
		full_date date primary key,
		day integer not null,
		month integer not null,
		month_name varchar(20) not null,
	    quarter integer not null,
	    year integer not null,
	    day_of_week integer not null,
	    day_name varchar(20) not null
	);
--điền ngày vào cột date
	with d as(
	select  generate_series(
	    date ('2024-01-01'),
	    date ('2024-12-31'),
	    interval '1 day'
	)::date as full_date)

	insert into gold.dim_date (
	    full_date,
	    day,
	    month,
	    month_name,
	    quarter,
	    year,
	    day_of_week,
	    day_name
	)
	select
	    full_date,
	    extract(day from full_date)::integer as day,
	    extract (month from full_date)::integer as month,
	    to_char (full_date, 'FMMonth') as month_name,
	    extract (quarter from full_date)::integer as quarter,
	    extract (year from full_date)::integer as year,
	    extract (isodow from full_date)::integer as day_of_week,
	    to_char (full_date, 'FMDay') as day_name
	from d;


