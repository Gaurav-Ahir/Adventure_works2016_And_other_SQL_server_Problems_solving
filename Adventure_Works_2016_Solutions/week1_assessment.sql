--1) Write a SQL query to calculate the tax percentage of tax on decided subtotal and display
--salesOrderId, customerId, orderDate, subTotal and the tax %age.
----Table name : sales.salesOrderHeader

select  SalesOrderID, CustomerID, OrderDate, SubTotal, 
((TaxAmt * 100) / SubTotal) as Tax_percentage
from sales.salesOrderHeader

--2)Write a SQL query to find the sum and average of subtotal rounded upto 2 decimal 
--places for every customer. Display the customerID, sum, average  in descending order of customerID
---- Table name : 
select * from sales.salesOrderHeader

select CustomerID, ROUND(sum(subTotal),2) as Total, ROUND(avg(subTotal),2) as Average_subTotal from sales.salesOrderHeader
group by CustomerID
order by CustomerID desc


--3)write a query in SQL to display businessentityID, lastName, TerritoryName,
--CountryRegionName and set the result in order 
--by the column TerritoryName when the column CountryRegionName is equal to 
--'United States' and by CountryRegionName for all other rows.
---- Table name : sales.vSalesPerson

select BusinessEntityID, LastName, TerritoryName, CountryRegionName from sales.vSalesPerson
order by case when(CountryRegionName = 'United States') then TerritoryName
else CountryRegionName end

--4)write a SQL query to retrieve the total due for each year ordered by year.
-- Table name : sales.salesOrderHeader
select * from sales.salesOrderHeader

select year(OrderDate) as Theyear, sum(TotalDue) as totaldue from sales.salesOrderHeader
group by year(OrderDate)
order by year(OrderDate)

--5)Write a SQL query to find the contacts who are designated as manager in various depts.
--Return the result in descending order of contactTypeID.
--Table name : Person.ContactType

select * from Person.ContactType

select ContactTypeID, name from Person.ContactType
where name like '%manager%' order by ContactTypeID desc

--6) Given a table ‘dbo.voters’, write a SQL query to add a check constraint ‘age_check’ 
--to allow values to be added where age>=18.

--select * from voters

alter table dbo.voters add constraint age_check check (age>=18)





--7) write a SQL query to get the oldest and newest orderDate per customerID ordered by customerID.
-- Table name : sales.salesOrderHeader

select CustomerID, min(OrderDate) as min_order_date, 
max(OrderDate) as max_order_date
from sales.salesOrderHeader
group by CustomerID
order by CustomerID



--8) Write a SQL query to return the details of employee if salesOrderID = 43659 
--otherwise return employee details except salesOrderId =43659
-- table name : 

select * from Sales.SalesOrderDetail

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


--9) -Write a SQL query to return BusinessEntityID, EmailAddressID and only the
--name part from the emailAddress.
--table name: Person.emailAddress

select BusinessEntityID, EmailAddressID, 
SUBSTRING(EmailAddress,0,(charindex('@',EmailAddress))-1) as WithoutDomain
from Person.emailAddress
order by BusinessEntityID

select * from Person.EmailAddress







