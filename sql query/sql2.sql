--name,ac_no, o_id of customers with total due payment > 200000000
set search_path to production;
select name, ac_no, o_id, total_amount
from
(select o_id, ac_no,total_amount
from
(select o_id, total_transportation_charge + cost_of_order as total_amount
from
(select o_id, sum(cost_of_item) as cost_of_order
from
(select o_id,(product_cost + additional_charge) as cost_of_item
from
(select qty* rate as product_cost 
from item) as A natural join item) as B
group by o_id) as C 
natural join
(select o_id, sum(transportation_charge) as total_transportation_charge
from transportation
group by o_id) as D) as E natural join order_detail) as F natural join customer_detail
where total_amount> 200000000
