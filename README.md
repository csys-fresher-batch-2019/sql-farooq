# RAIL TICKET BOOKING

## summary:
To know the availability status of the train and book tickets accordingly. 

## features:

### feature 1: list all trains


QUERY:

``` sql
create table viewtrain
(
train_num number not null,
train_name varchar2(20),
boarding_station varchar2(20),
destination_station varchar2(20),
arr_time number not null,
dest_time number not null,
route varchar2(20),
status varchar2(10),
seat_avail number not null,
constraint train_num_pk primary key (train_num),
constraint station_ck check (boarding_station <> destination_station),
constraint time_ck check (arr_time <> dest_time),
constraint status_ck check (status in('available','not available','delayed','cancelled'))
);

select * from viewtrain;

```
### feature 2: Book tickets

QUERY: 

``` sql

create table booktickets
(
pass_name varchar2(20) not null,
train_num number not null,
pass_id varchar2(20) not null,
travel_date date not null,
boarding_station varchar2(10) not null,
phone_number number not null,
berth varchar2(10),
insurance_need varchar2(5) not null,
pnr_num number not null,
status1 varchar2(15) not null,
constraint pass_id_pk primary key (pass_id),
constraint train_num_fk foreign key (train_num) references viewtrain(train_num),
constraint phone_number_ck check (phone_number =10),
constraint berth_ck check (berth in ('lower','middle','upper','sideupper','sidelower')),
constraint insurance_need_ck check (insurance_need in ('1','0')),
constraint travel_date_ck check (travel_date >= sysdate)
);
create sequence pnr_num_seq start with 123456789 increment by 2;

```
