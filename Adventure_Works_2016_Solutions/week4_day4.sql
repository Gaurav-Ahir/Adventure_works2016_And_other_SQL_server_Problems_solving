
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


--6)
select * from Inventory

select *, sum(QuantityAdjustment) over(order by InventoryDate) as Inventory 
from inventory


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


--10)
-- Write an SQL statement that returns all rows except where the Customer
--ID is 1001 and the Amount is $50. 

select * from orders where not customerId = 1001 or amount = 50

--2)
select DATEDIFF(MINUTE,strt_date,end_date) from time_table
