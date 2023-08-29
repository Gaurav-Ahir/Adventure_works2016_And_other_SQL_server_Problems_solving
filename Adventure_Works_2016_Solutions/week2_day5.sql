
select * from sys.dm_exec_sessions

select is_user_process , original_login_name from sys.dm_exec_sessions
order by login_time desc

alter trigger TR_LogonTrigger
on all server
for logon
as
begin
	declare @loginName nvarchar(50)
	set @loginName = ORIGINAL_LOGIN()
	if((select count(*) from sys.dm_exec_sessions
		where is_user_process = 1
		and original_login_name = @loginName) > 3)
	begin
		print 'Login attempt made by ' + @loginName
		--rollback;
	end
end
--drop trigger TR_LogonTrigger
drop trigger hr.dbo.TR_DDLTRIGGER
alter trigger TR_DDLTRIGGER
on database
for create_table, alter_table, drop_table
as
begin
	print 'CREATE|ALTER|DROP TABLE REQUEST MADE IN HR database'
	--rollback
end

create table tbl1(id int)

--2) write a query in SQL to add two days to each value in the
--OrderDate column, to derive a new column named PromisedShipDate. 
--Return salesorderid, orderdate, and promisedshipdate column.

--Tablename : 
select * from Sales.SalesOrderHeader
select SalesOrderID, OrderDate, DATEADD(day,2,orderDate) as promisedshipdate 
from Sales.SalesOrderHeader

CREATE TABLE [SSIS_Demo_Table] (
    [employee_id] varchar(50),
    [first_name] varchar(50),
    [last_name] varchar(50),
    [email] varchar(50),
    [phone_number] varchar(50),
    [hire_date] varchar(50),
    [job_id] varchar(50),
    [salary] varchar(50),
    [manager_id] varchar(50),
    [department_id] varchar(50)
)

select * from SSIS_Demo_Table

