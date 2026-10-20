create table silver.employee as
with cte as (
    select
        *,
        row_number() over (
            partition by employee_id
            order by ingestion_at desc
        ) as rn
    from bronze."Employee"
)
select
    employee_id,
    full_name,
    date_of_birth::date as date_of_birth,
    join_date::date as join_date,
    phone::text as phone,
    email,
    department,
    position,
    effective_date::date as effective_date
from cte
where rn = 1;
