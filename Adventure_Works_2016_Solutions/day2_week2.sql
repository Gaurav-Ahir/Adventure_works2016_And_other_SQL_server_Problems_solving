 --From the following table write a query in SQL to compare year-to-date
 --sales between employees. Return TerritoryName, BusinessEntityID,
 --SalesYTD, and sales of previous year i.e.PrevRepSales. 
 --Sort the result set in ascending order on territory name. 

 select TerritoryName, BusinessEntityID, SalesYTD, 
 lag(SalesYTD,1,0) over(order by salesytd) as PrevRepSales
 from sales.vSalesPerson

 --From the following tables write a query in SQL to return 
 --the hire date of the last employee in each department for 
 --the given salary (Rate). Return department, lastname, rate, 
 --hiredate, and the last value of hiredate.

 select * from HumanResources.vEmployeeDepartmentHistory
 select * from HumanResources.EmployeePayHistory
 select * from HumanResources.Employee

 select v.Department, v.LastName,
 eh.Rate, e.HireDate,
 LAST_VALUE(HireDate) over(partition by(department) order by(eh.rate))
 from HumanResources.vEmployeeDepartmentHistory v
 join HumanResources.EmployeePayHistory eh
 on v.BusinessEntityID = eh.BusinessEntityID
 join HumanResources.Employee e
 on v.BusinessEntityID = e.BusinessEntityID

--Display all the orders that had amounts that were greater than at
--least one of the orders from September 10th 2016.
select * from orders where purch_amt > (select min(purch_amt) 
from orders where order_date = '2016-09-10')

--From the following tables write a query in SQL to retrieve 
--the first and last name of each employee whose bonus in
--the SalesPerson table is 5000.
select * from Person.Person
select * from sales.SalesPerson

select FirstName, LastName from Person.Person p
join Sales.SalesPerson sp
on p.BusinessEntityID = sp.BusinessEntityID
where sp.Bonus = 5000

select FirstName, LastName from Person.Person p
join  (select BusinessEntityID, Bonus from sales.salesPerson) as Mytable
on p.BusinessEntityID = Mytable.BusinessEntityID
and Mytable.Bonus = 5000

select FirstName, LastName from Person.Person p
join  (select BusinessEntityID, Bonus from sales.salesPerson where Bonus = 5000
		) as Mytable
on p.BusinessEntityID = Mytable.BusinessEntityID


select FirstName, LastName from Person.Person p 
		where exists
		(select BusinessEntityID, Bonus from sales.salesPerson sp 
		where Bonus = 5000
		and  p.BusinessEntityID = sp.BusinessEntityID
		) 

--Return	the	BusinessEntityID and SalesYTD column from Sales.SalesPerson. Join this	
--table to the Sales.SalesTerritory table	in such	a way that every in Sales.SalesPerson	
--will be returned regardless	of whether or not they are assigned	to	a territory Also,	
--return the Name	column from	Sales.SalesTerritory. Give this	column	the	column	
--alias “Territory	Name”.

select
sp.BusinessEntityID, sp.SalesYTD, st.Name as [territory name]
from sales.SalesPerson sp
left join Sales.SalesTerritory st
on sp.TerritoryID = st.TerritoryID

select * from sales.SalesPerson
--select * from sales.SalesTerritory
select * from person.person

--Using	the	previous	example	as	your	foundation,	join	to
--the	Person.Person	table	to	return	the	sales	person’s 
--first	name	and	last	name.		Now,	only	include	those	rows	
--where	the	territory’s	name	is	either	“Northeast”	or	“Central”

select
p.FirstName, p.LastName, st.Name,sp.BusinessEntityID, sp.SalesYTD
from Person.Person p
left join Sales.SalesPerson sp
on p.BusinessEntityID = sp.BusinessEntityID
join sales.SalesTerritory st
on sp.TerritoryID = st.TerritoryID
where st.Name in('northeast','central')

--Return	the	Name	and	ListPrice	columns from	Production.Product.		For	each	product,	
--regardless	of	whether	or	not	it	has	an	assigned	ProductSubcategoryID,	return	the	
--Name	column	from	Product.ProductSubcategory	for	each	product.		Then,	return	the	
--Name	column	from	Production.ProductCategory	for	each	row.		Give	the	Name	
--column	from	Production.Product	the	alias	“ProductName”,	the	Name	column	from	
--Production.ProductSubcategory	the	alias	“ProductSubcategoryName”,	and	the	Name	
--column	from	Production.ProductCategory	the	alias	“ProductCategoryName”.		Order	
--the	results	by	the	“ProductCategoryName”	in	descending	order	and	then	the	
--“ProductSubcategoryName”	in	ascending	order.
select p.Name as ProductName, ps.name as ProductSubcategoryName, 
pc.name as ProductCategoryName,
p.ListPrice from Production.Product p
left join Production.ProductSubcategory ps
on p.ProductSubcategoryID = ps.ProductSubcategoryID
left join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID
order by ProductCategoryName desc,
ProductSubcategoryName

select * from Production.Product
select * from Production.ProductSubcategory
select * from Production.ProductCategory


select * from Person.Person
select * from Person.Password
select * from Person.EmailAddress


--Using	the	Person.Person	and	Person.Password	tables,	INNER	JOIN	the	two	tables	
--using	the	BusinessEntityID	column	and	return	the	FirstName	and	LastName	
--columns	from	Person.Person	and	then	PasswordHash	column	from	
--Person.Password
select
n.FirstName, n.LastName, d.PasswordHash, s.EmailAddress
from Person.Person n
join Person.Password d
on n.BusinessEntityID = d.BusinessEntityID
join Person.EmailAddress s
on n.BusinessEntityID = s.BusinessEntityID

--Join	the	HumanResources.Employee	and	the	
--HumanResources.EmployeeDepartmentHistory	tables	together	via	an	INNER	JOIN	
--using	the	BusinessEntityID	column.		Return	the	BusinessEntityID,	
--NationalIDNumber	and	JobTitle	columns	from	HumanResources.Employee	and	the	
--DepartmentID,	StartDate,	and	EndDate	columns	from	
--HumanResources.EmployeeDepartmentHistory

select * from HumanResources.Employee
select * from HumanResources.EmployeeDepartmentHistory

select e.BusinessEntityID, NationalIDNumber, e.JobTitle, edh.DepartmentID,
edh.StartDate, edh.EndDate
from HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory edh
on e.BusinessEntityID = edh.BusinessEntityID

select * from Production.Product where name like '%Long-Sleeve Logo Jersey%'
select * from Production.ProductModel where name like '%Long-Sleeve Logo Jersey%'


--From the following tables write a query in SQL to retrieve one instance
--of each product name whose product model is a long sleeve logo jersey, 
--and the ProductModelID numbers match between the tables.
select p.name from Production.Product p 
join Production.ProductModel pm
on p.ProductModelID = pm.ProductModelID
and pm.Name like '%Long-Sleeve Logo Jersey%'

select p.name from Production.Product p
join (select * from Production.ProductModel 
	where name like '%Long-Sleeve Logo Jersey%') as MyTable
on p.ProductModelID = MyTable.ProductModelID 

select p.name from Production.Product p
where  exists(select * from Production.ProductModel 
	where p.ProductModelID = ProductModelID 
	and name like '%Long-Sleeve Logo Jersey%')

