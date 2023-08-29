-- CREATE DATABASE EMP; 
/*
this is 
test comment
*/
--
--CREATE SCHEMA EMP; 
--<datanase>.<schema>.<object>


--CREATE TABLE EMP.EMP.EMPLOYEE
--(
--emp_id int,
--emp_nm varchar(100),
--emp_sal int,
--dept_id int,
--loc_id int
--)

--INSERT INTO EMP.EMP.EMPLOYEE
--VALUES(1000,'A',20,10,100);

--UPDATE EMP.EMP.EMPLOYEE
--SET emp_sal = emp_sal * 1.1
--WHERE emp_sal < 50

--SELECT *,
--CASE WHEN emp_sal > 50 THEN 'PAID WELL' ELSE 'UNDER PAID' END AS  PAYMENT_STATUS
--FROM EMP.EMP.EMPLOYEE

--create table temp
--(
--id int
--)

--select * from temp
insert into temp values('109')
--insert into temp values(109)

select *,
case when emp_sal > 50 then 'paid well' else 'under paid' end as payment_status
from emp.emp.employee

select *,
if emp_sal > 50
print 'paid well'
else 
print 'under paid'  
from emp.emp.employee




