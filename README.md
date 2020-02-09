# RAIL TICKET BOOKING

## summary:
To know the availability status of the train and book tickets accordingly. 

## features:
## table 1:
| train_num | train_name       | Travel_Date | boarding_station | destination_station | Arrival Time                   | Departure Time                 | Route                  | Status            | Amount |
|-----------|------------------|-------------|------------------|---------------------|--------------------------------|--------------------------------|------------------------|-------------------|--------|
| 32636     | vaigai express   | 21-04-2020  | chennai          | madurai             | 05-01-20 08:00:00.000000000 AM | 06-01-20 02:00:00.000000000 AM | chennai-trichy-madurai | available running | 100    |
| 32637     | pandiyan express | 21-04-2020  | madurai          | chennai             | 01-01-20 02:00:00.000000000 AM | 02-01-20 12:00:00.000000000 PM | madurai-trichy-chennai | cancelled         | 150    |

### feature 1: list all trains


QUERY:

``` sql
create table viewtrain
(
train_num number ,
train_name varchar2(20),
traveldate date,
boarding_station varchar2(20) not null,
destination_station varchar2(20) not null,
arr_time timestamp not null,
dept_time timestamp not null,
route varchar2(30) not null,
status varchar2(20) not null,
amount number not null,
constraint train_num1_pk primary key (train_num),
constraint station_ck check (boarding_station <> destination_station),
constraint time_ck check (arr_time <> dept_time),
constraint status_ck check (status in('available running','available yet to start','not available','cancelled')),
constraint same_name_and_srcdest_uq unique(train_name,boarding_station,destination_station)
);



insert into viewtrain(train_num,train_name,traveldate,boarding_station,destination_station,arr_time,dept_time,route,status,amount)
values(32636,'vaigai expres',to_date('21-04-2020','dd-MM-yyyy'),'chennai','madurai',to_TIMESTAMP('2020-01-0508:00:00','YYYY-MM-DDHH:MI:SS'),
TO_TIMESTAMP('2020-01-0602:00:00','YYYY-MM-DDHH:MI:SS'),'chennai-trichy-madurai','available running',100);

insert into viewtrain(train_num,train_name,traveldate,boarding_station,destination_station,arr_time,dept_time,route,status,amount)
values(32637,'pandian express',to_date('22-04-2020','dd-MM-yyyy'),'madurai','chennai',TO_TIMESTAMP('2020-01-0102:00:00','YYYY-MM-DDHH:MI:SS'),
TO_TIMESTAMP('2020-01-0212:00:00','YYYY-MM-DDHH:MI:SS'),'madurai-trichy-chennai','available running',150);

insert into viewtrain(train_num,train_name,boarding_station,destination_station,arr_time,dept_time,route,status,amount)
values(32638,'intercity express','trichy','tirunelveli',TO_TIMESTAMP('2020-01-0109:00:00','YYYY-MM-DDHH:MI:SS'),
TO_TIMESTAMP('2020-01-0212:00:00','YYYY-MM-DDHH:MI:SS'),'trichy-madurai-tirunelveli','available running',200);

```

## update new train name
```sql
update viewtrain set train_name = 'pothigai express' where train_num = 32636);
```
### feature 2: Registration

## table 2:

| user_id | user_name | password | email_id          | phone_num  | gender | dob        | city_name    |Blocklist  |
|---------|-----------|----------|-------------------|------------|--------|------------|--------------|-----------|
| 1031    | farooq    | p1234    | farooq@gmail.com  | 8778621280 | M      | 05.01.1999 | madurai      |0          |
| 1032    | mohamed   | p4321    | mohamed@gmail.com | 8765432134 | M      | 08.02.1999 | chennai      |1          |


query:
```sql
create table registration 
( 
user_id number,
user_name varchar2(20) not null, 
pass varchar2(20) not null, 
email_id varchar2(200) not null, 
phone_num char(10) not null, 
gender char(1) not null, 
dob date not null, 
city_name varchar2(25) not null, 
blocklist number(1) default '0',
constraint user_id_pk primary key (user_id), 
constraint same_uq unique(email_id), 
constraint gender_ck check (gender in ('M','F')),
constraint phone_num_ck check (phone_num not like '%[^0-9]%'),
constraint blocklist_ck check( blocklist in (1,0))
);


insert into registration (user_id,user_name,pass,email_id,phone_num,gender,dob,city_name)
values(USER_ID_SEQ.nextval,'farooq','p1234','farooq@gmail.com',8778621280,'M',to_date('05.01.2019','dd.MM.yyyy'),'madurai');
insert into registration (user_id,user_name,pass,email_id,phone_num,gender,dob,city_name)
values(USER_ID_SEQ.nextval,'mohamed','p1234','mohamed@gmail.com',8778621281,'M',to_date('05.01.2020','dd.MM.yyyy'),'madurai');
insert into registration (user_id,user_name,pass,email_id,phone_num,gender,dob,city_name)
values(USER_ID_SEQ.nextval,'ameer','p4321','ameer@gmail.com',8778621282,'M',to_date('05.01.2019','dd.MM.yyyy'),'chennai');
```


### feature 3: Book tickets
## table 3:



