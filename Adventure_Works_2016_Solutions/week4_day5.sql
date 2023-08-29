--Create a query to display the hierarchical relationship between 
--a certain employee and his direct and indirect managers 

--select * from employees

with EmpMgrHierarchi
as
(
	select e1.employee_id, e1.First_Name, e1.Last_Name, 
	case when e1.manager_id is null then 'No manager'
	else cast(e1.manager_id as varchar(50)) end as manager, 0 as Hlevel from employees e1
	left join employees e2
	on e1.manager_id = e2.employee_id
	where e1.manager_id is null

	union all

	select t1.employee_id, t1.first_name, t1.Last_Name,
	cast(t1.manager_id as varchar(50)) as manager, 1 + Hlevel
	from employees t1
	join EmpMgrHierarchi t2
	on t1.manager_id = t2.employee_id
)
select * from EmpMgrHierarchi

--6)
select *, sum(QuantityAdjustment) over(order by QuantityAdjustment) as Inventory from inventory


--Write a query to find the node type of Binary Tree ordered by the value of 
--the node. Output one of the following for each node:

--Root: If node is root node.
--Leaf: If node is leaf node.
--Inner: If node is neither root nor leaf node.

select n, case when p is null then 'Root'
            when n = any (select p from BST) then 'Inner'
            else 'Leaf'
            end
from BST order by n

--You are given a table, Functions, containing two columns: X and Y.
--Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
--Write a query to output all such symmetric pairs in ascending order by the value of X.List the rows such that X1 ≤ Y1.

select x, y from
    (
        select x, y, lead(y,1,0) over(order by y) as y2,
        lead(x,1,0) over(order by x) as x2 from Functions order by x
    )as sourceTable
    where x <= y
    and x = y2
    and y = x2