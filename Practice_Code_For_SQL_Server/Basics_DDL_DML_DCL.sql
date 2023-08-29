create table sample(id integer)
insert into sample(id) values('100')
select (15+6) as addition
select count(*) as records_count from sample

declare @temp datetimeoffset = '2016-12-21'
select @temp as time

---------------------------------------------------------------
-------------create employee table-------------
create table emp.emp.employee(emp_id varchar(100) primary key, emp_nm varchar(100), 
emp_sal int, dept_id int, loc_id int)

create table emp.emp.department(dept_id int not null, dept_name varchar(100), 
dept_head varchar(100))

drop table emp.emp.employee
drop table emp.emp.department
drop table emp.emp.location

create table emp.emp.location(loc_id int not null, city varchar(100), 
country varchar(max), region varchar(100))

alter table emp.emp.employee alter column emp_id varchar(100)

insert into emp.emp.employee values('A33','C',75,11,102)
select * from emp.employee

alter table emp.emp.employee add primary key(emp_id)
alter table emp.emp.department add primary key(dept_id)
alter table emp.emp.location add primary key(loc_id)

alter table emp.emp.employee add foreign key(dept_id) references
emp.emp.department(dept_id)

alter table emp.emp.employee add foreign key(loc_id) references
emp.emp.location(loc_id)

create table emp.emp.employee_active(id int, name varchar(100),
age int)

create table emp.emp.employee_terminated(id int, name varchar(100),
age int, termination_date date)

insert into emp.emp.employee_active values(4,'H',66)


select id,name,age,null as termination_date from emp.emp.employee_active
union
select * from emp.emp.employee_terminated



SELECT dept_id,emp_name, sum(emp_sal) from employee group 
by dept_id order by sal								




select id from emp.emp.employee_active where (id % 2) != 0 

select 21,20
select name from emp.emp.employee_active where name like('R%')
select name from emp.emp.employee_active where name like('R%L')


SELECT dept_id,emp_nm, sum(emp_sal) from emp.emp.employee 
group by dept_id,emp_nm,emp_sal order by emp_sal	

select * from emp.emp.employee

print round()
--

create table studentinfo(stud_id int, email varchar(100))

insert into studentinfo values(10,'gaurav@gmail.com')
insert into studentinfo values(11,'rahul@gmail.com')
insert into studentinfo values(12,'ram@yahoo.com')
insert into studentinfo values(13,'rahul@rockwellautomation.com')
insert into studentinfo values(14,'shyam@gmail.com')
select * from studentinfo
select charindex('@',email) from studentinfo
select email,substring(email,1,charindex('@',email)-1) as username from studentinfo

alter table studentinfo add primary key(email)

select getdate()
select CURRENT_TIMESTAMP
select SYSDATETIME()

select stud_id from studentinfo where (stud_id % 2) = 0
select stud_id from studentinfo where (stud_id % 2) != 0

select stud_id,case 
when (stud_id % 2) = 0
then
'even'
else
'odd'
end
as odd_or_even
from
studentinfo

SELECT gender, AVG(age) FROM employee GROUP BY gender, age having avg(age) > 3

create table employee(gender varchar(100), age integer)
insert into employee values('male',26)
insert into employee values('female',33)

select getdate()
select CURRENT_TIMESTAMP
select SYSDATETIME()

select DATEPART(DAYOFYEAR,GETDATE())
SELECT DATEDIFF(YEAR, '2022-03-18', '2022-03-25');
select ISDATE('2022-03-18')
/**
select current date
having
w3school
database schema
**/
SELECT top 2 * FROM employee as employees
ORDER BY  gender desc;
select ascii('a')
select concat('a','b')
select char(128)

select unicode('gaurav')
select power(2,3)
select rand() * 10

select age as 'current age',gender from employee where age between 10 and 44 and gender in('male','female')

select *  from emp.emp.employee_terminated
union all
select id,name,age,null as termination_date from emp.emp.employee_active

select a.id,a.name,a.age,t.termination_date
from emp.emp.employee_active a
full join
emp.emp.employee_terminated t
on a.id = t.id

create table employee2(gender varchar(100), age integer)
insert into employee2 select * from employee


create table windows_fun(salary int, dept varchar(100))
insert into windows_fun values
(1000,'HR'),
(1500,'HR'),
(1500,'IT'),
(1500,'IT'),
(2200,'IT'),
(2500,'SALES'),
(2500,'SALES'),
(2500,'SALES'),
(3000,'SALES');


