--1) write a query in SQL to calculate the salary percentile for each employee
--within a given department. 
--Return department, last name, rate,  and percent rank of rate.
--Order the result set by ascending on department and descending on rate.

--Tablename : HumanResources.vEmployeeDepartmentHistory, HumanResources.EmployeePayHistory
select * from HumanResources.vEmployeeDepartmentHistory
select * from HumanResources.EmployeePayHistory

select edh.Department, edh.LastName, eph.rate ,
PERCENT_RANK() over(order by(eph.rate)) as PercentRank
from HumanResources.vEmployeeDepartmentHistory edh
join HumanResources.EmployeePayHistory eph
on edh.BusinessEntityID = eph.BusinessEntityID
order by edh.Department, eph.rate


--2) write a query in SQL to add two days to each value in the
--OrderDate column, to derive a new column named PromisedShipDate. 
--Return salesorderid, orderdate, and promisedshipdate column.

--Tablename : 
--select * from Sales.SalesOrderHeader
--select SalesOrderID, OrderDate, DATEADD(day(2),orderDate) as promisedshipdate 
--from Sales.SalesOrderHeader


--3) write a query in SQL to rank the products in inventory the
--specified inventory locations according to their quantities 
--partitioned by LocationID and ordered by Quantity. 
--Return productid, name, locationid, quantity, and rank.

--Tablename: production.productioninventory, production.Product
select * from production.ProductInventory
select * from production.Product


create proc sp_TheRank
@LocationID1 int,
@LocationID2 int
as
begin
select ProductID, LocationID, Quantity, TheRank
	from
	(
		select pii.ProductID, p.Name, pii.LocationID, pii.Quantity,
		rank() over(partition by(pii.locationId) order by(pii.quantity)) as TheRank
		from production.ProductInventory pii
		join production.Product p
		on pii.ProductID = p.ProductID
	) SourceTable
	where LocationID between @LocationID1 and @LocationID2
end

exec sp_TheRank 1,100

--4) write a query in SQL to calculate sales targets per month for salespeople.
--return salespersonid, their fullname, salesquota and sales 
--targets per month for salespeople. 
--Tablename : sales.salesPerson, Humanresources.employee, Person.person
select * from sales.salesPerson
select * from Humanresources.employee
select * from Person.person

select sp.BusinessEntityID, 
p.FirstName + ' ' + p.MiddleName + ' ' + p.LastName,
sp.SalesQuota, month(sp.ModifiedDate) as PerMonthSalesQuota,
sum(SalesQuota) as MonthlySalesQupta
from sales.salesPerson sp
join Humanresources.employee e
on sp.BusinessEntityID = e.BusinessEntityID
join Person.person p
on e.BusinessEntityID = p.BusinessEntityID
group by sp.BusinessEntityID, p.FirstName + ' ' + p.MiddleName + ' ' + p.LastName,
month(sp.ModifiedDate),sp.SalesQuota


--5) Create a table employee (id - int, fname - varchar(MAX), 
--lname - varchar(MAX), joining_date - date, salary - int)
--write a stored procedure code to do the create and read 
--operation for a table in sql. You must declare the action type 
--and all the input values as a parameter.
--By default set the column input values to null.
Create table employee (id int, fname varchar(MAX), 
lname varchar(MAX), joining_date date, salary int)

create proc NewTable
@id int ,
@fname varchar(MAX),
@lname varchar(MAX),
@joining_date date,
@salary int,
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

exec NewTable @operation = 'select'

--6) Now create a log table which will have ID, 
--operation type, empId, modifiedTime as columns. 
--Write a trigger that will automatically update this 
--log table as soon as any insert operation is performed 
--in the employee table created above.
select * from employee
create table LogTable(id int, OperationType varchar(100), empId int,
ModifiedTime date)

create trigger TR_AfterInsertEmployee
on dbo.employee
for insert
as 
begin
	insert into LogTable values((select id from inserted),
	('insert', ,GETDATE())
	)
	
end


--7). Write a SQL query to find those employees whose salary matches
--the lowest salary of any of the departments. 
--Return first name, last name and department ID.
-- Table name : HR.Employees

select first_name, last_name, department_id, salary 
from dbo.employees where salary in
(select min(salary) from dbo.employees
group by department_id)