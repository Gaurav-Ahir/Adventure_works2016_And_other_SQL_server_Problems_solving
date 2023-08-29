--1)
declare @name varchar(50)
set @name = 'Oracle'
declare @length int
set @length = 1
while(@length <= len(@name))
begin
print substring(@name,@length,1)
	 set @length = @length + 1
	 end




create function Input
(@name varchar(50))
returns char
as
begin
declare @length int
set @length = (select len(@name))
while(@length < len(@name))

	set @length = @length + 1
	 return (select substring(@name,@length,1))
end

select dbo.Input('Oracle')

--select REPLACE(1234,2,'')
--4)
select (select avg(salary) from employees) - (select avg(replace(salary,0,'')) from employees)
as salaryDifference

--5)
select UserId, count(UserId)as TotalProductPurchased 
from transaction
group by UserId


--7) a
--a.Write a SQL query to fetch records that are present in one  
--table but not in another table. 
select empid, empname, salary from employees
left join transaction 
on employees.empid = transaction.empid
where transaction.empid is null

--7)b.Write a SQL query to create a new table with data and 
--structure copied from another table 
select * into NewEmployees from employees

--8) a
select * from employees
select e1.employee_id, e1.First_Name, e1.Last_Name, e2.First_Name as ManagerName
from employees e1
join employees e2
on e1.manager_id = e2.employee_id

--9) a
--First task – Create a query to display the biggest loss, 
--and the biggest win for each customer: 
select distinct b.customerID, (select min(amount) from bet_tbl where betOutcome = 0 and customerID = b.customerID) as BiggestLoss,
(select max(amount) from bet_tbl where betOutcome = 1 and customerID = b.customerID) as BiggestWin 
from bet_tbl b

--9) b
--Second Task – Create a query to display the overall amount of win / loss for each customer: 
select distinct b.customerID, (select sum(amount) from bet_tbl where betOutcome = 0 and customerID = b.customerID) as TotalLoss,
(select sum(amount) from bet_tbl where betOutcome = 1 and customerID = b.customerID) as TotalWin 
from bet_tbl b

select * from bet_tbl

--10)
--Write a SELECT statement that retrieves the lowest two prices for each group. 
select top 2 * from Products where ProductPrice between 1 and 100
union
select top 2 * from Products where ProductPrice between 101 and 200
union
select top 2 * from Products where ProductPrice between 201 and 300 order by ProductPrice;

