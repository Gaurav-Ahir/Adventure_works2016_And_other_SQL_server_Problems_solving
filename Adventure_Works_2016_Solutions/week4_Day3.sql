--5)
--We are given a transaction table that consists of transaction_id, 
--user_id, transaction_date, product_id, and quantity. We need to query 
--the number of users who purchased products on multiple days(Note that 
--a given user can purchase multiple products on a single day). 

select count(distinct userId) as NumberOfUsers from 
	(
		select t1.userId, t1.CreatedDate 
		from transactions t1
		join transactions t2
		on t1.UserId = t2.UserId
		and t1.CreatedDate <> t2.CreatedDate
	) as SourceTable
----------------------------------------------------------------------
select * from orders
	select count(distinct cust_code) as NumberOfCustomers from 
	(
		select  t1.cust_code
		from orders t1
		join orders t2
		on t1.cust_code = t2.cust_code
		and t1.ord_date <> t2.ord_date
	) as SourceTable

--------------------------------------------------------------------------------
--1)
--	 how to write sql query for the below scenario 
--I/p:ORACLE 

--O/p: 
--O 
--R 
--A 
--C 
--L 
--E
	 
alter FUNCTION dbo.Input
(
    @name varchar(50)
)
RETURNS @returntable TABLE 
(
	
	c1 char(50)
)
AS
BEGIN

declare @length int
set @length = 1
while(@length <= len(@name))
begin
    INSERT @returntable
	select substring(@name,@length,1)
	 set @length = @length + 1
end
    RETURN 
END

select * from dbo.Input('Oracle')

---------------------------------------------------------------
alter PROCEDURE sp_Sample
    @param1 varchar(50)
AS
declare @length int
set @length = 1
while(@length <= len(@param1))
begin
print substring(@param1,@length,1)
	 set @length = @length + 1
	 end

exec sp_sample @param1 = 'Oracle'


--8) b
--Create a query to display the hierarchical relationship between a certain 
--employee and his direct and indirect managers

select * from employees;

with CTE_emp_mgr
as
(
	select t1.employee_id, t1.First_Name + ' '+ t1.Last_Name as EmpName,
	case when (t1.manager_id is null) then 'No Manager' 
	else cast(t2.manager_id as varchar(50))
	end as ManagerId, 0 as HLevel
	from employees t1
	left join employees t2
	on t1.manager_id = t2.employee_id
	where t1.manager_id is null

union all

	select t3.employee_id, t3.First_Name + ' ' + t3.Last_Name as EmpName,
	cast(t3.manager_id as varchar(50))  as ManagerId, t4.HLevel + 1 as HLevel
	from employees t3
	join cte_emp_mgr as t4
	on t3.manager_id = t4.employee_id

)
select * from cte_emp_mgr


--5) Create a table employee (id - int, fname - varchar(MAX), lname - varchar(MAX),
--joining_date - date, salary - int)write a stored procedure code to do the create 
--and read operation for a table in sql. You must declare the action type and all 
--the input values as a parameter.By default set the column input values to null.
Create table employee (id int, fname varchar(MAX), 
lname varchar(MAX), joining_date date, salary int)

alter proc sp_InsertUpdateEmp
@id int = null ,
@fname varchar(MAX) = null,
@lname varchar(MAX) = null,
@joining_date date = null,
@salary int = null,
@operation varchar(50)
as
begin
	if(@operation = 'insert')
	begin
		insert into employee(id, fname, lname, joining_date, salary) values (@id, 
		@fname, @lname, @joining_date, @salary)	
	end
	else if(@operation = 'select')
	begin
		select * from employee
		
	end
	else
	print 'Incorrect Operation'
end

--exec sp_InsertUpdateEmp @operation = 'select'
exec sp_InsertUpdateEmp 
@operation = 'insert',
@id = 11 ,
@fname = 'gaurav',
@lname = 'ahir',
@joining_date = '1998-11-21',
@salary = '2000'



