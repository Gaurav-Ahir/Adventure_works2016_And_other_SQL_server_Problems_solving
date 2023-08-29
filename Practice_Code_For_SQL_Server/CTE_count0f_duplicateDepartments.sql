with countof
as
(
select *,row_number() over(partition by dept,salary order by salary,dept) as rank_no from windows_fun
)
select salary,dept,max(rank_no) as salary_dept_count from countof 
where rank_no > 1
group by salary,dept
--------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

select salary,dept,max(rank_no)as salary_dept_count from 
(select *,row_number() over(partition by dept,salary order by salary,dept) as rank_no
from windows_fun)as countof 
where rank_no > 1
group by salary,dept