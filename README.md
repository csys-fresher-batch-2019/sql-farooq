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
### feature 2: Book tickets
## table 2:
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
