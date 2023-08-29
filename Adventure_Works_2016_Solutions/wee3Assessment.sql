--how to write sql query for the below scenario 
--I/p:ORACLE 

--O/p: 
--O 
--R 
--A 
--C 
--L 
--E

select substring('gaurav',2,1)

create function Input
(@name varchar(50))
returns char
as
begin
declare @length int
set @length = 0
while(@length < len(@name))
begin
	 return select substring(@name,@length,1)
end
end

declare @name varchar(50)
exec Input @name = 'Oracle'

--We are given a table consisting of two columns, Name, and Profession.
--We need to query all the names immediately followed by the first letter
--in the profession column enclosed in parenthesis. 

select name + '(' + SUBSTRING(profession,1,1) + ')' from Table


--3)What will be the output of below qyery 

--SELECT 8 FROM TABLE1 

Answer:-it will give result as 8 till count of rows in table(in one column).

--Tina was asked to compute the average salary of all employees from
--the EMPLOYEES table she created but realized that the zero key in 
--her keyboard is not working after the result showed a very less average. 
--She wants our help in finding out the difference between miscalculated 
--average and actual average. 

--select salary from employees

We are given a transaction table that consists of transaction_id, user_id, transaction_date, product_id, and quantity. We need to query the number of users who purchased products on multiple days(Note that a given user can purchase multiple products on a single day). 

A picture containing text, screenshot, font, number

Description automatically generated 

select userId, count(*) as NumberofUsers from transaction 
group by UserId



Write a SQL query to update “project” with “P3” who is 

having project P2

update transaction set productId = 'P3'
where productId = 'P2'

a.Write a SQL query to fetch records that are present in one 

table but not in another table. 

select empid,empname,salary from employees
join transaction 
on employees.empid = transaction.empid
where transaction.empid is null



Write a SQL query to create a new table with data and 
structure copied from another table 


--Create a query to display the name of all employees, and the name of their manager.

select e1.employee_id,e1.first_name, e1.last_name,
e1.manager_id,e2.First_Name,e2.Last_Name,e2.manager_id from employees e1
join employees e2
on e1.employee_id = e2.manager_id

First task – Create a query to display the biggest loss, and the biggest win for each customer: 
select max(amount) as Biggestwin from bet_tbl
where betOutcome = 1
join
select min(amount) as BiggestLos from bet_tbl
where betOutcome = 0

select * from bet_tbl

Second Task – Create a query to display the overall amount of win / loss for each customer: 
select customerId, case when betOutcome = 1 then sum(amount)



