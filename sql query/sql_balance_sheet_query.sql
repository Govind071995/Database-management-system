-- prepare the balance sheet of a customer 200603010920 upto given date = 01/02/2007.

(select O_id
from Order_detail
where ac_no = '200603010920'
)as r1


(select *
from delivery
where delivery.O_id in r1.O_id
      and delivery_date < '01-02-2007') as r2


(select r2.O_id,r2.I_id,r2.delivery_date,r2.qty_in_no,r2.qty,r2.qty * item.rate as amount
from r2 join item on(r2.O_id=item.O_id and r2.I_id=item.I_id))as r3;


(selet O_id,I_id,sum(amount)as amount
from r3
group by (O_id,I_id))as r4;


select r4.O_id,r4.I_id,item_detail.item_name,r4.amount,Item.Additional_charge,r4.amount + item.additional_charge as total
from r4 join item on(r4.O_id=item.O_id and r4.I_id = item.I_id ) join item_detail on (r4.I_id = item_detail.I_id);


select Date_of_payment,amount
from advance
where date_of_payment < '01-02-2007;






1) query:- Show all the items of all the orders given by a customer (ac= 200601011230) which is delivered before 01-02-2007 and also the amount of corresponding item with its delivery date.


set search_path to production;
select Order_id,r3.I_id,item_name,specification,delivery_date,qty_in_number,qty,amount
from

 (select r2.Order_id,r2.I_id,r2.delivery_date,r2.qty_in_number,r2.qty,r2.qty * item.rate as amount
  from (select *,delivery.O_id as Order_id
        from delivery join (select O_id
                           from Order_detail
                           where ac_no = '200601011230')as r1 on (delivery.O_id = r1.O_id)
        where delivery_date < '01-02-2007') as r2 
  join item on( r2.Order_id = item.O_id and r2.I_id = item.I_id)) as r3
 join item_detail on (r3.I_id=item_detail.I_id);

