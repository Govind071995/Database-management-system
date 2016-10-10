--popular items
set search_path to production;
select item_name, count(o_id)
from item_detail natural join item
group by item_name
having count(o_id) > 5
