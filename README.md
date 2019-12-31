# RAIL TICKET BOOKING

## summary:
To know the availability status of the train and book tickets accordingly. 

## features:

### feature 1: list all trains


QUERY:

``` sql
create table viewtrain
(
train_num number ,
train_name varchar2(20),
boarding_station varchar2(20) not null,
destination_station varchar2(20) not null,
arr_time number not null,
dept_time number not null,
route varchar2(20) not null,
status varchar2(10) not null,
seat_avail number not null,
constraint train_num_pk primary key (train_num),
constraint station_ck check (boarding_station <> destination_station),
constraint time_ck check (arr_time <> dest_time),
constraint status_ck check (status in('available','not available','delayed','cancelled')),
constraint same_uq unique(train_name,boarding_station,destination_station)
);

select * from viewtrain;

```
### feature 2: Book tickets

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
