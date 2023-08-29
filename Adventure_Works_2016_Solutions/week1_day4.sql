select CURRENT_TIMESTAMP
select SYSDATETIMEOFFSET()

--take differential backup using SQL query
BACKUP DATABASE emp
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\emp.bak'
WITH DIFFERENTIAL;

--add check constraint with name "age_check"
creATE table t5(age int)
alter table t5 add constraint age_check check(age>=18)
insert into t5 values(11)

--add primary key constraint with name "age_pk"
creATE table t6(age int not null)
alter table t6 add constraint age_pk primary key(age)
insert into t6 values(11)


--9) -Write a SQL query to return BusinessEntityID, EmailAddressID and only the
--name part from the emailAddress.
--table name: Person.emailAddress

select BusinessEntityID, EmailAddressID, 
SUBSTRING(EmailAddress,0,(charindex('@',EmailAddress))-1) as WithoutDomain
from Person.emailAddress
order by BusinessEntityID

--8) Write a SQL query to return the details of employee if salesOrderID = 43659 
--otherwise return employee details except salesOrderId =43659
-- table name : 

--select * from Sales.SalesOrderDetail

begin
declare @ip as int
set @ip = 43659

 -- check for @ip in the table if present or not.
if(@ip = any (select SalesOrderID from Sales.SalesOrderDetail where SalesOrderID = @ip))
begin

	select * from Sales.SalesOrderDetail where SalesOrderID = @ip

end
else
begin
	select * from Sales.SalesOrderDetail
end
end
	

