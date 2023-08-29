--1) Write a SQL query to calculate the tax percentage of tax on decided subtotal 
--and display salesOrderId, customerId, orderDate, subTotal and the tax %age.
--Table name : sales.salesOrderHeader

alter function Cal_tax(@TaxAmt money, @SubTotal money)
returns smallmoney
as
begin
return ((@TaxAmt * 100) / @SubTotal)
end
--select dbo.cal_tax(22,22)

select SalesOrderID, CustomerID, OrderDate, SubTotal, 
AdventureWorks2016.dbo.Cal_tax(TaxAmt, SubTotal) as Tax_Percentage from sales.SalesOrderHeader


--8) Write a SQL query to return the details of employee if 
--salesOrderID = 43659 otherwise return employee details except salesOrderId =43659
-- table name : 
select * from Sales.SalesOrderDetail


----------------------------multi statement table function-------------------------	
CREATE FUNCTION dbo.udf_SalesOrderD
(
    @SalesOrderID int
)
RETURNS @TempTable TABLE 
(
	salesOrderID int,
	SalesOrderDetailsID int,
	CarrierTrackingNumber varchar(50),
	OrderQty int,
	ProductID int,
	SpecialOfferID int,
	UnitPrice  float,
	UnitPriceDiscount float,
	LineTotal float,
	rowguid varchar(100),
	ModifiedDate date
)
AS
BEGIN
if(@SalesOrderID = any (select SalesOrderID from sales.SalesOrderDetail))
		begin
			 insert into @TempTable select * from Sales.SalesOrderDetail where SalesOrderID = @SalesOrderId
		end

		else
		begin
			 insert into @TempTable select * from sales.SalesOrderDetail
		end
	
	return
END


select * from dbo.udf_SalesOrderD(436597)


CREATE FUNCTION dbo.udf_Emp_Details
(
    @SalesOrderID int
)
RETURNS TABLE AS RETURN
(
    SELECT * from sales.SalesOrderDetail where SalesOrderID = @SalesOrderID
)
--drop function dbo.udf_Emp_Details

------------------------------------Inline Table Function--------------------------------

--Write a SQL query to find the sum and average of subtotal rounded upto 2 decimal places
--for perticular customer. Display the customerID, sum, average
-- Table name : 
select * from sales.salesOrderHeader

create function udf_SumAvg (@CustomerId int)
returns table
as 
return(
select top 100 percent CustomerID, ROUND(sum(subTotal),2) as Total, 
ROUND(avg(subTotal),2) as Average_subTotal from sales.salesOrderHeader
where CustomerID = @CustomerID
group by CustomerID)

select * from dbo.udf_SumAvg(29734)



----------------------------------stored Procedure---------------------------------------

alter PROCEDURE dbo.SalesOrderDetails @SalesOrderId int
AS
begin
if(@SalesOrderId = any (select SalesOrderID from Sales.SalesOrderDetail where SalesOrderID = @SalesOrderId))
begin

	 select * from Sales.SalesOrderDetail where SalesOrderID = @SalesOrderId

end
else
begin
	 select * from Sales.SalesOrderDetail
end
end

exec SalesOrderDetails 43659


---------------------------------------------------------------------------------


--Write a SQL stored procedure to get total quantity of each productid where you 
---provide the shelf as parameters. Sort the result according to productid in ascending order.
-->production.productinventory

select * from production.productinventory

create proc sp_TotalQty
@shelf char(50)
as
begin
	select ProductID, sum(Quantity) as Tolal_Quantity from Production.ProductInventory
	where Shelf = @shelf
	group by ProductID
end

exec sp_TotalQty 'A'

 --From the following table write a query in SQL to return 
 --the name of the product that is the least expensive in
 --a given product category. Return name, list price and the 
 --first value i.e. LeastExpensive of the product.

 select * from Production.Product

  select name, min(ListPrice) as Min_price, 
  FIRST_VALUE(name) over(order by name) as First_Value
  from Production.Product
  group by name

  --From the following table write a query in SQL to return 
  --the employee with the fewest number of vacation hours compared
  --to other employees with the same job title. Partitions the employees
  --by job title and apply the first value to each partition independently

  select * from Person.Person
  select * from HumanResources.Employee

  select e.JobTitle, p.LastName ,min(e.VacationHours) as Least_Vacation_Hours,
  FIRST_VALUE(p.LastName) over(partition by(e.jobtitle) order by e.jobtitle) as First_Value
  from Person.Person p
  join HumanResources.Employee e
  on p.BusinessEntityID = e.BusinessEntityID
  group by e.JobTitle, p.LastName

--From the following table write a query in SQL to return the difference
--in sales quotas for a specific employee over previous years. Returun 
--BusinessEntityID, sales year, current quota, and previous quota.  

--Sample table: 
select * from Sales.SalesPersonQuotaHistory

select BusinessEntityID, year(QuotaDate) as Sales_Year,
sum(SalesQuota) as current_quota,
lag(sum(SalesQuota),1) over(partition by(year(QuotaDate)) order by year(QuotaDate))
as Last_Quota
from Sales.SalesPersonQuotaHistory
group by BusinessEntityID, year(QuotaDate)