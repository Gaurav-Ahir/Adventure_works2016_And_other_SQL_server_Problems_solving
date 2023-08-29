
set identity_insert departments on

insert into dbo.dept values(14, 'Admin', 'pune', 'Pawan')

create Table Operation_Details(id int, ExtraDetail varchar(200))
------------------------------------------------------------------------------------------------------
---------------------------------After Insert Trigger----------------------------------------------
alter trigger TR_After_Insert_dept
on dbo.dept
for insert
as
begin
		declare @id int
		select @id = departmentid from  inserted
		insert into Operation_Details values(@id, 'department ID ' + cast(@id as varchar(10))+ ' is inserted on ' + cast(GETDATE()as varchar(50)))
end

select * from dept
select * from Operation_Details


select * from hr.dbo.jobs


-------------------------------------------------------------------------------------------------------
---------------------------------implement PIVOT command using dynamic columns------------------------

	declare @columns as varchar(500)
	set @columns = ''
	select @columns =  @columns + '[' + job_title + '],' from jobs
	set @columns = SUBSTRING(@columns, 0, len(@columns))
	--print @columns
	declare @Result as varchar(max)
	set @Result = 'select ''MinAverageSalary'' as jobtitle,' + @columns + ' from 
	(select job_title, min_salary from jobs) as SourceTable
	pivot
		(
			avg(min_salary) for [job_title] in(' + @columns + ' )
		) AS PivotTable'
	print(@result)



--select job_title,min_salary, max_salary from jobs


--creating trigger for instead of insert
select * from student
insert into student values(4,'vishvjeet', 'ahir', null)

alter trigger TR_Instead_Insert
on dbo.student
instead of insert
as
begin 
insert into student values(4,'vishvjeet', 'ahir', null)
end


update dept set departmenteahd = null, departmentname = 'Security' where departmentid = 1


--------------------instead of update trigger----------------------------------------------
alter trigger TR_Instead_Update
on dbo.dept
instead of update
as
begin
declare @depthd varchar(50)
select @depthd = departmenteahd from inserted
if(@depthd is null)
begin
	set @depthd = 'Suraj'
end

update dept set departmenteahd = @depthd, 
departmentname = (select departmentname from inserted) 
where departmentid = (select departmentid from inserted)

end

drop trigger TR_Instead_Update

select * from dbo.dept
-----------------------------------------------------------------------------------------------------------
----------------------------------Instead of Update TRIGGER-------------------------------------------
update dbo.dept set departmenteahd = 'Pravin' where departmentname = 'Security'
alter trigger TR_instead_Update_Dept
on dbo.dept
instead of update
as
begin
	if(UPDATE(departmentid))
	begin
		print 'PK_department id can not be update'
	end
	else if(UPDATE(location))
	begin
		update dbo.dept set location = (select location from inserted)
		where departmentid = (select departmentid from inserted)
	end
	else if(UPDATE(departmentname))
	begin
		update dbo.dept set location = (select location from inserted)
		where departmentname = (select departmentname from inserted)
	end
	else if(UPDATE(departmenteahd))
	begin
		update dbo.dept set departmenteahd = (select departmenteahd from inserted)
		where departmentname = (select departmentname from inserted)
	end
end
----------------------------------------------------------------------------------
--------------------------------VIEW for PIVOT command-----------------------------------
create view vw_PivotTable
as
	select 'MinAverageSalary' as jobtitle,
	[Public Accountant],[Accounting Manager],
	[Administration Assistant],[President],
	[Administration Vice President],[Accountant],
	[Finance Manager],[Human Resources Representative],
	[Programmer],[Marketing Manager],
	[Marketing Representative],
	[Public Relations Representative],
	[Purchasing Clerk],[Purchasing Manager],
	[Sales Manager],[Sales Representative],
	[Shipping Clerk],[Stock Clerk],[Stock Manager]
	from 
	(select job_title, min_salary from jobs) as SourceTable
	pivot
		(
			avg(min_salary) 
			for [job_title] 
			in(	[Public Accountant],[Accounting Manager],
				[Administration Assistant],[President],
				[Administration Vice President],[Accountant],
				[Finance Manager],[Human Resources Representative],
				[Programmer],[Marketing Manager],
				[Marketing Representative],
				[Public Relations Representative],
				[Purchasing Clerk],[Purchasing Manager],
				[Sales Manager],[Sales Representative],
				[Shipping Clerk],[Stock Clerk],[Stock Manager] )
		) AS PivotTable
-----------------------------------UNPIVOT command------------------------------------------------------

		select jobtitle, minAverageSalary
			from
			(select 
				[Public Accountant],[Accounting Manager],
				[Administration Assistant],[President],
				[Administration Vice President],[Accountant],
				[Finance Manager],[Human Resources Representative],
				[Programmer],[Marketing Manager],
				[Marketing Representative],
				[Public Relations Representative],
				[Purchasing Clerk],[Purchasing Manager],
				[Sales Manager],[Sales Representative],
				[Shipping Clerk],[Stock Clerk],[Stock Manager] 
			from vw_PivotTable) as SourceTable
		UNPIVOT
			(
				minAverageSalary for jobtitle
				in(  
					[Public Accountant],[Accounting Manager],
					[Administration Assistant],[President],
					[Administration Vice President],[Accountant],
					[Finance Manager],[Human Resources Representative],
					[Programmer],[Marketing Manager],
					[Marketing Representative],
					[Public Relations Representative],
					[Purchasing Clerk],[Purchasing Manager],
					[Sales Manager],[Sales Representative],
					[Shipping Clerk],[Stock Clerk],
					[Stock Manager] )
			) as UnPivotTable


---------------------------------------------------------------------------------------------
--select * from employees
alter view vw_TotalSalaryByDept
as
select 'TotalSalary' as departmentId, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10],[11]
	from(
			select department_id, salary from employees
		) as SourceTable
	PIVOT
		(
			sum(salary) for department_id in ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11])
		) as PivitTable

--------------------------------------------------------------------------------------------------------
--select * from vw_TotalSalaryByDept
select departmentId, TotalSalary
from (
		select  [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11]
		from vw_TotalSalaryByDept
	)as SourceTable
UNPIVOT
	(
		Totalsalary for departmentID in ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11])
	)as PivotTable

----------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

select * from sys.dm_exec_sessions

select is_user_process , original_login_name from sys.dm_exec_sessions
order by login_time desc

alter trigger TR_LogonTrigger
on all server
for logon
as
begin
	declare @loginName nvarchar(50)
	set @loginName = ORIGINAL_LOGIN()
	if((select count(*) from sys.dm_exec_sessions
		where is_user_process = 1
		and original_login_name = @loginName) > 3)
	begin
		print 'Login attempt made by ' + @loginName
		--rollback;
	end
end
--drop trigger TR_LogonTrigger

create trigger TR_DDLTRIGGER
on database
for create_table, alter_table, drop_table
as
begin
	print 'CREATE|ALTER|DROP TABLE REQUEST MADE IN HR database'
	rollback;
end

create table tbl1(id int)








