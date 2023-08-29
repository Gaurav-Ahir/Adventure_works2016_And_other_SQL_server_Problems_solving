
create database customer
--Write a SQL query to create table as per the given schema. 
create table orders(ord_num integer primary key not null,ord_amount integer
not null,advance_amount integer not null,ord_date date not null,
cust_code varchar(200) not null,agent_code char(50) not null,
ord_desctription varchar(200) not null)

--create table customers
create table customers(cust_code varchar(100)primary key not null,
cust_name varchar(200) not null,cust_city char(100),
working_area varchar(200) not null,cust_country varchar(200) not null,
grade integer,payment_amt integer not null,outstanding_amt integer
not null,phone_no varchar(200) not null,agent_code char(50)not null)

--create table agents
create table agents(agent_code char(50)primary key not null,
agent_name char(50),working_area char(50),commision integer,
phone_no char(50),country varchar(200))

--add the following fields in the table customers
alter table customers add receive_amt integer not null
alter table customers add opening_amt integer not null

--add constraints to all tables
alter table customers add foreign key (agent_code) references agents(agent_code);
alter table orders add foreign key (cust_code) references customers(cust_code);
alter table orders add foreign key (agent_code) references agents(agent_code);
--A007, Ramasundar, Bangalore, 0.15, 077-25814763, ‘’  agents
insert into agents values('A006','Ramasundar','Bangalore',0.15,077-25814763,'');
--C00013, Holmes, London, London, UK, 2, 6000.00,
--5000.00, 7000.00,  4000.00,BBBBBBB, A003 – customers 
insert into customers values('C00013','Holmes','London','London','UK',2,5000.00,7000.00
,'654878767','A003',4000.00,3000.00)

--200100, 1000.00, 600.00, 08/01/2008, C00013, A003, SOD – orders 
INSERT INTO ORDERS VALUES(200100,1000.00,600.00,'08/01/2008','C00013','A003','SOD')
--query to return the data from the orders table where order_date is before sept1,2022.
SELECT * FROM orders WHERE ORD_DATE < '09/01/2022'
--Write a SQL query to update commission where agent name starts with 
--‘A’ and has exactly 6 characters and country is not null. 

UPDATE AGENTS SET COMMISION = 0.19 WHERE AGENT_NAME LIKE 'R_____' and country is not NULL

-- rename the column name ‘ORD_NUM’ from orders table to ‘ORDER_NUM’
--ALTER TABLE ORDERS rename column ORD_NUM TO ORDER_NUM;


exec sp_rename 'orders.ord_amount', 'order_amout', 'column'


--fetch the count for each city in the descending order. 
SELECT CUST_CITY,COUNT(CUST_CITY) AS TOTAL_CITY FROM customers
GROUP BY CUST_CITY

--get the common customer codes from customers and orders where 
--customer are in cities like London, Bangalore 
SELECT customers.cust_city, orders.CUST_CODE FROM customers,orders
where customers.cust_code = orders.cust_code
and cust_city IN ('LONDON','Bangalore')
GROUP BY cust_city,orders.CUST_CODE
--HAVING cust_city IN ('LONDON','Bangalore')
order by cust_city

select * from orders
select * from customers

--delete all the records before sept 2020. 
delete from orders where ord_date < '09/01/2020'

--get and increase the commission by 10% when the country is ‘UK’, 
--20% for ‘India’ and  else print ‘No commission’ for rest. 

select agent_code,agent_name,country,commision,
	case 
		 WHEN country = 'UK' THEN CAST(commision + (commision * 0.1) AS VARCHAR(200))
         WHEN country = 'India' THEN CAST(commision + (commision * 0.2) AS VARCHAR(200))
         ELSE 'No commission'
	end AS new_commision
from agents



alter function newcommision1 (@country varchar(100),@commision float)
returns varchar(100)
as
begin
declare @result varchar(100)
if @country = 'UK'
begin
set @result = cast(@commision + (@commision/10) as varchar(100))
end
else if @country = 'INDIA'
begin
set @result = cast(@commision + (@commision/5)as varchar(100))
end
else
begin
set @result = 'no commision'
end
return @result
end



select dbo.newcommision1('UK',2000);

select agent_name, commision, country, dbo.newcommision1(country,
commision) as new_commission from agents;

create procedure cal_new_commission(@country varchar(100),@commision float,@result varchar(100) output)
as
begin
set @result = null
if @country = 'UK'
set @result = cast(@commision + (@commision/10) as varchar(100))
else if @country = 'INDIA'

set @result = cast(@commision + (@commision/5)as varchar(100))
else
set @result = 'no commision'
end

begin
declare @getresult varchar(100)
execute cal_new_commission 'UK',1000,@getresult output
select @getresult as n_commission
end


SELECT * FROM ORDERS
select * from agents
select * from customers
DELETE FROM agents WHERE agent_code = 'A015'
drop table agents
drop table orders
drop table customers

select * from agents

select *  from agents where working_area = 'Bangalore'
--select all then execute cte
with newcte
as
(
select * from agents where working_area = 'Bangalore'
)select * from newcte

BACKUP DATABASE customer
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\testdb.bak'
WITH DIFFERENTIAL;


