

with finalTable as
	(select D.Department, e.EmployeeNumber, e.EmployeeFirstName, e.EmployeeLastName,
	rank() over(partition by(d.department) order by(E.EmployeeNumber)) as theRank
	from tbldepartment d
	join tblEmployee E
	on D.Department = E.Department)

	select * from finalTable
	where theRank <= 5

--select * from tblDepartment
--select * from tblEmployee
--select * from tblTransaction

--get employees data who don't have any transaction details.
select e.* from tblEmployee e
where e.EmployeeNumber not in (select EmployeeNumber from tblTransaction)

select e.* from tblEmployee e
where not e.EmployeeNumber = any (select EmployeeNumber from tblTransaction)

select e.* from tblEmployee e
left join tblTransaction t
on e.EmployeeNumber = t.EmployeeNumber
where t.EmployeeNumber is null 

and t.DateOfTransaction >= '2014-01-01'
and t.DateOfTransaction <= '2014-12-31'


----------------------------------1------------------------------------------
-----------------------------------------------------------------------------

--select 'gaurav Ahir'
--select 7*4
--select (7-4) * 8
--select 'brewster''s sql training class'
--select 'day 1 of training',5*3

----------------------------------2------------------------------------------
-----------------------------------------------------------------------------
--Retrieve	all	rows	from	the	HumanResources.Employee	table.		Return	only	the	
--NationalIDNumber	column.
select NationalIDNumber from HumanResources.Employee

--Retrieve	all	rows	from	the	HumanResources.Employee	table.		Return	the	
--NationalIDNumber	and	JobTitle	columns.
select NationalIDNumber,JobTitle from HumanResources.Employee

--Retrieve	the	top	20	percent	of	rows	from	the	HumanResources.Employee	table.		
--Return	the	NationalIDNumber,	JobTitle	and	BirthDate	columns.
select top 20 percent NationalIDNumber, JobTitle, BirthDate from HumanResources.Employee

--Retrieve	the	top	500	rows	from	the	HumanResources.Employee	table.		Return	the	
--NationalIDNumber,	JobTitle	and	BirthDate	columns.		Give	the	NationalIDNumber	
--column	an	alias,	“SSN”,	and	the	JobTitle	column	an	alias,	“Job	Title”
select top 500 NationalIDNumber as SSN, JobTitle as [Job Title], 
BirthDate as 'Date of Birth' from HumanResources.Employee


--Return	the	top	50	percent	of	rows	and	all	columns	from	the	Sales.Customer	table.
select top 50 percent * from sales.Customer

select Name as 'Product''s Name' from Production.vProductAndDescription
select Name as [Product's Name] from Production.vProductAndDescription


--Return	the	top	400	rows	from	HumanResources.Department
select top 400 * from HumanResources.Department

--Return	all	rows	and	columns	from	the	table	named	Production.BillOfMaterials
select * from Production.BillOfMaterials

--Return	the	top	1500 rows	and	columns	from	the	view	named	
--Sales.vPersonDemographics
select top 1500 * from Sales.vPersonDemographics

----------------------------------3------------------------------------------
-------------------------------------------------------------------------------
--Return	the	FirstName	and	LastName	columns	from	Person.Person	where	the	
--FirstName	column	is	equal	to	“Mark”
select FirstName, LastName from Person.Person
where FirstName = 'mark'

--Find	the	top	100	rows	from	Production.Product	where	the	ListPrice	is	not	equal	to	
--0.00
select top 100 * from Production.Product
where ListPrice <> 0.00

--Return	all	rows	and	columns	from	the	view	HumanResources.vEmployee	where	the	
--employee’s	last	name	starts	with	a	letter	less	than	“D”
select * from HumanResources.vEmployee 
where LastName like 'd%'

--Return	all	rows	and	columns	from	Person.StateProvince	where	the	
--CountryRegionCode	column	is	equal	to	“CA”
select * from Person.StateProvince
where CountryRegionCode = 'ca'

--Return	the	FirstName	and	LastName	columns	from	the	view	
--Sales.vIndividualCustomer	where	the	LastName	is	equal	to	“Smith”.		Give	the	
--column	alias	“Customer	First	Name”	and	“Customer	Last	Name”	to	the	FirstName	
--and	LastName	columns	respectively
select FirstName as [customer first name], LastName as [customer last name]
from Sales.vIndividualCustomer
where LastName = 'smith'

--Using	the	Sales.vIndividualCustomer	view,	find	all	customers	with	a	
--CountryRegionName	equal	to	“Australia”	or	all	customers	who	have	a	
--PhoneNumberType	equal	to	“Cell”	and	an	EmailPromotion	column	value	equal	to	0.		
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

--Return	the	SalesPersonID	and	TotalDue	columns	from	Sales.SalesOrderHeader	for	
--all	sales	that	do	not	have	a	NULL	value	in	the	SalesPersonID	column	and	whose	
--TotalDue	value	exceeds	$70,000.
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

--From	the	Sales.vStoreWithDemographics	view,	return	the	Name,	AnnualSales,	
--YearOpened,	SquareFeet,	and	NumberEmployees	columns.		Give	the	SquareFeet	
--column	the	alias	“Store	Size”	and	the	NumberEmployees	column	the	alias	“Total	
--Employees”.		Return	only	those	rows	with	AnnualSales	greater	than	1,000,000	and	
--with	NumberEmployees	greater	than	or	equal	to	45.		Order	your	results by	the	
--“Store	Size”	alias	in	descending	order	and	then	by	the	“Total	Employees”	alias	in	
--descending	order.

select Name, AnnualSales, YearOpened, SquareFeet as 'store size', 
NumberEmployees as 'Total emloyees' from Sales.vStoreWithDemographics
where AnnualSales > 1000000
and NumberEmployees >= 45
order by [store size] desc, [Total emloyees] desc
 

 -----------------------------------------------------------------------------------------

 --select * from tblTransaction;

 with PivotExample as
 (select year(DateOfTransaction) as TheYear, month(DateOfTransaction) as TheMonth,
 Amount from tblTransaction)

 select TheYear,[1], [2], [3],[4], [5], [6], [7], [8], [9], [10], [11], [12] 
 from PivotExample
 pivot (sum(amount) for TheMonth in([1], [2], [3],
 [4], [5], [6], [7], [8], [9], [10], [11], [12])) as myPvt
 order by TheYear

