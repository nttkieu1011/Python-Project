--create table
	create table silver."Sale Transaction" as
--view table
	select *
	from bronze."Sales Transaction";
--update
	alter table silver."Sale Transaction"
    alter column order_date type date
        using to_date(order_date, 'MM/DD/YYYY'),
    alter column order_year type integer
        using order_year::integer,
    drop column index,
    drop column ingestion_at;

	select *
	from silver."Sale Transaction";
	
		