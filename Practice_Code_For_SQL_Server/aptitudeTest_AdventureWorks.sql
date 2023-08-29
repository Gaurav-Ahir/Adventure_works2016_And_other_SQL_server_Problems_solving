sp_help 'sales.SalesOrderHeader'
sp_help 'production.product'

select * from sales.SalesOrderHeader where CustomerID = 635

--1. Write a SQL function to Show OrderQty, 
--the Name and the ListPrice of the order made by CustomerID 635.

select top 10 * from sales.SalesOrderHeader
---->SalesOrderHeader,salesorderdetail,product

alter function custom_fun()
returns table
as
return (select  od.orderQty, p.name, p.ListPrice
from sales.SalesOrderDetail od
join sales.SalesOrderHeader sa
on sa.SalesOrderID = od.SalesOrderID
join production.Product p
on od.ProductID = p.ProductID
where sa.CustomerID = 29825)

select * from AdventureWorks2019.dbo.custom_fun()

--3.SQL query to return the total freight paid by each customer. return customerid and total freight. 
-->sales.salesorderheader
select * from sales.salesorderheader

sp_help 'sales.salesorderheader'

select * from sales.salesorderheader
select customerId, sum(Freight) as total_freight from sales.salesorderheader group by CustomerID

-- 2.SQL query to return only the rows from salesorderheader and 
--calculate the percentage of the tax on subtotal have decided.
--return salesorderid,customerid,orderdate,subtotal,percentage of tax column.arrange the 
--resultset in ascending order on subtotal.

select SalesOrderID, CustomerID, OrderDate, round(SubTotal,2) as subTotal, 
round(((TaxAmt*100)/SubTotal),2) as percentage_of_tax
from sales.SalesOrderHeader order by SubTotal



--4. Write a SQL stored procedure to get total quantity of each productid where you 
---provide the shelf as parameters. Sort the result according to productid in ascending order.
-->production.productinventory

select * from production.productinventory

alter proc sp_TotalQty
@shelf varchar(100)
as
begin
select ProductID, sum(Quantity) as TotalQuantity from Production.ProductInventory 
where shelf = @shelf
group by ProductID
order by ProductID
end

exec sp_TotalQty 'A'

--5. SQL query to retrieve total sales for each year. return only year of order date and total due amount.
-->sales.SalesOrderHeader
select * from sales.salesorderheader

select datepart(year,OrderDate), sum(TotalDue) as Total_due_Amount,
count(datepart(year,OrderDate)) as Total_sales_for_year
from Sales.SalesOrderHeader
group by DATEPART(year,OrderDate)

select * from INFORMATION_SCHEMA.


select @@VERSION
