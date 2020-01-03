# RAIL TICKET BOOKING

## summary:
To know the availability status of the train and book tickets accordingly. 

## features:
## table 1:
| train_num | train_name      | boarding_station | destination_station | arr_time                     | dept_time                    | route                  | status            |
|-----------|-----------------|------------------|---------------------|------------------------------|------------------------------|------------------------|-------------------|
| 32636     | vaigai express  | chennai          | madurai             | 01-JAN-20 02.00.00.000000 AM | 02-JAN-20 12.00.00.000000 PM | chennai-trichy-madurai | available running |
| 32637     | pandian express | madurai          | chennai             | 01-JAN-20 02.00.00.000000 AM | 02-JAN-20 12.00.00.000000 PM | madurai-trichy-chennai | available running |

### feature 1: list all trains


QUERY:

``` sql
create table viewtrain
(
train_num number ,
train_name varchar2(20),
boarding_station varchar2(20) not null,
destination_station varchar2(20) not null,
arr_time timestamp not null,
dept_time timestamp not null,
route varchar2(30) not null,
status varchar2(20) not null,
constraint train_num_pk primary key (train_num),
constraint station_ck check (boarding_station <> destination_station),
constraint time_ck check (arr_time <> dept_time),
constraint status_ck check (status in('available running','available yet to start','not available','cancelled')),
constraint same_uq unique(train_name,boarding_station,destination_station)

);

insert into viewtrain(train_num,train_name,boarding_station,destination_station,arr_time,dept_time,route,status)
values(32636,'vaigai express','chennai','madurai',TO_TIMESTAMP_TZ('2020-01-0102:00:00-08:00','YYYY-MM-DDHH:MI:SSTZH:TZM'),
TO_TIMESTAMP_TZ('2020-01-0212:00:00-08:00','YYYY-MM-DDHH:MI:SSTZH:TZM'),'chennai-trichy-madurai','available running');

insert into viewtrain(train_num,train_name,boarding_station,destination_station,arr_time,dept_time,route,status)
values(32637,'pandian express','madurai','chennai',TO_TIMESTAMP_TZ('2020-01-0102:00:00-08:00','YYYY-MM-DDHH:MI:SSTZH:TZM'),
TO_TIMESTAMP_TZ('2020-01-0212:00:00-08:00','YYYY-MM-DDHH:MI:SSTZH:TZM'),'madurai-trichy-chennai','available running');

insert into viewtrain(train_num,train_name,boarding_station,destination_station,arr_time,dept_time,route,status)
values(32638,'intercity express','trichy','tirunelveli',TO_TIMESTAMP_TZ('2020-01-0102:00:00-08:00','YYYY-MM-DDHH:MI:SSTZH:TZM'),
TO_TIMESTAMP_TZ('2020-01-0212:00:00-08:00','YYYY-MM-DDHH:MI:SSTZH:TZM'),'trichy-madurai-tirunelveli','available running');

```


### feature 2: Registration

## table 1:

| user_id | user_name | password | email_id          | phone_num  | gender | dob        | country_name |
|---------|-----------|----------|-------------------|------------|--------|------------|--------------|
| 1       | farooq    | p1234    | farooq@gmail.com  | 8778621280 | M      | 05.01.1999 | India        |
| 2       | mohamed   | p4321    | mohamed2gmail.com | 8765432134 | M      | 08.02.99   | India        |


query:
```sql
create table registration 
( 
user_id number not null, 
user_name varchar2(20) not null, 
pass varchar2(20) not null, 
email_id varchar2(20) not null, 
phone_num char(10) not null, 
gender varchar2(2) not null, 
dob varchar2(10), 
country_name varchar2(25) not null, 
constraint user_id_pk primary key (user_id), 
constraint same_uq unique(user_name,user_id,phone_num), 
constraint gender_ck check (gender in ('M','F')),
constraint phone_num_ck check (phone_num not like '%[^0-9]%') 
);


insert into registration (user_id,user_name,pass,email_id,phone_num,gender,dob,country_name)
values(1,'farooq','p1234','farooq@gmail.com',8778621280,'M',to_date('05.01.1999','dd.MM.yyyy'),'India');
insert into registration (user_id,user_name,pass,email_id,phone_num,gender,dob,country_name)
values(2,'mohamed','p1234','mohamed@gmail.com',8778621281,'M',to_date('05.01.1999','dd.MM.yyyy'),'India');
insert into registration (user_id,user_name,pass,email_id,phone_num,gender,dob,country_name)
values(3,'ameer','p4321','ameer@gmail.com',8778621282,'M',to_date('05.01.1989','dd.MM.yyyy'),'China');
select * from registration;
```

### feature 3: Book tickets
## table 1:



| train_num | train_name      | boarding_station | destination_station | no_of_seats                  | curr_status                  |
|-----------|-----------------|------------------|---------------------|------------------------------|------------------------------|
| 32636     | vaigai express  | chennai          | madurai             | 2                            | confirmed                    |
| 32637     | pandian express | madurai          | chennai             | 5                            | waiting_list                 |

QUERY: 

``` sql

create table booking
(
pnr_num number not null,
train_num number,
train_name varchar2(20),
boarding_station varchar2(20) not null,
destination_station varchar2(20) not null,
no_of_seats number not null,
curr_status varchar2(20) not null,
constraint pnr_num_pk primary key (pnr_num),
constraint station1_ck check (boarding_station <> destination_station),
constraint no_of_seats_ck check (no_of_seats >=0),
constraint curr_status_ck check (curr_status in('booked','waiting_list'))
);

create sequence pnr_num_seq start with 123456789 increment by 2;

insert into booking (pnr_num,train_num,train_name,boarding_station,destination_station,no_of_seats,curr_status)
values(pnr_num_seq.nextval,'32636','vaigai express','chennai','madurai',2,'booked');

insert into booking (pnr_num,train_num,train_name,boarding_station,destination_station,no_of_seats,curr_status)
values(pnr_num_seq.nextval,'32636','vaigai express','chennai','madurai',2,'booked');

insert into booking (pnr_num,train_num,train_name,boarding_station,destination_station,no_of_seats,curr_status)
values(pnr_num_seq.nextval,'32637','pandian express','chennai','madurai',5,'booked');

select * from booking;
```
## table 2: total number of seats.


| train_num | avail_seats |
|-----------|-------------|
| 32636     | 100         |
| 32637     | 100         |

query:
```sql

create table seats
(
train_num number not null,
avail_seats number not null,
constraint train_num_uq unique (train_num),
constraint train_num_pf foreign key (train_num) references viewtrain(train_num)
);

insert into seats(train_num,avail_seats)values(32636,100);
insert into seats(train_num,avail_seats)values(32637,100);
insert into seats(train_num,avail_seats)values(32638,100);

select * from seats;

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

```sql

create or replace PROCEDURE PR_booking_status
(
i_train_num  in number ,
curr_status out varchar2,
i_pnr_num IN number
) AS 
V_booking_Seats number;
BEGIN
   V_booking_seats := findavail ( I_train_num,i_pnr_num);
   IF V_booking_seats <= 0 THEN
    update booking set curr_status = 'waiting_list' where train_num = i_train_num;    
   ELSE
    update booking set curr_status = 'confirmed';    
  END IF;
  COMMIT;
END PR_booking_status;

---------------------------------
DECLARE
v_train_num number := 32636;
v_curr_status varchar2(30);
v_pnr_num number := 123456835 ;
BEGIN
PR_booking_status(v_train_num,v_curr_status,v_pnr_num);
END;
```
