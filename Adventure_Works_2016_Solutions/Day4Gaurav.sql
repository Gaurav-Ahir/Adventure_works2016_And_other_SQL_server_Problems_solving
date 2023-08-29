/* 1)--Execution Order : SELECT p.prodNumber,p.name,i.locId,i.quantity 
FROM ProductInventory i INNER JOIN Product p ON i.ProductId = p.ProductId 
WHERE p.name like '[ABC]%' ORDER BY productName;
Adding having, group by & distinct
*/

/*
from
inner join
on
where
group by
having
select
distinct
order by
limit
*/

/*find those employees whose salary is more than the salary of ‘Ram’. 
Return complete information about the employees.*/
select * from employees where SALARY > (select SALARY from EMPLOYEES where FIRST_NAME = 'ram');
select * from EMPLOYEES

select  t1.first_name, t2.SALARY
from EMPLOYEES t1
  join EMPLOYEES t2
on t1.SALARY = t2.SALARY
where t2.SALARY > (select SALARY from EMPLOYEES where FIRST_NAME = 'ram')

select * from EMPLOYEES
--find those employees who get second-highest salary
/*select * from EMPLOYEES where 
salary = (select distinct SALARY from EMPLOYEES order by salary desc limit 2,1);*/
select * from(
	select e.*,
	dense_rank() over (order by salary desc) as desc_sal
	from EMPLOYEES e) sec_l
	where sec_l.desc_sal = 2

/*find all those employees who work in department ID 80 or 40.
Return first name, last name, department number and department name. */
	select E.FIRST_NAME,E.LAST_NAME,D.DEPARTMENT_NAME,D.DEPARTMENT_ID FROM EMPLOYEES E
	INNER JOIN DEPARTMENTS D
	ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
	AND E.DEPARTMENT_ID IN(33,34)
	--WHERE E.DEPARTMENT_ID IN(33,34)
	ORDER BY E.FIRST_NAME

--find the first name, last name, department_id, city, and state province for each employee.
select E.FIRST_NAME,E.LAST_NAME,D.DEPARTMENT_ID,L.CITY,STATE_PROVIENCE FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID

--find the details of employees along with their job title
SELECT E.FIRST_NAME,E.LAST_NAME,E.EMAIL,E.HIRE_DATE,J.JOB_ID,E.SALARY,E.DEPARTMENT_ID,
E.PHONE_NUMBER,J.JOB_TITLE,J.MIN_SALARY,J.MAX_SALARY FROM EMPLOYEES E
INNER JOIN JOBS J
ON E.JOB_ID = J.JOB_ID

--find out which employees have or do not have a department.
--Return first name, last name, department ID, department name. 
SELECT E.FIRST_NAME,E.LAST_NAME,D.DEPARTMENT_ID,D.DEPARTMENT_NAME FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID

SELECT * FROM JOBS
select * from EMPLOYEES
SELECT * FROM DEPARTMENTS
select * from LOCATIONS


update EMPLOYEES set DEPARTMENT_ID = NULL where EMPLOYEE_ID = 101

 
 update employees set employee_id=22 where first_name = 'gaurav'
 alter table employees add primary key(employee_id)
 delete  from EMPLOYEES where EMPLOYEE_ID = 102