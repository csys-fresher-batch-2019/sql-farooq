create table task
(
task_name varchar(30) not null,
emp_name varchar2(30) not null,
emp_id number not null,
deadline_date date not null,
  created_date date,
comp_date date,
  modify_task_date date not null,
status varchar2(30) not null,
constraint status_ck check(status in ('assigned','processing','completed'),
constraint emp_id_pk primary key (emp_id)                          
); 
insert into task(task_name,emp_name,emp_id,deadline_date,created_date date,comp_date date, modify_table_date,status);
  values('install oracle','farooq',1111,to_date('26.12.2019','dd.MM.yyyy'),to_date('20.12.2019','dd.MM.yyyy'),to_date('25.12.2019','dd.MM.yyyy'),
        to_date(sysdate,'dd.MM.yyyy','completed');
        insert into task(task_name,emp_name,emp_id,deadline_date,created_date date,comp_date date, modify_table_date,status);
  values('install jdk','kani',1112,to_date('20.12.2019','dd.MM.yyyy'),to_date('15.12.2019','dd.MM.yyyy'),to_date(sysdate,'dd.MM.yyyy'),'processing');
insert into task(task_name,emp_name,emp_id,deadline_date,created_date date,comp_date date, modify_table_date,status);
  values('install phython','farooq',1113,to_date('26.12.2019','dd.MM.yyyy'),to_date('20.12.2019','dd.MM.yyyy'),to_date('26.12.2019','dd.MM.yyyy'),
        to_date(sysdate,'dd.MM.yyyy'),'completed');

        alter table task add priority (number);
        update task set priority=1 where task_name='install oracle';
        update task set priority=2 where task_name='install jdk';
        update task set priority=3 where task_name='install phython';

select * from task;
