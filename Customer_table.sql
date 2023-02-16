select customer_name,
  case
    when sum(case when status = 'DELIVERED' then 1 else 0 end) = count(*) then 'COMPLETED'
    when sum(case when status = 'DELIVERED' then 1 else 0 end) > 0 and sum(case when status in ('CREATED', 'SUBMITTED') then 1 else 0 end) > 0 then 'IN PROGRESS'
    when SUM(case when status = 'SUBMITTED' then 1 else 0 end) > 0 and sum(case when status <> 'DELIVERED' then 1 else 0 end) = count(*) then 'AWAITING PROGRESS'
    else 'AWAITING SUBMISSION'
  end as final_status
from customer_order
group by customer_name;