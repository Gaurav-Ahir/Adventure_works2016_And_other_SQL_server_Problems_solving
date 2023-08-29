----------------------------------1------------------------------------------
-----------------------------------------------------------------------------

--select 'gaurav Ahir'
--select 7*4
--select (7-4) * 8
--select 'brewster''s sql training class'
--select 'day 1 of training',5*3

----------------------------------2------------------------------------------
-----------------------------------------------------------------------------

select NationalIDNumber from HumanResources.Employee
select NationalIDNumber,JobTitle from HumanResources.Employee
select top 20 percent NationalIDNumber, JobTitle, BirthDate from HumanResources.Employee

select top 500 NationalIDNumber as SSN, JobTitle as [Job Title], 
BirthDate as 'Date of Birth' from HumanResources.Employee

select * from Sales.SalesOrderHeader where CurrencyRateID is not null

select top 50 percent * from sales.Customer

select Name as 'Product''s Name' from Production.vProductAndDescription
select Name as [Product's Name] from Production.vProductAndDescription

select top 400 * from HumanResources.Department

select * from Production.BillOfMaterials

select top 1500 * from Sales.vPersonDemographics

----------------------------------3------------------------------------------
-----------------------------------------------------------------------------

select FirstName, LastName from Person.Person
where FirstName = 'mark'

select top 100 * from Production.Product
where ListPrice <> 0.00

select * from HumanResources.vEmployee 
where LastName like 'd%'

select * from Person.StateProvince
where CountryRegionCode = 'ca'

select FirstName as [customer first name], LastName as [customer last name]
from Sales.vIndividualCustomer
where LastName = 'smith'

select * from sales.vIndividualCustomer 
where CountryRegionName = 'australia' or (PhoneNumberType = 'cell' 
and EmailPromotion = 0)

select * from HumanResources.vEmployeeDepartment
where Department in('executive','tool design','engineering')

select * from HumanResources.vEmployeeDepartment
where Department = 'executive' or
Department = 'tool design' or
Department = 'engineering'

select * from HumanResources.vEmployeeDepartment
where StartDate between '2008-07-01' and '2009-06-30'

select * from HumanResources.vEmployeeDepartment
where StartDate >= '2008-07-01' and StartDate <= '2009-06-30'

select * from Sales.vIndividualCustomer
where LastName like 'r%'

select * from Sales.vIndividualCustomer
where LastName like '%r'

select * from Sales.vIndividualCustomer
where LastName in ('lopez','martin','wood') and 
FirstName like '[c-l]%'

select * from Sales.SalesOrderHeader
where SalesPersonID is not null

select SalesPersonID, TotalDue from Sales.SalesOrderHeader
where SalesPersonID is not null
and TotalDue > 70000

----------------------------------4------------------------------------------
-----------------------------------------------------------------------------
select FirstName, LastName, JobTitle from HumanResources.vEmployeeDepartment
order by 1

select FirstName, LastName, JobTitle from HumanResources.vEmployeeDepartment
order by 1,2 desc

select FirstName, LastName, CountryRegionName from Sales.vIndividualCustomer
where CountryRegionName = 'United states' or CountryRegionName = 'france'
order by CountryRegionName

select Name, AnnualSales, YearOpened, SquareFeet as [store size], NumberEmployees
as [total employees]
from Sales.vStoreWithDemographics
where AnnualSales > 1000000 and
NumberEmployees >= 45
order by [store size] desc, [total employees] desc
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

select
sp.BusinessEntityID, sp.SalesYTD, st.Name as [territory name]
from sales.SalesPerson sp
left join Sales.SalesTerritory st
on sp.TerritoryID = st.TerritoryID

select * from sales.SalesPerson
--select * from sales.SalesTerritory
select * from person.person

select
p.FirstName, p.LastName, st.Name,sp.BusinessEntityID, sp.SalesYTD
from Person.Person p
left join Sales.SalesPerson sp
on p.BusinessEntityID = sp.BusinessEntityID
join sales.SalesTerritory st
on sp.TerritoryID = st.TerritoryID
where st.Name in('northeast','central')

select
p.name, p.ListPrice, p.ProductSubcategoryID,
psc.Name as [product subcategory name], p.Name as [product name],
pc.name as [product category name]
from Production.Product p
left join Production.ProductSubcategory psc
on p.ProductSubcategoryID = psc.ProductSubcategoryID
left join Production.ProductCategory pc
on pc.ProductCategoryID = psc.ProductCategoryID
order by [product category name] desc, [product subcategory name] asc

select * from Production.ProductSubcategory
select * from Production.Product

----------------------------------5------------------------------------------
-----------------------------------------------------------------------------
select * from Person.Person
select * from Person.Password
select * from Person.EmailAddress

select
n.FirstName, n.LastName, d.PasswordHash, s.EmailAddress
from Person.Person n
join Person.Password d
on n.BusinessEntityID = d.BusinessEntityID
join Person.EmailAddress s
on n.BusinessEntityID = s.BusinessEntityID

select *
from Sales.SalesOrderHeader

