--1)
select * from cust_orders co
where orderdate = (select MAX(orderdate) from cust_orders where custid = co.custid
		group by custid)
--select * from cust_orders

--2)
select * from time_table
select * from time_table




--3)
select p.name as manu_name, m.price, m.name as product_name 
from products m 
join Manufacturers p
on m.Manufacturer = p.code
where price = (select max(price) from products s where s.Manufacturer = m.Manufacturer)

select * from Manufacturers
select * from products


--4)
--construct a list of all your employees who have names that begin with 
--a letter from the first half of the alphabet(until – m) but do not end with a vowel. 

select * from employees where first_name like '[a-m]%' and first_name not like '%[a,e,i,o,u]'

--5)
select * from phoneDirectory

select CustomerID, Cellular, Work, Home from
	(
		select customerId, Type, PhoneNumber from phoneDirectory
	)as SourceTable
pivot
	(
		max(phoneNumber) for Type in ( Cellular, Work, Home)
	)as PivotTable



--6)
select * from Inventory
select *, sum(QuantityAdjustment) over(order by inventorydate) as Inventory from inventory

--7)
select * from processLog

select case when from 
		(
			select workflow, Runstatus 
			from processLog 
			group by workflow, Runstatus
		) as SourceTable s

--8)
--Write an SQL statement that shows the current year’s sales, along with the previous year’s sales, and  
--the sales from two years ago. 

		(select datepart(year,getdate()),sum(amount) from sales)
		union
		(select datepart(year,getdate()) -1 ,sum(amount) from sales)
		union
		(select datepart(year,getdate()) -2,sum(amount) from sales) 

		select * from sales


	select  [2023], [2022], [2021] from
		(
			select year, Amount from sales
		)as SourceTable
	Pivot
		(
			sum(amount) for year in([2023], [2022], [2021])
		)as PivotTable

		




--9)
select max(IntegerValue) as SecondHighest from sampleData 
where IntegerValue < (select max(IntegerValue) as SecondHighest from sampleData )

--10)
-- Write an SQL statement that returns all rows except where the Customer
--ID is 1001 and the Amount is $50. 

select * from orders where not customerId = 1001 or amount = 50
