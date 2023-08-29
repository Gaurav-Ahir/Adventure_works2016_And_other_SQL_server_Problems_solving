--select second highest salary
select max(salary) from windows_fun where salary < (select max(salary) from windows_fun)

select top 1 salary from windows_fun 
where salary != (select max(salary) from windows_fun)
order by salary desc

select top 1 salary from windows_fun 
where salary not in (select distinct top 3 salary from windows_fun order by salary desc)
order by salary desc



declare @sql as varchar(max)
declare @n int 
set @n = 6
if((select count(distinct salary) from windows_fun) >= @n)
begin

set @sql = 'select top 1 salary from(
select distinct top '+cast(@n as varchar(70))+' salary from windows_fun order by salary desc
) as Nth_salary order by salary';

print @sql
exec(@sql)
end

else 
begin
	print concat(@n,' is greater than distinct salary present in table')
end
select * from windows_fun3

alter table windows_fun3 drop column new1
create unique index newindex on windows_fun(salary)

select top 1 salary from(
select distinct top 4 salary from windows_fun order by salary desc
) as Nth_salary order by salary


select * from windows_fun

with cte_second_high
as
(
select salary,dense_rank() over(order by salary desc) as denserank from windows_fun
)
select distinct salary as second_high_salary from second_high where denserank = 2
--where (select distinct dense_rank() over(order by salary desc) from windows_fun) = 2

--select duplicate values using sub query
select * from (
select salary,dept,row_number() over(partition by dept,salary order by salary,dept)
as rank_no from windows_fun
) as duplicate_records 
where rank_no > 1



--read second highest salary using sub query
select * from (
select distinct salary,DENSE_RANK() over(order by salary desc) as row_no from windows_fun
) as denserank where row_no = 2

select count(salary) as count_salary, salary, dept from windows_fun 
group by salary,dept
having count(salary) > 1

select * from windows_fun
--TOP clause & First_value function

--read first value
select salary,dept,first_VALUE(salary) over(order by salary)
as first_salary from windows_fun


with cte_win_fun
as
(
select *,row_number() over(partition by dept,salary order by salary,dept) as rank_no from windows_fun
)
select * from cte_win_fun where rank_no > 1 


select * from windows_fun

alter view vw_win_fun
as
select *,row_number() over(partition by dept,salary order by salary,dept) as rank_no from windows_fun

select salary,dept,max(rank_no) as counts from vw_win_fun
group by salary,dept
having max(rank_no) > 1

with countof
as
(
select *,row_number() over(partition by dept,salary order by salary,dept) as rank_no from windows_fun
)
select salary,dept,max(rank_no) from countof 
where rank_no > 1
group by salary,dept


select * from vw_win_fun


--create stored procedure
alter procedure sp_sample
@input varchar(100)
as
select sum(salary) as  from windows_fun where dept = @input

exec sp_sample @input = 'IT'

select dept, sum(salary), row_number() over(order by salary) from windows_fun
group by dept,salary
order by salary

select * from windows_fun
--create user defined function
alter function user_def_fun(
@a int,
@b int
)
returns int
as
begin
return @a+@b
end

select dbo.user_def_fun(1,2)


alter function salary_by_dept
(@dept varchar(100))
returns int
as
begin
return (select sum(salary) from windows_fun where dept = @dept)
end

select dbo.salary_by_dept('IT')


create proc t1
as
select * from temp
exec t1

drop procedure t1
drop table temp

create table temp(id int, name varchar(100))
create table destination_tbl(id int , name varchar(100))

insert into temp values
(100,'gaurav'),
(101,'rahul'),
(102,'ram')
insert into destination_tbl values
(100,'m')
insert into temp values(103,'M')
update temp set name = 'K' where id = 103

insert into destination_tbl(id,name) values(100,'A')




drop table destination_tbl

alter procedure sp_upsert
as
begin
--update destination_tbl table
select 1 where exists (select id from temp where id in (select id from destination_tbl))
--if((select id from temp where id in (select id from destination_tbl))is not null)
if(select 1 where exists (select id from temp where id in (select id from destination_tbl)) = 1)
begin
	print 'Record Updated'
end
else
begin
	print 'Record Not Updated'
end


update destination_tbl
set destination_tbl.name = temp.name
from destination_tbl
join temp
on destination_tbl.id = temp.id



print 'Record Updated'
--insert into destination_tbl table
if((select top 1 id from temp where id not in (select id from destination_tbl))is not null)
begin
	print 'Record inserted'
end
else
begin
	print 'Record Not Inserted'
end
insert into destination_tbl 
select * from temp where id not in (select distinct id from destination_tbl)

--truncate temp table
truncate table temp
end

exec sp_upsert

truncate table destination_tbl

select * from temp
select * from destination_tbl


select id,name from temp where id not in(select id from destination_tbl)

update [destination_tbl]
set
[name] = [n].[name]
from [destination_tbl],[temp] as [n]
where
[n].[id] = [destination_tbl].[id]

select 'gaurav' where exists (select id from temp where id = 101)

update destination_tbl 
--set destination_tbl.name = temp.name
--from temp
--inner join temp
--on destination_tbl.id = temp.id


--select t.id,t.name,d.id
--from temp t
--left join destination_tbl d
--on  t.id = d.id

declare @test1 varchar(50)
set @test1 = 'gaurav'
declare @test2 varchar(50)
set @test2 = ''''
--select @test2

declare @test3 varchar(50)
set @test3 = @test2 + @test1 + @test2
select @test3

select * from destination_tbl


declare @sql nvarchar(100)
declare @nm varchar(100)
set @nm = 'a'

set @sql = 'select * from destination_tbl where name = '+ '''' + @nm +''''

print @sql

exec(@sql)
exec sp_executesql @sql









select '''''gaurav'''''
declare @test varchar(50)
set @test = 'gaurav'
select ''''+@test+''''

select concat('''',(select concat(@test,'''')))

select concat('','gaurav')

select len(null)