|  Pnr_num  | train_num | Travel_Date | boarding_station | destination_station | no_of_seats | Current Status | travel_date |           Booked date          | Amount |
|:---------:|:---------:|:-----------:|:----------------:|:-------------------:|:-----------:|:--------------:|:-----------:|:------------------------------:|:------:|
| 123456789 |   32636   |  21-04-2020 |      chennai     |       madurai       |      4      |    no Status   |  22.01.2020 | 09-02-20 11:32:24.599000000 AM |   400  |
| 123456790 |   32637   |  21-04-2020 |      madurai     |       chennai       |      5      |    Confirmed   |  25.01.2020 | 09-02-20 11:37:23.790000000 AM |   750  |
QUERY: 

``` sql

create table booking
(
pnr_num number ,
train_num number ,
user_id number not null,
boarding_station varchar2(20) not null,
destination_station varchar2(20) not null,
no_of_seats number not null,
curr_status varchar2(20) default 'no status',
travel_date date not null,
booked_date timestamp,
amount number default '0',
constraint user_id_fk foreign key (user_id) references registration(user_id),
constraint train_number_fk foreign key (train_num)REFERENCES viewtrain(train_num),
constraint station1_ck check (boarding_station <> destination_station),
constraint seats_fk foreign key (no_of_seats) references noOfSeats(no_of_seats),
constraint same_id_date_uq unique(user_id,travel_date)
);
```
## sequence:
```sql
create sequence pnr_num_seq start with 123456789 increment by 2;

create sequence user_id_seq start with 1000 increment by 1;

create index train_num_index ON viewtrain (train_num);

```
## table 4: total number of seats.


| Travel Date | train_num | Available Seats |
|:-----------:|:---------:|:---------------:|
|  21-04-2020 |   32636   |       100       |
|  21-04-2020 |   32637   |       100       |

query:
```sql

create table seats
(
travel_date date,
train_num number not null,
avail_seats number ,
constraint same_tr_number_date unique(train_num,travel_date),
constraint train_num_fk foreign key (train_num)REFERENCES viewtrain(train_num)
);

insert into seats(travel_date,train_num,avail_seats)values(to_date('21-04-2020','dd-MM-yyyy'),32636,100);
insert into seats(travel_date,train_num,avail_seats)values(to_date('22-04-2020','dd-MM-yyyy'),32636,100);

insert into seats(travel_date,train_num,avail_seats)values(to_date('21-04-2020','dd-MM-yyyy'),32638,100);

```
## Table 5: Seats Count Constraint

| no_of_seats |
|:-----------:|
|      1      |
|      2      |

```sql
Create table noOfSeats(
no_of_seats number not null,
constraint seats_pk primary key (no_of_seats)
);
insert into noOfSeats values(1);
```



### function: count number of seats.

```sql

create or replace function findavail(i_train_num IN number,i_pnr_num IN number) 
 return number AS 
 v_remaining_seats number;
 v_booked_seats number;
 v_seats number;
 
begin
 
select avail_seats into v_seats from seats where train_num = i_train_num;

select sum(no_of_seats) into v_booked_seats from booking where train_num = i_train_num and pnr_num = i_pnr_num;

v_remaining_seats := v_seats - v_booked_seats;

return v_remaining_seats;

end findavail;

```

### procedure : check either confirmed or waitinglist
## table:
| pnr_num   | train_num | train_name     | boarding_station | destination_station | no_of_seats | current_status | travel_date |
|-----------|-----------|----------------|------------------|---------------------|-------------|----------------|-------------|
| 123456789 | 32636     | vaigai express | chennai          | madurai             | 5           | confirmed      | 22.01.2020  |
| 123456791 | 32636     | vaigai express | madurai          | chennai             | 5           | confirmed      | 25.01.2020  |```sql

```sql
create or replace PROCEDURE PR_booking_status
(
i_train_num  in number ,
i_pnr_num IN number,
i_user_id IN number,
i_train_name IN varchar2,
i_boarding_station IN varchar2,
i_destination_station IN varchar2,
i_no_of_seats IN number,
i_travel_date date,
amount IN number
) AS 
V_booking_Seats number;
BEGIN
V_booking_seats := findavail ( I_train_num);
   
   update seats set avail_seats = v_booking_seats-i_no_of_seats where train_num= i_train_num;
   
   select avail_seats into confirmation from seats where train_num= i_train_num;
   
   
   IF confirmation <= 0 THEN
   
   insert into booking (pnr_num,train_num,train_name,boarding_station,destination_station,no_of_seats,curr_status,travel_date,user_id)
   values(pnr_num_seq.nextval,i_train_num,i_train_name,i_boarding_station,i_destination_station,i_no_of_seats,'waiting list',i_travel_date,i_user_id);
   
   ELSE
   
   insert into booking (pnr_num,train_num,train_name,boarding_station,destination_station,no_of_seats,curr_status,travel_date,user_id)
   values(pnr_num_seq.nextval,i_train_num,i_train_name,i_boarding_station,i_destination_station,i_no_of_seats,'confirmed',i_travel_date,i_user_id);

END IF;
  COMMIT;
END PR_booking_status;


---------------------------------

DECLARE
v_train_num number := 32636;
v_user_id number:= 1;
v_pnr_num number;
v_train_name varchar2(20) := 'vaigai express';
v_boarding_station varchar2(20) := 'chennai';
v_destination_station varchar2(20) :='madurai';
v_no_of_seats number := 55;
v_curr_status varchar2(20);
v_travel_date date := to_date('12.12.12','dd.MM.yyyy');
v_amount number;
BEGIN
PR_booking_status(v_train_num,v_pnr_num,v_user_id,v_train_name,v_boarding_station,v_destination_station,v_no_of_seats,v_travel_date,amount);
END;

```
