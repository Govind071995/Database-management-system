-- dll for production schima
      ﻿
SET search_path TO production;

create table Customer_detail(
  Ac_no varchar(20) primary key,
  Name varchar(20),
  Phone_no varchar(13),
  Address varchar(200)
 );

create table Order_detail(
  O_id varchar(20) primary key,
  O_date date,
  ac_no varchar(20),
  FOREIGN KEY(ac_no) references Customer_detail(Ac_no)
);

create table Item_detail(
  I_id varchar(20) primary key,
  Item_name varchar(20),
  specification varchar(500)
 );


create table Item(
  I_id varchar(20) references Item_detail(I_id),
  O_id varchar(20),
  qty numeric(8,3),
  qty_in_number integer,
  additional_charge numeric(13,3),
  rate numeric(8,3),
  comment_for_additional_charge varchar(500),
  primary key (I_id,O_id),
  FOREIGN KEY (O_id) references Order_detail(O_id)
  --foreign key(I_id) references Item_detail(I_id) 
 );

create table advance(
  ac_no varchar(20) references Customer_detail(Ac_no),
  amount numeric(13,3),
  date_of_payment date,
  payment_seq_of_day integer,
  commnt varchar(500),
  primary key(ac_no,date_of_payment,payment_seq_of_day)
 );


create table Delivery(
  Delivery_date date,
  O_id varchar(20) references Order_detail(O_id),
  I_id varchar(20) references Item_detail(I_id),
  qty_in_number integer,
  delivery_seq_of_day integer,
  qty numeric(8,3),
  primary key (Delivery_date,O_id,I_id,Delivery_seq_of_day)
 );

create table Transportation(
  Transportation_charge numeric(7),
  Delivery_seq_of_day integer,
  Delivery_date date,
  O_id varchar(20) references Order_detail(O_id),
  Destination_Address varchar(200),
  primary key(Delivery_seq_of_day,Delivery_date,O_id)
 ); 
