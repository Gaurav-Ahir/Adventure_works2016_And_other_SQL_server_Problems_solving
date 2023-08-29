--From the following table, write a SQL query to find those employees 
--who receive a higher salary than the employee with ID 163. 
--Return first name, last name.
select * from employees where 
salary > (select salary from employees where employee_id = 110)

--From the following table, write a SQL query to find out which 
--employees have the same department as the employee whose ID is 109. 
--Return first name, last name, department ID and job ID
select first_name, last_name, department_id from employees
where department_id = (select department_id from employees where employee_id = 109)


--From the following table, write a SQL query to find 
--those employees who earn the highest salary in a department.
--Return department ID, employee name, and salary. 
 
 select department_id, max(salary) from employees group by department_id

select  e.first_name, e.last_name, e.department_id, e.salary as salary 
	from employees e
	join (select department_id ,max(salary) as salary
		from employees
		group by department_id) as MyTable
	on e.department_id = MyTable.department_id
	where e.salary = MyTable.salary
	order by e.department_id

--From the following table, write a SQL query to find the departments 
--managed by Susan. Return all the fields of departments.
select * from departments
select * from employees

select d.department_id, d.department_name, mytable.mana 
from departments d
join ()


select * from departments
select * from employees
 select department_id, max(salary) from employees group by department_id
 --get department column upto

 declare @Result as varchar(500)
 set @Result = ''
 declare @Columns as varchar(200)
 set @Columns = ''
  select @Columns = @Columns + '['+ cast(department_id as varchar(50)) +'],'
  from employees group by department_id

  set @Columns = SUBSTRING(@Columns,0,len(@columns))
 -- print @columns
 set @Result = 
 'select ''EmpAverageSalary'' as DepartmentId, ' + @Columns + 
 ' from (select department_id, salary 
		from employees) as SourceTable
 pivot
	(
	avg(salary) for department_id in( '+ @Columns + ' )
	) as PivotTable'

exec(@result)




--From the following table, create a view to find the salespersons who 
--modefied date either August 17th, 2012 or October 10th, 2012. 
--Return salesperson ID, order quantity and customer ID.

select * from Sales.SalesOrderDetail

alter view vw_Salespersons
as 
select SalesOrderID, OrderQty as orderQuantity, 
LineTotal as total from Sales.SalesOrderDetail
where ModifiedDate = '2012-08-17'
or ModifiedDate = '2012-10-10'

select * from vw_Salespersons

--From the following table, create a view to find the salespeople 
--who placed orders on October 10th, 2012. Return all the fields of salesperson.
create view vw_
select * from sales.SalesPerson











