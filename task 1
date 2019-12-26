create table task
(
task_name varchar(30) not null,
emp_name varchar2(30) not null,
emp_id number not null,
deadline_date date not null,
comp_date date,
status varchar2(30) not null,
constraint status_ck check(status in ('assigned','processing','completed'),
constraint emp_id_pk primary key (emp_id),
); 

select * from task;
