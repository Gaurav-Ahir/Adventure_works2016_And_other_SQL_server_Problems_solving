select count(*) from person.Person

select count(MiddleName) from person.person

--What	is	the	average	StandardCost	(located	in	Production.Product)	for	each	product	
--where	the	StandardCost	is	greater	than	$0.00?

select avg(StandardCost) from Production.Product
where StandardCost > 0.0

--What	is	the	average	Freight	amount	for	each	sale	
--(found	in	Sales.SalesOrderHeader)	
--where	the	sale	took	place	in	TerritoryID	4?

select avg(Freight) from Sales.SalesOrderHeader
where TerritoryID = 4

--How	expensive	is	the	most	expensive	product,	by	ListPrice,
--in	the	table Production.Product?

select max(listprice) from Production.Product

select sum(p.ListPrice) from Production.Product p
join Production.ProductInventory pl
on p.ProductID = pl.ProductID
where p.ListPrice > 0


select * from Production.Product
select * from Production.ProductInventory

SELECT SUM(P.ListPrice*I.Quantity)
FROM Production.Product P
INNER JOIN Production.ProductInventory I
ON I.ProductID = P.ProductID
WHERE P.ListPrice > 0

select SalesPersonID, round(sum(SubTotal),2) as total_sum 
from Sales.SalesOrderHeader
group by SalesPersonID

select PersonType,count(*) from person.person
group by PersonType

--select * from production.Product
select color,count(*) as count_of_color from production.product
where color in ('red','black')
group by color

select * from sales.SalesTerritory
select * from sales.SalesPerson

--Expanding	on	the	previous	example,	group	
--the	results	not	by	the	TerritoryID	but	by	
--the	name	of	the	territory	(found	
--in	the	Sales.SalesTerritory	table).

--select * from sales.salesorderheader
select st.Name, count(*)as countt from sales.SalesTerritory st
join sales.salesorderheader sh
on sh.TerritoryID = st.TerritoryID
--where OrderDate between '2005-01-07' and '2006-12-31'
group by st.name
order by st.name,count(sh.SalesOrderID) desc


--Find	the	total	sales	by	territory	for	all	rows in
--the	Sales.SalesOrderHeader	table. Return only those territories
--that	have	exceeded	$10	million	in	historical	sales.		
--Return	the	total	sales	and	the	TerritoryID	column

select TerritoryID, sum(TotalDue)as [total sales] from sales.SalesOrderHeader
group by TerritoryID
having sum(TotalDue) > 10000000

--Using the query from the previous question, join to
--the	Sales.SalesTerritory table and replace the TerritoryID 
--column	with	the	territory’s	name.

select st.Name, sum(soh.TotalDue)as [total sales] 
from sales.SalesOrderHeader soh
left join sales.SalesTerritory st
on soh.TerritoryID = st.TerritoryID
group by st.Name
having sum(soh.TotalDue) > 10000000

--Using	the	Production.Product	table,	find	how	many	products	
--are	associated	with each	color.		Ignore	all	rows	where	
--the	color	has	a	NULL	value.		Once	grouped,	return	
--to	the	results	only	those	colors	that	had	at	least	
--20	products	with	that color

--select * from production.product

select color, count(*) as color_count from Production.Product
where color is not null
group by color
having count(*) > 20

--Starting	with	the	Sales.SalesOrderHeader	table,	join
--to	the	Sales.SalesOrderDetail	table.		This	table	contains	
--the	line	item	details	associated	with	each	sale.From	
--Sales.SalesOrderDetail,	join	to	the	Production.Product	table.
--Return	the	Name column	from	Production.Product	and	assign	it
--the	column	alias	“Product	Name”.	For	each	product,	find 	
--out	how	many	of	each	product	was	ordered	for	all	orders	that	
--occurred	in	2006.		Only	output	those	products	where	
--at	least	200	were	ordered.
select * from production.product
select top 10 * from sales.SalesOrderHeader
select * from sales.SalesOrderDetail


select p.name,sum(OrderQty)
from sales.SalesOrderHeader soh
join sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.salesorderid
join Production.Product p
on sod.ProductID = p.ProductID
where OrderDate between '2010-01-01' and '2011-12-31'
group by p.name
having sum(OrderQty) > 200

select * from sales.SalesOrderHeader where OrderDate >'2011-01-01' and OrderDate <'2011-12-31'


--Find	the	first	and	last	name	of	each	customer	
--who	has	placed	at	least	6	orders	between	July	1,	2005	
--and	December	31,	2006.		Order	your	results	by	the	number	of	
--orders	placed	in	descending	order.		(Hint:	You	will need	to	join
--to	three	tables	–Sales.SalesOrderHeader,	Sales.Customer,
--and	Person.Person.You will use every clause	to complete this query).

select * from sales.Customer
select * from person.person
select * from Sales.SalesOrderHeader

select p.FirstName, p.LastName, count(*) from sales.Customer c
join sales.SalesOrderHeader soh
on c.CustomerID = soh.CustomerID
join person.Person p
on soh.SalesPersonID = p.BusinessEntityID
where soh.OrderDate between '2005-07-01' and '2006-12-31'
group by firstname,lastname
having count(*) > 1





