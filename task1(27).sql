drop table book;
drop table orderbook;

create table book(
book_id number,
book_name varchar2(30) not null,
auther varchar2(30) not null,
publisher varchar2(30) not null,
edition_num number not null,
status number default 1,
price number not null,
constraint book_id_pk primary key (book_id),
unique(book_id,book_name,edition_num),
constraint status_check check (status in ('1','0')),
constraint price_ck check (price>=1)
);

insert into book(book_id,book_name,auther,publisher,edition_num,status,price)
values(1,'digital electronics','salivahanan','MC Graw Hill',3,1,200);

insert into book(book_id,book_name,auther,publisher,edition_num,status,price)
values(2,'analog electronics','salivahanan','MC Graw Hill',3,1,300);

insert into book(book_id,book_name,auther,publisher,edition_num,status,price)
values(3,'electronics','salivahanan','MC Graw Hill',3,1,400);

select * from book;

create table orderbook(
book_id number not null,
order_id number not null,
customer_id number not null,
ordered_date timestamp,
delivered_date timestamp,
quantity number not null,
total number not null,
status varchar2(20) default 'ordered',
constraint order_id_pk primary key (order_id),
constraint quantity_ck check (quantity>=1),
constraint customer_id_uq unique(customer_id),
constraint status_ck check ( status in ('ordered','cancelled','out_for_delivery')),
constraint total_ck check ( total>=1),
constraint book_id_fk foreign key (book_id) references book(book_id)
);

insert into orderbook (book_id,order_id,customer_id,ordered_date,delivered_date,quantity,total,status)
values(1,222,2222,(sysdate),(sysdate),2,600,'ordered');

insert into orderbook (book_id,order_id,customer_id,ordered_date,delivered_date,quantity,total,status)
values(1,223,2223,(sysdate),(sysdate),2,600,'ordered');

insert into orderbook (book_id,order_id,customer_id,ordered_date,delivered_date,quantity,total,status)
values(2,225,2220,(sysdate),(sysdate),2,600,'out_for_delivery');

------checking with book_id 4----error:
-----ORA-02291: integrity constraint (SQL_AIQZPQGQPXJPJJGRYHKEHGQSQ.BOOK_ID_FK) violated - parent key not found ORA-06512: at "SYS.DBMS_SQL", line 1721

insert into orderbook (book_id,order_id,customer_id,ordered_date,delivered_date,quantity,total,status)
values(4,226,2225,(sysdate),(sysdate),2,600,'ordered');


select * from orderbook;
