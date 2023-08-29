create database advance_sql


declare @operation varchar(100)
set @operation = 'count'
declare @sql nvarchar(max)
declare @fun varchar(100) = ''

if(@operation = 'count')
set @fun = 'count(*) as Totalcount'

else if(@operation = 'avg')
set @fun = 'avg(salary) as Aveage'

else if(@operation = 'sum')
set @fun = 'sum(salary) as Totalsalary'

else
print 'Invalid operation'

set @sql = 'select dept, ' + @fun + ' from windows_fun group by dept'
print @sql

execute sp_executesql @sql

--exec(@sql)

--exec('select * from windows_fun')

---trigger--------
create trigger refuse_insert
on windows_fun
for insert
as 
begin 
 print 'cannot insert data into table'
 rollback
end

drop trigger refuse_insert
insert into windows_fun values(1200,'IT')
select * from windows_fun

create table student(id int, first_name varchar(100), last_name varchar(100), full_name varchar(100))
insert into student(id,first_name,last_name) 
values(2,'rahul','more')
select * from student

alter trigger student_name 
on student 
after insert 
as
begin 
 update student set full_name = first_name +' '+ last_name;
end;

create clustered index custom_index on student(id)

drop index  custom_index on student
