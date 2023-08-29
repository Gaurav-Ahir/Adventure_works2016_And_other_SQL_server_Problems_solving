--display first and last name together in upper case . return length of first_name
select upper(concat(first_name,' ',last_name)) as full_name,len(FIRST_NAME) as length_of_fname from EMPLOYEES

--return employee's rounded off salary without any decimal places 
select round(salary,0) AS INTEGER_SAL from EMPLOYEES
SELECT salary,CAST(SALARY AS INTEGER) AS INTEGER_SAL FROM EMPLOYEES

--get the department_id and? total salary per department
select DEPARTMENT_ID,sum(salary) from EMPLOYEES
group by DEPARTMENT_ID

--K,S,S
SELECT DEPARTMENT_NAME,SUM(SALARY) AS TOTALSALARY FROM EMPLOYEES,DEPARTMENTS 
WHERE EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME;

--rank employees by their salaries
select EMPLOYEE_ID,SALARY,
rank() over(order by salary) as TheRank,
dense_rank() over (order by SALARY)AS EMP_RANK,
row_number() over (order by salary) as RowNumber
FROM EMPLOYEES

--get year & month of joining date of an employee
select EMPLOYEE_ID,FIRST_NAME,format(hire_date,'MM-yyyy') AS MONTH_YEAR from EMPLOYEES;
SELECT EMPLOYEE_ID,FIRST_NAME,YEAR(HIRE_DATE) AS YEAR,MONTH(HIRE_DATE) AS MONTH FROM EMPLOYEES;

SELECT EMPLOYEE_ID,FIRST_NAME,datepart(year,HIRE_DATE) AS theYEAR ,
datepart(MONTH,HIRE_DATE) AS theMONTH FROM EMPLOYEES;

--get email field value from EMPLOYEES except the domain
SELECT employee_id,
SUBSTRING ([Email], CHARINDEX([Email], '@') -8,
LEN([Email])) AS [Domain]
FROM [EMPLOYEES];
select email,charindex('@',email)  from EMPLOYEES

select email,substring(email,0,charindex('@',email)) from EMPLOYEES

SELECT LEFT(email, CHARINDEX('@', email) -1) AS WITHOUT_DOMAIN
FROM EMPLOYEES;

--find those employees whose salary falls within the range of the smallest salary and 25000
SELECT EMPLOYEE_ID,SALARY FROM EMPLOYEES 
WHERE SALARY BETWEEN (SELECT MIN(SALARY) FROM EMPLOYEES) AND 25000;

 --return salary and running total of the salary for the EMPLOYEES table
 SELECT EMPLOYEE_ID, SALARY, sum(SALARY) over(order by SALARY) as Running_sal
 FROM EMPLOYEES


 select EMPLOYEE_ID, SALARY, 
 sum(SALARY) over(order by salary) as Running_salary 
 from EMPLOYEES


select e.* from EMPLOYEES E
select * from EMPLOYEES



SELECT SUBSTRING('GAURAV AHIR',CHARINDEX('H','I'),3)

SELECT Salary FROM Employees ORDER BY Salary DESC 

SELECT CAST(SALARY AS integer) as withoutDecimal from EMPLOYEES

SELECT DEPARTMENT_ID,SUM(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID

select DEPARTMENT_ID,sum(salary) from EMPLOYEES
group by DEPARTMENT_ID

select UPPER(concat (first_name,' ',LAST_NAME)) as full_name from EMPLOYEES
select cast(salary as integer) as cs from employees

select e.*,
rank() over(order by salary) as e_rank
from EMPLOYEES e
--Write a SQL query to get year & month of joining date of an employee. 
select hire_date,year(hire_date) as Theyear,month(hire_date) as Themonth from EMPLOYEES
--Write a SQL query to get email field value from EMPLOYEES except the domain. 

select email,SUBSTRING(EMAIL,1,charindex('@',email)-1) as without_domain from EMPLOYEES

--find those employees whose salary falls within the range of the smallest salary and 25000. 
begin
declare @m as integer
set @m =(select min(salary) from EMPLOYEES)
select first_name,salary from EMPLOYEES where SALARY between @m and 25000
order by SALARY
end

select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES
group by FIRST_NAME, LAST_NAME, SALARY
having salary between min(SALARY) and 25000
order by salary

select first_name,salary from EMPLOYEES 
where SALARY between (select min(SALARY) from EMPLOYEES) and 25000
order by SALARY

--return salary and running total of the salary for the EMPLOYEES table. 
select EMPLOYEE_ID,salary,
sum(salary) over (order by salary) as sum_sal from employees

