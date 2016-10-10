--list total of each item of an order
set search_path to production;
select i_id, item_name, specification, qty, rate,item_cost, trans_charge_of_one_item,additional_charge, item_cost + additional_charge + trans_charge_of_one_item as total
from (select i_id, item_name, specification, qty, rate, qty*rate as item_cost, additional_charge 
from item natural join item_detail
where o_id='200601011230') as A natural join (select i_id, sum(transportation_charge) as trans_charge_of_one_item
from delivery join transportation on delivery.o_id= transportation.o_id
group by i_id
order by i_id) as B