--total amount of purchase of firm for 2006
set search_path to purchase;
select sum(final_cost) as overturn
from
(select p_id, order_cost + order_transport_charge as final_cost
from
(select p_id, sum(total_item_cost) as order_cost
from
(select p_id, i_id, item_cost + percentage_additional_charge as total_item_cost
from
(select p_id, i_id, item_cost, additional_charge * percent_delivered as percentage_additional_charge
from
(select *, delivered_qty/total_qty as percent_delivered
from
(select A.p_id, A.i_id, A.qty as delivered_qty, B.qty as total_qty, A.qty *B.rate as item_cost, B.additional_charge
from
(select * 
from receival
where date_of_receival> '2005-12-31' and date_of_receival < '2007-01-01') as A join item as B on A.p_id=B.p_id and A.i_id=B.i_id) as C) as D) as E) as FF
group by p_id
order by p_id) as J natural join (select p_id, sum(transportation_charge) as order_transport_charge
from transportation
where date_of_receival> '2005-12-31' and date_of_receival < '2007-01-01'
group by p_id) as K) as L