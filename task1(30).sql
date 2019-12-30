
drop table users;

drop table task1;

create table users(
user_id number not null,
user_name varchar(20) not null,
email_id varchar2(20) not null,
pass varchar2(20) not null,
constraint user_id primary key (user_id)
);
drop sequence user_id_seq;

create sequence user_id_seq start with 1 increment by 1;
insert into users values(user_id_seq.nextval,'farooq','farooq@gmail.com',1234);

insert into users values(user_id_seq.nextval,'mohamed','mohamed@gmail.com',1234);

insert into users values(user_id_seq.nextval,'ameer','ameer@gmail.com',1234);


create table task1
(
task_id number not null,
assigned_to number not null,
task_name varchar2(30) not null,
constraint assigned_to_fk foreign key (assigned_to) references users(user_id)
);

drop sequence task_id_seq;
create sequence task_id_seq start with 1 increment by 1;
insert into task1 values(task_id_seq.nextval,1,'install oracle');

insert into task1 values(task_id_seq.nextval,2,'install jdk');
insert into task1 values(task_id_seq.nextval,1,'install sql');

-----cross join---
select * from users,task1;

------inner join-----
select * from users u,task1 t where u.user_id = t.assigned_to;

------left outer join----
select * from users u left outer join task1 t on u.user_id = t.assigned_to; 

------right outer join-----
select * from users u right outer join task1 t on u.user_id = t.assigned_to; 

-----full outer join------
select * from users u full outer join task1 t on u.user_id = t.assigned_to; 

-----self join------
drop table datas;
create table datas(
emp_id number not null,
emp_name varchar2(20),
mgr_id number
);

insert into datas values(1,'farooq',NULL);
insert into datas values(2,'mohamed',1);
insert into datas values(3,'ameer',2);

select e1.*,e2.emp_name  as manager_name from datas e1,datas e2 where e1.mgr_id= e2.emp_id;

select * from task1;
select * from users;
