--orders of particular customer
set search_path to production;
select o_id, name, phone_no from customer_detail natural join order_detail
where ac_no = '200601011230'