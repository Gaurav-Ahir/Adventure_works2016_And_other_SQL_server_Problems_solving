--From the following tables write a query in SQL to 
--find employees of departments that start with P.
--Return first name, last name, job title. 
select p.FirstName, p.LastName, d.Name, e.JobTitle from Person.Person p
join HumanResources.Employee e
on p.BusinessEntityID = e.BusinessEntityID
join HumanResources.EmployeeDepartmentHistory edh
on e.BusinessEntityID = edh.BusinessEntityID
join HumanResources.Department d
on edh.DepartmentID = d.DepartmentID
where d.Name like 'p%'

--From the following table write a query in SQL to select
--employees who work as design engineers, tool designers,
--or marketing assistants
select p.FirstName, p.LastName, e.JobTitle from Person.Person p
join HumanResources.Employee e
on p.BusinessEntityID = e.BusinessEntityID
where JobTitle in('design engineer', 'tool designer', 'marketing assistant')

--From the following tables write a query in SQL to identify
--salesorderheadersalesreason and SalesReason tables with
--the same salesreasonid. 
select sp.SalesReasonID, soh.SalesOrderID, sp.ModifiedDate
from Sales.SalesReason sp
join sales.SalesOrderHeaderSalesReason soh
on sp.SalesReasonID = soh.SalesReasonID

--From the following table write a query in SQL to find all telephone 
--numbers that have area code 415. Returns the first name, last name,
--and phonenumber. Sort the result set in ascending order by lastname
select p1.FirstName, p1.LastName, p2.PhoneNumber 
from Person.Person p1
join Person.PersonPhone p2
on p1.BusinessEntityID = p2.BusinessEntityID
where p2.PhoneNumber like '415%'
order by p1.LastName

--From the following tables write a query in SQL to identify all 
--people with the first name 'Gail' with area codes other than 415.
--Return first name, last name, telephone number. Sort the result 
--set in ascending order on lastname
select p1.FirstName, p1.LastName, p2.PhoneNumber 
from Person.Person p1
join Person.PersonPhone p2
on p1.BusinessEntityID = p2.BusinessEntityID
where p2.PhoneNumber not like '415%' 
and p1.FirstName = 'Gail'
order by p1.LastName

--From the following tables write a query in SQL to find
--all Silver colored bicycles with a standard price under
--$400. Return ProductID, Name, Color, StandardCost. 
select ProductID, name, color, StandardCost
from Production.Product
where Color = 'silver'
and StandardCost > 400

--From the following table write a query in SQL to list all people 
--with three-letter first names ending in 'an'. Sort the result 
--set in ascending order on first name. Return first name and last name.
select FirstName, LastName 
from Person.Person
where FirstName like '_an'
order by FirstName

--From the following table wirte a query in SQL to search for
--rows with the 'green_' character in the LargePhotoFileName 
--column. Return all columns
select * from Production.ProductPhoto
where LargePhotoFileName like '%green%'

--From the following tables write a query in SQL to obtain mailing
--addresses for companies in cities that begin with PA, outside 
--the United States (US). Return AddressLine1, AddressLine2, City,
--PostalCode, CountryRegionCode.  
select a.AddressLine1, a.AddressLine2, a.City, a.PostalCode, 
sp.CountryRegionCode
from Person.Address a
join Person.StateProvince sp
on a.StateProvinceID = sp.StateProvinceID
where a.City like 'pa%' 
and sp.CountryRegionCode <> 'US'


--From the following tables write a query in SQL to return the cross
--product of BusinessEntityID and Department columns.  Go to the editor
--The following example returns the cross product of the two tables 
--Employee and Department in the AdventureWorks2019 database. 
--A list of all possible combinations of BusinessEntityID rows
--and all Department name rows are returned.
select e.BusinessEntityID, d.Name from HumanResources.Employee e
cross join HumanResources.Department d
order by e.BusinessEntityID

--From the following tables write a query in SQL to return 
--the SalesOrderNumber, ProductKey, and EnglishProductName columns.
select sod.SalesOrderID, p.ProductID, p.Name from Sales.SalesOrderDetail sod
join Production.Product p
on sod.ProductID = p.ProductID

--From the following tables write a query in SQL to retrieve the SalesOrderid. 
--A NULL is returned if no orders exist for a particular Territoryid. 
--Return territoryid, countryregioncode, and salesorderid. Results are 
--sorted by SalesOrderid, so that NULLs appear at the top. 
select st.TerritoryID, st.CountryRegionCode, soh.SalesOrderID 
from sales.SalesTerritory st
full join sales.SalesOrderHeader soh
on st.TerritoryID = soh.TerritoryID
order by soh.SalesOrderID

--From the following table write a query in SQL to return all rows
--from both joined tables but returns NULL for values that do not 
--match from the other table. Return territoryid, countryregioncode, 
--and salesorderid. Results are sorted by SalesOrderid. 
select st.TerritoryID, st.CountryRegionCode, soh.SalesOrderID
from Sales.SalesTerritory st
full join sales.SalesOrderHeader soh
on st.TerritoryID = soh.TerritoryID
order by soh.SalesOrderID

--From the following tables write a query in SQL to return
--a cross-product. Order the result set by SalesOrderid.
select st.TerritoryID, soh.SalesOrderID 
from Sales.SalesTerritory st
cross join sales.SalesOrderHeader soh
order by soh.SalesOrderID

--From the following table write a query in SQL to return 
--all customers with BirthDate values after January 1, 1970
--and the last name 'Smith'. Return businessentityid, jobtitle,
--and birthdate. Sort the result set in ascending order on birthday. 
select BusinessEntityID, JobTitle, BirthDate
from HumanResources.Employee
where BirthDate > '1970-01-01'
order by BirthDate

--From the following table write a query in SQL to return 
--the rows with different firstname values from Adam. Return 
--businessentityid, persontype, firstname, middlename,and 
--lastname. Sort the result set in ascending order on firstname.
select BusinessEntityID, PersonType, 
FirstName, MiddleName, LastName
from Person.Person
where FirstName <> 'Adam'
order by FirstName

--From the following table write a query in SQL to find the rows
--where middlename differs from NULL. Return businessentityid, 
--persontype, firstname, middlename,and lastname. Sort the result 
--set in ascending order on firstname.
select BusinessEntityID, PersonType, 
FirstName, MiddleName, LastName
from Person.Person
where MiddleName is not null
order by FirstName

--From the following table write a query in SQL to find the
--SalesPersonID, salesyear, totalsales, salesquotayear, salesquota, 
--and amt_above_or_below_quota columns. Sort the result set in
--ascending order on SalesPersonID, and SalesYear columns. 
select soh.SalesPersonID, year(soh.OrderDate), 
sq.SalesQuota, soh.am
from sales.SalesOrderHeader soh
join sales.SalesPersonQuotaHistory sq
on soh.SalesPersonID = sq.BusinessEntityID