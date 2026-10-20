create table silver.customer as
with cte as (
    select
        *,
        row_number() over (
            partition by customer_id
            order by ingestion_at desc
        ) as rn
    from bronze."Customer"
)
select
    customer_id,
    customer_name,
    customer_type,
    channel,
    province,
    region,
    address,
    phone::text as phone,
    tax_code::text as tax_code,
    TO_DATE(join_date, 'MM/DD/YYYY') as join_date,
    credit_limit,
    status
from cte
where rn = 1;


