create table book
(
book_id number,
book_title varchar2(20),
price number not null,
constraint book_id_pk primary key (book_id),
constraint book_title_uq unique (book_title),
constraint price_ck check (price>=1)
);




create table book_stock
(
stock_id number,
book_id number,
quantity number,
constraint stock_id_pk primary key (stock_id),
constraint book_id_fk foreign key (book_id) references book(book_id),
constraint quantity_ck check (quantity>=0)
);




create table order
(
order_id number,
username varchar2(20) not null,
total_amount number,
ordered_date date not null,
delivered_date date,
status varchar2(20) default 'ordered',
constraint order_id_pk primary key (order_id),
constraint total_amount_ck check (total_amount>=0),
constraint status_ck check (status in('ordered','delivered','cancelled','shipping','not available'))
);



create table order_items
(
item_id number,
order_id number,
book_id number,
quantity number not null,
status varchar2(20) default 'ordered',
constraint item_id_pk primary key (item_id),
constraint order_id_fk foreign key (order_id) references order(order_id),
constraint book_id foreign key (book_id) references book(book_id),
constraint or_it_qty_ck check (quantity>=0),
constraint or_it_status_ck check (status in('ordered','delivered','cancelled','shipping','not available'))
);



select quantity from book_stock where book_id=101;



select sum(quantity) from order_items where book_id=101;



select book_name,(select sum(quantity) from order_items where book_id=b.book_id) from books b;



select book_name,(select quantity from book_stock where book_id=b.book_id) from books b;



select book_name,
(
(select quantity from book_stock where book_id=b.book_id)
-
(select sum(quantity) from order_items where book_id=b.book_id)
) 
from books b;
