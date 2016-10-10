set search_path to production;
select ac_no, max(count_of_order)
from 
(select ac_no,count(o_id) as count_of_order
from
(select ac_no, o_id from order_detail natural join customer_detail where o_id like '2006%') as A
group by ac_no) as B
group by ac_no