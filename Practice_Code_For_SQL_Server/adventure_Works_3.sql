select Color,sum(ListPrice) as [total list],
sum(StandardCost) as [total cost] from Production.Product
group by color

select SalesQuota, sum(SalesYTD) as [total salesYTD] from Sales.SalesPerson
group by SalesQuota

select color, sum(ListPrice) as [total list], sum(StandardCost) as [total cost]
from Production.Product
where Name like '%mountain%' and ListPrice > 0
group by color
order by color

select SalesOrderID, sum(OrderQty) as [total orders] from sales.SalesOrderDetail
group by SalesOrderID

select JobTitle, count(*) [employees in department] from HumanResources.Employee
group by JobTitle
having count(*) > 15

select d.name, min(eph.Rate) as [minimum salary],
max(eph.rate) as [highest salary],
avg(eph.rate) as [average salary],
count(edh.DepartmentID) as [no of employees]
from HumanResources.Department d
join HumanResources.EmployeeDepartmentHistory edh
on d.DepartmentID = edh.DepartmentID
join HumanResources.EmployeePayHistory eph
on edh.BusinessEntityID = eph.BusinessEntityID
group by d.name
order by d.name

select * from HumanResources.EmployeePayHistory

select count(*),avg(bonus) from sales.SalesPerson
where SalesQuota > 250000

select count(*) from HumanResources.Employee

select count(distinct jobtitle) from HumanResources.Employee

--From the following table write a query in SQL to return a moving
--average of sales, by year, for all sales territories. Return
--BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD
--as MovingAvg, and total SalesYTD as CumulativeTotal.

	select BusinessEntityID, TerritoryID,
	SalesLastYear, DATEPART(year,ModifiedDate) as [sales year],
	SalesYTD,
	avg(SalesYTD) over (order by salesytd) as [movig average],
	sum(SalesYTD) over(order by salesytd) as [commulativetotal]
	from sales.SalesPerson

select * from sales.SalesPerson

select BusinessEntityID, TerritoryID,
datepart(year, ModifiedDate) as [salesyear],
avg(SalesYTD) over (partition by(territoryid) order by datepart(year, ModifiedDate)) as [movig average],
sum(SalesYTD) over (partition by(territoryid) order by datepart(year, ModifiedDate)) as [commulative total]
from sales.SalesPerson
group by BusinessEntityID, TerritoryID, ModifiedDate,SalesYTD

select avg(distinct ListPrice) from Production.Product

select TerritoryID, avg(bonus),sum(SalesYTD) from sales.SalesPerson
group by TerritoryID

select  JobTitle ,avg(VacationHours) as [average vacation hours], 
sum(sickleavehours) as [total sick leaves]
from HumanResources.Employee
where JobTitle like 'vice president%'
group by JobTitle

select ProductID, UnitPrice, unitpricediscount,
(UnitPrice * UnitPriceDiscount) as [Discount Price]
from sales.SalesOrderDetail
where SalesOrderID = 46672 and unitpricediscount > 0.02	

--From the following table write a query in SQL to convert the 
--Name column to a char(16) column. Convert those rows if the name 
--starts with 'Long-Sleeve Logo Jersey'. Return name of the
--product and listprice.

select cast(name as char(16)) as name, ListPrice from Production.Product
where name like 'long-sleeve logo jersey%'

select p.FirstName, p.LastName, sp.SalesYTD , sp.BusinessEntityID
from person.person p
join sales.SalesPerson sp
on p.BusinessEntityID = sp.BusinessEntityID
where sp.SalesYTD like '2%'

select round(23.663,1)

select SalesYTD, CommissionPct, cast(round((SalesYTD/CommissionPct),0) as int) from sales.SalesPerson
where CommissionPct != 0