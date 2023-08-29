select * from Person.Person
--Create a store procedure that receives the first name of 
--the person table as input and the last name as output.

alter proc sp_FLName
@fname varchar(50),
@lname varchar(50) output
as
begin
select @lname = lastName from Person.Person
where FirstName = @fname
end

declare @lastname nvarchar(50)
exec dbo.sp_FLName 'John', @lastname out
select @lastname

select * from department
sp_rename 'department.column4','modifieddate'


--From the following tables write a query in SQL to return any 
--distinct values that are returned by both the query. 
select ProductID from production.Product
intersect	
select ProductID from Production.WorkOrder
order by ProductID

 --From the following tables write a query in SQL to return any
 --distinct values from first query that aren't also found on the 2nd query.
select ProductID from production.Product
except	
select ProductID from Production.WorkOrder
order by ProductID
 
--From the following tables write a query in SQL to fetch distinct
--businessentityid that are returned by both the specified query.
--Sort the result set by ascending order on businessentityid.
select BusinessEntityID from Person.BusinessEntityAddress
intersect	
select BusinessEntityID from Person.Person
order by BusinessEntityID

--From the following table write a query in SQL to find a total
--number of hours away from work can be calculated by adding vacation 
--time and sick leave. Sort results ascending by Total Hours Away. 
select p.FirstName, p.LastName, e.VacationHours, e.SickLeaveHours,
e.VacationHours + e.SickLeaveHours as [Total hours away]
from HumanResources.Employee e
join Person.Person p
on e.BusinessEntityID = p.BusinessEntityID

--From the following table write a query in SQL to calculate the tax 
--difference between the highest and lowest tax-rate state or province. 
select max(TaxRate) - min(TaxRate) as [tax rate difference] 
from sales.SalesTaxRate

--From the following tables write a query in SQL to calculate 
--sales targets per month for salespeople.
select p.FirstName, p.LastName, sp.SalesQuota,
sp.SalesQuota / 12 as [sales target per month]
from Sales.SalesPerson sp
join HumanResources.Employee e
on sp.BusinessEntityID = e.BusinessEntityID
join Person.Person p
on e.BusinessEntityID = p.BusinessEntityID
where sp.SalesQuota is not null

--From the following table write a query in SQL to return 
--the ID number, unit price, and the modulus (remainder)
--of dividing product prices. Convert the modulo to an integer value.
select * from sales.SalesOrderDetail

select ProductID, UnitPrice, OrderQty,
cast((UnitPrice % OrderQty) as int) as modulas from sales.SalesOrderDetail

 --From the following table write a query in SQL to select 
 --employees who have the title of Marketing Assistant and 
 --more than 41 vacation hours.
 select BusinessEntityID, LoginID, JobTitle, VacationHours
 from HumanResources.Employee
 where JobTitle like 'Marketing Assistant' 
 and VacationHours > 41

--From the following tables write a query in SQL to find all 
--rows outside a specified range of rate between 27 and 30. 
--Sort the result in ascending order on rate.
select ve.FirstName, ve.LastName, eph.Rate from HumanResources.vEmployee ve
join HumanResources.EmployeePayHistory eph
on ve.BusinessEntityID = eph.BusinessEntityID
where eph.Rate between 27 and 30

--From the follwing table write a query in SQL to retrieve rows 
--whose datetime values are between '20111212' and '20120105'.
select * from HumanResources.EmployeePayHistory
where RateChangeDate between cast('20111212' as date) and cast('20120105' as date)

--From the following tables write a query in SQL to get employees 
--with Johnson last names. Return first name and last name.
select FirstName, LastName from Person.Person
where LastName = 'Johnson'

--From the following tables write a query in SQL to 
--find stores whose name is the same name as a vendor
select s.Name from Sales.Store s
join Purchasing.Vendor v
on s.BusinessEntityID = v.BusinessEntityID
where s.Name = v.Name