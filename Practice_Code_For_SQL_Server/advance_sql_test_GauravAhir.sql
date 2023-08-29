create database advance_sql
use advance_sql


create table employee(id int primary key,
name varchar(max), manager int,
work_loc varchar(100), joining_date date)

create table emp_details(id int primary key, 
bg varchar(100), address varchar(max), 
contact_no varchar(max))

insert into emp_details values(3,'a', 'latur 234253', '100001')
insert into employee values(11,'gaurav', 1, 'pune', '2022-11-30')
insert into employee values(14,'wres', 2, 'delhi', '2020-10-01')


alter table employee add foreign key(manager) 
references emp_details(id)

create proc sp_emp
@id int,
@name varchar(max), 
@manager int,
@work_loc varchar(100), 
@joining_date date,
@operation varchar(100)
as
begin
begin try
if(@operation = 'insert')
begin
	insert into employee values(@id,@name,@manager,@work_loc,@joining_date)
	print concat('Data Inserted Successfully = ',@@rowcount)
end
else if(@operation = 'update')
begin
	update employee set name = @name, manager = @manager, work_loc = @work_loc,
	joining_date = @joining_date
	where id = @id
	print concat('Record Updated Successfully = ',@@rowcount)


end

else if(@operation = 'delete')
	begin
	delete from employee where id = @id
	print concat('Record Deleted Successfully = ',@@rowcount)
	end


else if(@operation = 'select')
begin
	select * from employee

end
end try
begin catch
	print 'error occured while crud operation on employee table'
	print error_message()
	print error_number()
end catch
end

------------------------------------------------
exec sp_emp
@id = 23,
@name = 'kalpesh', 
@manager = null,
@work_loc = 'pune 4441001', 
@joining_date = '2000-04-19',
@operation = 'insert'













create proc sp_emp_details
@id int, 
@bg varchar(100), 
@address varchar(max), 
@contact_no varchar(max),
@operation varchar(100)
as
begin
begin try 
if(@operation = 'insert')
begin
	insert into emp_details values(@id,@bg,@address,@contact_no)
	print concat('Data Inserted Successfully = ',@@rowcount)

end
else if(@operation = 'update')
begin
	update emp_details set bg = @bg, address = @address, contact_no = @contact_no
	where id = @id
	print concat('Record Updated Successfully = ',@@rowcount)

end
else if(@operation = 'delete')
begin
	delete from emp_details where id = @id
	print concat('Record Deleted Successfully = ',@@rowcount)

end
else if(@operation = 'select')
begin
	select * from emp_details
end
end try
begin catch
	print 'error occured while crud operation on employee_details table'
	print error_message()
	print error_number()
end catch
end
----------------------------------------------------

exec sp_emp_details 
@id = null, 
@bg = null,
@address = null, 
@contact_no = null,
@operation = 'select'
select * from employee
select * from emp_details

--Write a SQL function to return the id of employees who don't have a manager

alter function empty_id()
returns int
as
begin
return (select t1.id
------------------------------------------,t1.name,t2.id 
from employee t1
 left join emp_details t2
on t1.manager = t2.id
where t2.id is null)
---------------------------------------return (select id from employee where manager is NULL)
end

select advance_sql.dbo.empty_id()

select * from employee



--Write a SQL query to return the employee details
--(id,name, manager, contact number)  who have joined after 20th Jan, 2019.


--insert into advance_sql.dbo.emp_details
select * from employee
select * from emp_details

SELECT e.id, e.name,e.manager,e.joining_date,ed.contact_no
from employee e
join emp_details ed
on e.manager = ed.id
where e.joining_date between '2019-01-20' and getdate()




--insert into employee values(14,'soham', null, 'jalgaon', '2000-11-30')

create table test(id int primary key, name varchar(100), manager int)
drop table test
insert into test values
(1,'yash',null),
(2,'pankaj',1),
(3,'pawan',1),
(4,'radha',2),
(5,'anwesh',8),
(6,'saurabh',8),
(7,'poonam',2),
(8,'pooja',1)

select t1.id
--,t1.name,t2.name,t2.id 
from test t1
left join test t2
on t1.manager = t2.id
where t2.id is null