create table book
(
book_id number,
book_title varchar2(20),
--price number not null,
constraint book_id_pk primary key (book_id),
constraint book_title_uq unique (book_title)
--constraint price_ck check (price>=1)
);

insert into book (book_id,book_title) values(101,'c');
insert into book (book_id,book_title) values(102,'java');



create table book_stock
(
stock_id number,
book_id number,
quantity number,
constraint stock_id_pk primary key (stock_id),
constraint book_id_fk foreign key (book_id) references book(book_id),
constraint quantity_ck check (quantity>=0)
);


insert into book_stock(stock_id,book_id,quantity) values (1,101,100);
insert into book_stock(stock_id,book_id,quantity) values (2,102,55);

drop table order1;
create table order1
(
order_id number,
username varchar2(20) not null,
--total_amount number,
book_id number not null,
--ordered_date date not null,
--delivered_date date,
quantity number not null, 
status varchar2(20) default 'ordered',
constraint order_id_pk primary key (order_id),
--constraint total_amount_ck check (total_amount>=0),
constraint status_ck check (status in('ordered','delivered','cancelled','shipping','not available'))
);


insert into order1(order_id,username,book_id,quantity,status) values (1,'asd',101,5,'ordered');

insert into order1(order_id,username,book_id,quantity,status) values (2,'qwe',101,3,'delivered');
insert into order1(order_id,username,book_id,quantity,status) values (3,'zxc',102,2,'ordered');
insert into order1(order_id,username,book_id,quantity,status) values (4,'fgh',101,1,'cancelled');

select * from order1;
select * from book;
select * from book_stock;

-------------------------------------------------------------
drop function findstock;
-------------------------------------------------------------
 -------------FUNCTION CREATION---------------
                            
 create or replace function findstock(i_book_id IN number) 
 return number AS 
 v_remaining_stock number;
 v_ordered_stock number;
 v_stock number;
 
 begin
 
select quantity into v_stock from book_stock where book_id = i_book_id;

select sum(quantity) into v_ordered_stock from order1 where status IN ('ordered','delivered') and book_id = i_book_id;

v_remaining_stock := v_stock - v_ordered_stock;

return v_remaining_stock;

end findstock;

----------------RUN FUNCTIONS-------------
select findstock(101) from dual;

select b.*, findstock(book_id) from book b;
------------------------------------------------
                            
                            
  -------------PROCEDURE CREATION-----------
                            
drop procedure order_book;
---------------------------------------------
create or replace procedure order_book
(
i_book_id IN NUMBER,
i_qty IN NUMBER,
i_username IN VARCHAR2,
i_order_id IN NUMBER,
I_ERROR_MESSAGE OUT VARCHAR2)
AS
v_book_stock number;
begin
v_book_stock := findstock(i_book_id);
if v_book_stock >= i_qty then 
insert into order1(order_id,username,book_id,quantity,status) values(i_order_id,i_username,i_book_id,i_qty,'ordered');
end if; 
commit;
end order_book;

------------------EXECUTE PROCEDURE-----------
                            
                            
DECLARE i_book_id NUMBER := 101; 
i_qty NUMBER := 555; 
i_username VARCHAR2(20) := 'khader';
i_order_id NUMBER :=6;
i_error_message varchar2(100) ;
BEGIN
order_book (i_book_id,i_qty,i_username,i_order_id,i_ERROR_MESSAGE);
IF i_error_message IS NOT NULL THEN
DBMS( 'Error - ' || i_error_message ); 
END IF;
END;
-----------------------------------------------

select * from order1;



