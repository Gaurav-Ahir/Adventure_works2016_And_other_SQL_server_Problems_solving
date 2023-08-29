--From the following table write a query in SQL to compute 
--the difference between the sales quota value for 
--the current quarter and the first and last quarter of 
--the year respectively for a given number of employees.
--Return BusinessEntityID, quarter, year, differences
--between current quarter and first and last quarter. 
--Sort the result set on BusinessEntityID, SalesYear, 
--and Quarter in ascending order.
select BusinessEntityID, datepart(quarter,QuotaDate) as TheQuarter,  
YEAR(QuotaDate) TheYear, SalesQuota,
FIRST_VALUE(SalesQuota) over(partition by businessEntityId, year(QuotaDate) order by datepart(quarter,QuotaDate)) as FirstValueDiff,
LAST_VALUE(SalesQuota) over(partition by businessEntityId, year(QuotaDate) order by datepart(quarter,QuotaDate)) as LastValueDiff
from Sales.SalesPersonQuotaHistory
order by BusinessEntityID,YEAR(QuotaDate), datepart(quarter,QuotaDate)


select * from Sales.SalesPersonQuotaHistory

 --From the following table write a query in SQL to return the statistical 
 --variance of the sales quota values for a salesperson for each quarter 
 --in a calendar year. Return quotadate, quarter, SalesQuota, and statistical 
 --variance. Order the result set in ascending order on quarter.
 select QuotaDate, DATEPART(quarter,QuotaDate),
 SalesQuota, VAR(SalesQuota) over(order by DATEPART(quarter,QuotaDate)) as StatasticalVariance
 from Sales.SalesPersonQuotaHistory
 group by QuotaDate, DATEPART(quarter,QuotaDate), SalesQuota
 order by DATEPART(QUARTER,QuotaDate)

select * from Sales.SalesPersonQuotaHistory

--From the following table write a query in SQL to return 
--the difference in sales quotas for a specific employee over 
--subsequent years. Return BusinessEntityID, year, SalesQuota, 
--and the salesquota coming in next row.
select BusinessEntityID, year(QuotaDate), SalesQuota,
LEAD(SalesQuota,1,0) over(order by year(QuotaDate)) as NextSalesQuota
from Sales.SalesPersonQuotaHistory

select * from Sales.SalesPersonQuotaHistory


--From the following query write a query in SQL to compare
--year-to-date sales between employees for specific terrotery.
--Return TerritoryName, BusinessEntityID, SalesYTD, 
--and the salesquota coming in next row. 
select TerritoryName, BusinessEntityID, 
SalesYTD, LEAD(SalesYTD,1,0) over(partition by territoryName order by salesYTD)
from sales.vSalesPerson

select * from sales.vSalesPerson
select DATEPART(quarter,getdate())
--From the following table write a query in SQL to obtain 
--the difference in sales quota values for a specified employee 
--over subsequent calendar quarters. Return year, quarter, 
--sales quota, next sales quota, and the difference in sales quota.
--Sort the result set on year and then by quarter, both in ascending order
	select year(QuotaDate) TheYear, DATEPART(quarter,QuotaDate) as TheQuarter, SalesQuota,
	lead(SalesQuota,1,0) over(order by datepart(quarter,Quotadate)) as NextSQuota,
	SalesQuota - LEAD(SalesQuota,1,0) over(order by datepart(quarter,QuotaDate)) as QuotaDiff
	from Sales.SalesPersonQuotaHistory
	order by year(QuotaDate), DATEPART(quarter,QuotaDate)

select * from Sales.SalesPersonQuotaHistory

--From the following table write a query in SQL to compute the salary
--percentile for each employee within a given department.Return Department, 
--LastName, Rate, CumeDist, and percentile rank. Sort the result set in 
--ascending order on department and descending order on rate.
select LastName, eph.Rate, 
CUME_DIST() over(partition by edh.department order by eph.rate) as CumeDist,
PERCENT_RANK() over(partition by edh.department order by eph.rate) as PercentRank
from HumanResources.vEmployeeDepartmentHistory edh
join HumanResources.EmployeePayHistory eph
on edh.BusinessEntityID = eph.BusinessEntityID
order by edh.Department,eph.Rate desc

select * from HumanResources.vEmployeeDepartmentHistory
select * from HumanResources.EmployeePayHistory

--From the following table write a query in SQL to add two days 
--to each value in the OrderDate column, to derive a new column 
--named PromisedShipDate. Return salesorderid, orderdate, 
--and promisedshipdate column.
select SalesOrderID, OrderDate, DATEADD(DAY,2,OrderDate) as PromisedShipDate 
from sales.salesorderheader

--From the following table write a query in SQL to obtain a newdateby adding two 
--days with current date for each salespersons.Filter the result set for those 
--salespersons whose sales value is more than zero.
select p.FirstName,p.LastName, 
DATEADD(day,2,GETDATE()) as NewDate
from Sales.SalesPerson sp
join Person.Person p
on sp.BusinessEntityID = p.BusinessEntityID
join Person.Address a
on p.BusinessEntityID = a.AddressID
where sp.SalesYTD <> 0


select * from Sales.SalesPerson
select * from Person.Person
select * from Person.Address

--From the following table write a query in SQL to find 
--the differences between the maximum and minimum orderdate. 
select cast(DATEDIFF(day,min(orderDate),max(OrderDate))as varchar(100)) + ' days' from Sales.SalesOrderHeader

select max(OrderDate) - min(orderDate) as DateDifference from Sales.SalesOrderHeader

