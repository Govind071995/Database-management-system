--payment details of a customer
set search_path to production;
select name, amount, date_of_payment, payment_seq_of_day
from customer_detail natural join advance
where ac_no= '200601011230'