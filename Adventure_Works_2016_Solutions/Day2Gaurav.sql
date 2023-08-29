--details of the Employee whose FIRST_NAME starts with ‘G’ and contains six alphabets
select FIRST_NAME from EMPLOYEES where FIRST_NAME like 'G_____'

--employees where hire_date is in between 08/10/2017 and 01/10/2023 in descending order. 
select * from EMPLOYEES WHERE HIRE_DATE BETWEEN '08-10-2017' AND '01-10-23' ORDER BY EMPLOYEE_ID DESC

--details from DEPARTMENT where department_ids are 102,103,109 
SELECT * FROM DEPARTMENTS WHERE DEPARTMENT_ID IN(33,34,35)

--fetch unique department_name from DEPARTMENT table. 
SELECT DISTINCT DEPARTMENT_NAME FROM DEPARTMENTS 

--get the employees having avg salary  is greater 2500
SELECT EMPLOYEE_ID,concat(FIRST_NAME,' ',LAST_NAME) as emp_name,AVG(salary) as avg_salary
FROM employees
GROUP BY EMPLOYEE_ID,FIRST_NAME,LAST_NAME
HAVING AVG(salary) > 2500
SELECT * FROM EMPLOYEES
--fetch common records between two tables. 
SELECT DEPARTMENT_ID FROM EMPLOYEES
INTERSECT
SELECT DEPARTMENT_ID FROM DEPARTMENTS

--check and print department_name if department_id = 33 else print null. 
SELECT * FROM DEPARTMENTS

select DEPARTMENT_ID, 
case when(DEPARTMENT_ID = 33) then DEPARTMENT_NAME
else null
end
from DEPARTMENTS


BEGIN
DECLARE @x int
SET @x = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = 33)
IF (@x=33)
	SELECT DEPARTMENT_NAME FROM DEPARTMENTS WHERE DEPARTMENT_ID = @x
ELSE
PRINT NULL
END




--get no of employees joining per year.
SELECT year(HIRE_DATE) as 'TheYear', COUNT(HIRE_DATE) as 'no of employees joining per year' 
FROM EMPLOYEES
GROUP BY year(HIRE_DATE);	


SELECT LOCATION_ID, STATE_PROVIENCE,
CASE WHEN STATE_PROVIENCE = 'MAHARASHTRA' THEN 'MH' 
WHEN STATE_PROVIENCE = 'UTTAR PRADESH' THEN 'UP'
end AS STATE_PROVINCE
FROM LOCATIONS
--fetch location_id,state_province as MH for Maharashtra ,UP for Uttar Pradesh. 
use HR_MGMT

SELECT CONCAT('GAURAV' , 'AHIR')as my_name;

SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID is NULL
SELECT * FROM EMPLOYEES

UPDATE EMPLOYEES SET HIRE_DATE = '2017-10-10' WHERE HIRE_DATE = '2017-12-10'
INSERT INTO LOCATIONS VALUES(10,'DSD_CHOWK',443402,'JALGAON','MAHARASHTRA')

INSERT INTO LOCATIONS VALUES
(1,'GANDHI_CHOWK',400110,'PUNE','MAHARASHTRA'),
(2,'KARVE_NAGAR',400132,'NAGAR','MAHARASHTRA'),
(3,'KARVE_NAGAR',400132,'PUNE','MAHARASHTRA'),
(4,'NEHRU_ROAD',433422,'MUMBAI','MAHARASHTRA'),
(5,'NEHRU_ROAD',433422,'MUMBAI','MAHARASHTRA'),
(6,'PANCHVATI_NAGAR',402134,'AMARAVATI','MAHARASHTRA'),
(7,'PANCHVATI_NAGAR',402134,'AMARAVATI',	'MAHARASHTRA'),
(8,'	PANCHVATI_NAGAR',	353632,'BEED','MAHARASHTRA'),
(9,'PHULE_NAGAR',	'364533'	,'LATUR',	'MAHARASHTRA'),
(10,'DSD_CHOWK',443402,'JALGAON','MAHARASHTRA')

