create table customer_jan(id int, name varchar(50), city varchar(50))

create table customer_feb(id int, name varchar(50))

insert into customer_jan values
(1, 'gaurav ahir', 'delhi'),
(2, 'rahul more', 'delhi'),
(3, 'poonam ingale', 'kolkata'),
(4, 'akshay gupta', 'banglore'),
(5, 'abhishek patil', 'banglore'),
(6, 'akansha singh', 'pune'),
(7, 'poonam mahajan', 'surat'),
(8, 'aditya bute', 'delhi'),
(9, 'mohit chauhan', 'solapur'),
(10, 'neha singh', 'mumbai')

insert into customer_feb values
(1, 'akshay gupta'),
(2, 'heena'),
(3, 'sneha choudhary'),
(4, 'abhishek patil'),
(5, 'tushar dixit'),
(6, 'mohit chauhan'),
(7, 'akansha singh'),
(8, 'mohit chaudhari'),
(9, 'avni mukherjee'),
(10, 'poonam mahajan')

select name from customer_jan
union
select name from customer_feb

select id, name, city from customer_jan
union all
select id, name, null as city from customer_feb


select name from customer_jan
except
select name from customer_feb

select name from customer_jan
intersect
select name from customer_feb
--intersect give distinct and in ordere result

select name from customer_jan where name = any (select name from customer_feb)

select name from customer_jan where name in (select name from customer_feb)

select getdate()
select CURRENT_TIMESTAMP
select SYSDATETIME()

select DATEPART(DAY,GETDATE())
SELECT DATEDIFF(month, '2022-03-18', '2024-03-25');
select ISDATE('2022-03-18')


select ascii('g')
select concat('a','b')
select char(103)
select unicode('gaurav')

--get country from customer_jan 
select (select top 1 city from customer_jan 
group by city 
having len(city) = (select min(len(city)) from customer_jan)
order by city) as city, 
min(len(city)) as 'minimum_length' from customer_jan



select power(2,3)
select rand() * 10


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
--use of TCL commands

-------------------------rollback------------------------
begin tran a
insert into customer_feb values(15, 'vaibhav jadhav')
rollback tran a

-----------------------commit------------------------
begin tran b
insert into customer_feb values(14, 'shyam rathod')
commit tran b

---------------------------savepoint----------------------
begin tran
Save transaction a
insert into customer_feb values(15, 'ram')
Save transaction b
insert into customer_feb values(16, 'abhi')
Save transaction c
insert into customer_feb values(17, 'gauri')
rollback tran b


--------------------------------- SQL server Clauses -----------------------------------

-----------------------------------where---------------------------------------------
select * from customer_jan where city = 'mumbai'

-----------------alias, group by, having, order by clause------------------
select city, count(*) as Total_Customers 
from customer_jan 
group by city
having count(*) > 1
order by count(*)

--------------------distinct---------------------------
select distinct city from customer_jan order by city

--------------------------conditional statements-----------------------
-----------------------case when---------------------
select stud_id, stud_name, dob,
case 
when(dob >= '2000-01-01') then 'Regular student'
when(dob between '1999-01-01' and '2000-01-01') then '1 year Gap student'
when(dob between '1998-01-01' and '1999-01-01') then '2 year Gap student'
else 'more than 2 years gap student'
end as [student status]
from student

/* SQL program to print below pattern
* * * * *
* * * *
* * *
* *
*

*/

begin
	declare @temp int
	set @temp = 5
	while(@temp > 0)
	begin
		print replicate('* ',@temp)
		set @temp = @temp -1
	end
end

--SQL program to print all prime numbers till 1000
begin
	declare @result as varchar(max)
	set @result = ''
	declare @flag as int
	declare @no1 as int
	set @no1 = 2
	declare @no2 as int
	while(@no1 < 1000)
	begin
		set @no2 = 2
		set @flag = 0
		while(@no2 < @no1)
		begin
			if(@no1 % @no2 = 0)
			begin
				set @flag = 1
			end
		set @no2 = @no2 + 1
		end

		if(@flag = 0)
		begin
			set @result = (select concat(@result,concat( ' ', @no1)))
			--set @result = (select @result + ' ' + cast(@no1 as varchar(10)))
		end

		set @no1 = @no1 + 1
	end
	print @result

end