--From the following table write a query in SQL to rank the products 
--in inventory, by the specified inventory locations, according to 
--their quantities. Divide the result set by LocationID and sort the
--result set on Quantity in descending order. 
select ProductID, LocationID, Quantity,
RANK() over(partition by locationId order by Quantity desc) as TheRank
from Production.ProductInventory

select * from Production.ProductInventory


--From the following table write a query in SQL to return
--the top ten employees ranked by their salary.
select top 10 BusinessEntityID, Rate,
rank() over(order by rate desc)as rankBySalary
from HumanResources.EmployeePayHistory

--From the following table write a query in SQL to divide rows 
--into four groups of employees based on their year-to-date sales. 
--Return first name, last name, group as quartile, 
--year-to-date sales, and postal code
select p.FirstName, p.LastName,
ntile(4) over(order by sp.salesYTD) as quartile,
sp.SalesYTD, a.PostalCode
from Sales.SalesPerson sp
join Person.Person p
on sp.BusinessEntityID = p.BusinessEntityID
join Person.Address a
on p.BusinessEntityID = a.AddressID

--From the following tables write a query in SQL to rank 
--the products in inventory the specified inventory locations
--according to their quantities. The result set is partitioned
--by LocationID and logically ordered by Quantity. Return
--productid, name, locationid, quantity, and rank
select pii.ProductID, p.Name, pii.LocationID,
pii.Quantity, RANK() over(partition by pii.locationId order by pii.quantity) as TheRank
from production.productinventory pii
join Production.Product p
on pii.ProductID = p.ProductID

select * from production.productinventory
select * from Production.Product

--From the following table write a query in SQL to find the salary 
--of top ten employees. Return BusinessEntityID, Rate, and rank 
--of employees by salary. 
select top 10 BusinessEntityID, Rate, 
rank() over(order by rate desc) as TheRanke
from HumanResources.EmployeePayHistory

select * from HumanResources.EmployeePayHistory

--From the following table write a query in SQL to calculate 
--a row number for the salespeople based on their year-to-date
--sales ranking. Return row number, first name, last name, 
--and year-to-date sales. 
 select
 ROW_NUMBER() over(order by salesYTD) as RowNumber,
 FirstName, LastName, SalesYTD 
 from Sales.vSalesPerson

--From the following table write a query in SQL to calculate
--row numbers for all rows between 50 to 60 inclusive. 
--Sort the result set on orderdate.
select SalesOrderID,OrderDate,RowNumber from
			(
				select *,
				ROW_NUMBER() over(order by salesOrderID) as RowNumber
				from Sales.SalesOrderHeader
			)as SourceTable
			where RowNumber between 50 and 60

--From the following table write a query in SQL to return first name, 
--last name, territoryname, salesytd, and row number. Partition the 
--query result set by the TerritoryName. Orders the rows in eachpartition 
--by SalesYTD. Sort the result set on territoryname in ascending order. 
select FirstName, LastName,
TerritoryName, SalesYTD, 
ROW_NUMBER() over(partition by territoryName order by salesYTD) as RowNumber
from sales.vSalesPerson
where TerritoryName is not null
order by TerritoryName

--From the following table write a query in SQL to order the result 
--set by the column TerritoryName when the column CountryRegionName 
--is equal to 'United States' and by CountryRegionName for all other rows.
--Return BusinessEntityID, LastName, TerritoryName, CountryRegionName.
select BusinessEntityID, LastName, TerritoryName, 
CountryRegionName
from sales.vSalesPerson
order by 
		case when CountryRegionName =  'United States'
			then TerritoryName
			else
			CountryRegionName
			end


--From the following tables write a query in SQL to return the highest
--hourly wage for each job title. Restricts the titles to those that are 
--held by men with a maximum pay rate greater than 40 dollars or women
--with a maximum pay rate greater than 42 dollars.
select JobTitle, MAX(Rate) as [Highest_Hourly_Wage] from
			(
				select top 100 percent e.JobTitle, eph.Rate
				from HumanResources.employee e
				join HumanResources.EmployeePayHistory eph
				on e.BusinessEntityID = eph.BusinessEntityID
				where (e.Gender = 'M' and eph.Rate > 40) or (e.Gender = 'F' and eph.Rate > 42) 
			) as SourceTable
		group by JobTitle
		order by Highest_Hourly_Wage desc

select * from HumanResources.employee
select * from HumanResources.EmployeePayHistory

--From the following table write a query in SQL to sort the BusinessEntityID 
--in descending order for those employees that have the SalariedFlag set to 
--'true' and in ascending order that have the SalariedFlag set to 'false'.
--Return BusinessEntityID, and SalariedFlag. 
select BusinessEntityID, SalariedFlag 
from HumanResources.Employee
order by 
		case when SalariedFlag = 1 then BusinessEntityID 
		end
	desc,
		case when salariedFlag = 0 then BusinessEntityId
		end

--From the following table write a query in SQL to display the list 
--price as a text comment based on the price range for a product. 
--Return ProductNumber, Name, and listprice. Sort the result set on 
--ProductNumber in ascending order.
select ProductNumber, Name, ListPrice,
case when ListPrice = 0 then 'mfg item- not for sale'
when ListPrice between 1 and 50 then 'ListPrice Between 1 & 50'
when ListPrice between 51 and 100 then 'ListPrice Between 51 & 100'
when ListPrice between 101 and 200 then 'ListPrice Between 101 & 200'
when ListPrice between 201 and 500 then 'ListPrice Between 201 & 500'
when ListPrice between 501 and 1000 then 'ListPrice Between 501 & 1000'
when ListPrice between 1001 and 2000 then 'ListPrice Between 1001 & 2000'
else 'ListPrice Above 2000'
end as Comment
from Production.Product
order by ProductNumber