select * from windows_fun
select salary,dept,dense_rank()
over(partition by dept order by salary) as row_number
from windows_fun

select salary from windows_fun where salary > (select min(salary) from windows_fun)

create table windows_fun3(salary int, dept varchar(100))

insert into windows_fun3 select * from windows_fun

select * from windows_fun3

select column_names from table where column_name <
(select max(salary) from table)

--select second highest salary
select max(salary) from windows_fun where salary < (select max(salary) from windows_fun)



select min(salary) from windows_fun where salary > (select min(salary) from windows_fun 
where salary > (select min(salary) from windows_fun))

select * from windows_fun

--lead & lag functions
select dept,salary,lead(salary,1,0) over(order by salary) as next_salary from windows_fun
order by salary
select dept,salary,lag(salary,1,0) over(partition by dept order by salary) as prev_salary,
lead(salary,1,0) over(partition by dept order by salary) as next_salary,
salary - lag(salary,1,0) over(order by salary)as salary_diff from windows_fun
order by salary

select top 1 salary from windows_fun
select * from windows_fun
select FIRST_VALUE(salary) over(order by salary) from windows_fun


--read first & last value
select salary,dept,first_VALUE(salary) over(order by salary)
as first_salary from windows_fun

select salary,dept,last_VALUE(salary) over(order by salary rows between unbounded preceding
and unbounded following) as last_salary from windows_fun

--read second highest/lowest salary
select salary
from windows_fun 
where (select salary,dense_rank() over(order by salary desc) from windows_fun) = 2

group by salary
having  = 2
order by salary
select dense_rank() over(order by salary desc) from windows_fun
group by salary having
dense_rank() over(order by salary) = 2

select salary,dense_rank() over(order by salary desc) as denserank from windows_fun

select first_VALUE(salary) over(order by dept)
as first_salary from windows_fun

select * from windows_fun

select salary,dense_rank() over(order by salary desc) as denserank from windows_fun


select * from windows_fun


select top 1 salary from windows_fun 
where salary != (select max(salary) from windows_fun)
order by salary desc

select top 1 salary from windows_fun 
where salary not in (select top 2 salary from windows_fun order by salary asc)
order by salary asc


create view second_high
as
select salary,dense_rank() over(order by salary desc) as denserank from windows_fun

select distinct salary as second_high_salary from second_high where (select distinct dense_rank() over(order by salary desc) from windows_fun) = 2




create view second_min
as
select salary,dense_rank() over(order by salary) as denserank from windows_fun

select distinct salary as second_lowest_salary from second_min where denserank = 2

select *  from emp.emp.employee_terminated
--union
select id,name,age,null as termination_date from emp.emp.employee_active

select a.id,a.name,a.age,t.termination_date
from emp.emp.employee_active a
left join
emp.emp.employee_terminated t
on a.id = t.id

with second_low
as
(
	select salary,dense_rank() over(order by salary) as denserank from windows_fun
)
select distinct salary as second_lowest_salary from second_low where denserank = 2


--create employee table
create table emp1(id int ,name varchar(100),gender 
varchar(100),salary int,departmentid int)

--create department table
create table dept(departmentid int primary key,departmentname varchar(100),location varchar(100),
     departmenteahd varchar(100))

alter table emp1 add foreign key(departmentid) references dept(departmentid)

insert into dept values
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella');


insert into emp1 values
(1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, null),
(10, 'Russell', 'Male', 8800, null)

select * from emp1
select * from dept

select e.id,e.name,e.salary,d.departmentid,d.departmentname
from emp1 e
full join dept d
on e.departmentid = d.departmentid


select * from (
select distinct salary,DENSE_RANK() over(order by salary desc) as row_no from windows_fun
order by salary desc) as denserank where row_no = 2


select * from windows_fun

with cte_win_fun
as
(
select *,DENSE_RANK() over(partition by dept,salary order by salary,dept) as rank_no from windows_fun
)
select * from cte_win_fun

select * from windows_fun
intersect
select * from windows_fun
-----
with cte_win_fun
as
(
select *,DENSE_RANK() over(partition by dept,salary order by salary,dept) as rank_no from windows_fun
)
select * from cte_win_fun


with cte_win_fun
as
(
select *,row_number() over(partition by dept,salary order by salary,dept) as rank_no from windows_fun
)
select * from cte_win_fun where rank_no > 1

