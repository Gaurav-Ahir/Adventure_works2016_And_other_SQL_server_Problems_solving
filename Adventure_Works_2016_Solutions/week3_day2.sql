--From the following table write a query in SQL to calculate
--the salary percentile for each employee within a given department.
--Return department, last name, rate, cumulative distribution 
--and percent rank of rate. Order the result set by ascending
--on department and descending on rate

select * from HumanResources.vEmployeeDepartmentHistory
select * from HumanResources.EmployeePayHistory

select edh.Department, edh.LastName, 
CUME_DIST() over(order by eph.rate)as cumulativeDistribution ,
eph.Rate, PERCENT_RANK() over(order by eph.rate) as PercentRank
from HumanResources.vEmployeeDepartmentHistory edh
join HumanResources.EmployeePayHistory eph
on edh.BusinessEntityID = eph.BusinessEntityID
order by edh.Department, eph.Rate desc

--From the following table write a query in SQL to return 
--the name of the product that is the least expensive in 
--a given product category. Return name, list price and 
--the first value i.e. LeastExpensive of the product.

select * from production.Product
select name,
FIRST_VALUE(name) over(order by name asc) as First_Value,
ListPrice
from production.Product p
where ListPrice = (select min(ListPrice) from Production.Product
					where productId = p.productId
					group by ProductSubcategoryID)

--From the following table write a query in SQL to return 
--the employee with the fewest number of vacation hours compared 
--to other employees with the same job title. Partitions 
--the employees by job title and apply the first value to 
--each partition independently.

select e.JobTitle, p.LastName, 
e.VacationHours, 
FIRST_VALUE(p.LastName) over(partition by e.jobTitle order by e.vacationHours)
from HumanResources.Employee e
join Person.Person p
on e.BusinessEntityID = p.BusinessEntityID

select * from HumanResources.Employee
select * from Person.Person

--From the following table write a query in SQL to return 
--the difference in sales quotas for a specific employee 
--over previous years. Returun BusinessEntityID, sales year, 
--current quota, and previous quota.
select BusinessEntityID, year(QuotaDate) as SalesYear,
SalesQuota, 
lag(SalesQuota,1,0) over(order by year(QuotaDate))as previousSalesQuota,
SalesQuota - lag(SalesQuota,1,0) over(order by year(QuotaDate))as Different
from Sales.SalesPersonQuotaHistory

select * from Sales.SalesPersonQuotaHistory

--From the following table write a query in SQL to compare 
--year-to-date sales between employees. Return TerritoryName,
--BusinessEntityID, SalesYTD, and sales of previous year 
--i.e.PrevRepSales. Sort the result set in ascending 
--order on territory name.
select TerritoryName, BusinessEntityID,
SalesYTD, lag(SalesYTD,1,0) over(order by salesYTD) as PrevYSale
from Sales.vSalesPerson

select * from Sales.vSalesPerson

--From the following tables write a query in SQL to return 
--the hire date of the last employee in each department for 
--the given salary (Rate). Return department, lastname, rate, 
--hiredate, and the last value of hiredate.
select edh.Department, edh.LastName,
eph.Rate,e.HireDate,
LAST_VALUE(e.HireDate) over(partition by edh.department order by eph.rate range between unbounded preceding and unbounded following)
from HumanResources.vEmployeeDepartmentHistory as edh
join HumanResources.EmployeePayHistory eph
on edh.BusinessEntityID = eph.BusinessEntityID
join HumanResources.Employee e
on eph.BusinessEntityID = e.BusinessEntityID

select * from HumanResources.vEmployeeDepartmentHistory
select * from HumanResources.EmployeePayHistory
select * from HumanResources.Employee

--From the following table write a query in SQL to compute 
--the difference between the sales quota value for 
--the current quarter and the first and last quarter of 
--the year respectively for a given number of employees.
--Return BusinessEntityID, quarter, year, differences
--between current quarter and first and last quarter. 
--Sort the result set on BusinessEntityID, SalesYear, 
--and Quarter in ascending order.
select BusinessEntityID,  from Sales.SalesPersonQuotaHistory

select * from Sales.SalesPersonQuotaHistory