INSERT INTO JOBS VALUES
('AM','ASSISTANT_MANAGER',75,212),
('CEO','CEO',12,43),
('CO','CODER',44,32),
('DAA','DATA_ANALYST',44,32),
('DI','dev',21,34),
('GET','TRAINEE_ENGINEER',453,4353),
('HR','HR',44,32),
('M','MANAGER',3,87),
('SE','SOFTWARE_ENGG',44,32),
('TR','TRAINEE',2,74)

INSERT INTO EMPLOYEES VALUES
(101,'rahul','sawale','GAURAV@ROCK.COM','2017-09-10','DI',43543.00,33,454),
(102,'rahul','sawale','GAURAV@ROCK.COM','2017-10-10','DI',43543.00,33,454),
(103,'GAURAV','AHIR','GA@ROCK.COM','2017-11-10','DI',43543.00,34,454),
(104,'SHREYASH','MORE','SM@ROCK.COM','2017-12-10','DI',43543.00,35,454),
(105,'SAKSHI','GHARAT','SG@ROCK.COM','2023-02-01','GET',4234.00,36,86),
(107,'KALPESH','PATIL','KP@ROCK.COM','2023-02-01','DAA',34.00,34,87),
(108,'ROSHAN','PATIL','RP@ROCK.COM','2023-02-01','M',40.00,33,234),
(110,'SACHIN','SABALE','SB@ROCK.COM','2023-02-01','GET',41.00,33,200),
(111,'ABHI','KAMBALE','AK@ROCK.COM','2023-02-01','GET',42.00,34,200),
(112,'ANWESH','MAHAJAN','AM@ROCK.COM','2023-02-01','CEO',43.00,35,231),
(543,'rahul','sawale','GAURAV@ROCK.COM','2023-02-01','DI',43543.35,33,454)

INSERT INTO DEPARTMENTS VALUES
(33,'SALES',1),
(34,'SALES',2),
(35,'SUPPORT',3),
(36,'MARKTING',4)

select * from LOCATIONS
select location_id, STATE_PROVIENCE from LOCATIONS 
join LOCATIONS  
on LOCATION_ID = LOCATION_ID
Select case when avg(salary) > 2500 then avg(SALARY) end from employees
select * from employees having (Select avg(salary) from employees) > 2500; 

select SUBSTRING('abcd efgh ijkl',3,4);
select ascii('Z')
help concat;
select REPLACE(first_name,'roshan','kishor')as first_name from EMPLOYEES
select * from EMPLOYEES where not DEPARTMENT_ID is null and EMPLOYEE_ID = 101

--fetch location_id,state_province as MH for Maharashtra ,UP for Uttar Pradesh. 
select LOCATION_ID,state_provience, case when state_provience = 'maharashtra' then 'mh' 
when state_provience = 'uttar pradesh' then 'up' end as sp from LOCATIONS

--Write a SQL query to get no of employees joining per year. 
select HIRE_DATE,COUNT(HIRE_DATE) as joinperyear from EMPLOYEES
group by HIRE_DATE
--Write a SQL query to get the employees having avg salary  is greater 25000. 
select employee_id,first_name,last_name,salary,avg(salary) as avgs
from EMPLOYEES
group by EMPLOYEE_ID,FIRST_NAME,LAST_NAME,salary
having avg(salary) > 25000

select * from EMPLOYEES

select employee_id,first_name,last_name,SALARY
from EMPLOYEES where SALARY > 25000

--Write a SQL query to fetch location_id,state_province as MH for Maharashtra ,UP for Uttar Pradesh. 
select LOCATION_ID,STATE_PROVIENCE,case when STATE_PROVIENCE = 'maharashtra' then 'mh'
when STATE_PROVIENCE = 'uttar pradesh' then 'up' end as ns
from LOCATIONS

select * from LOCATIONS