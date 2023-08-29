--1)
update gaps set TestCase = (select lag(TestCase,1) over(order by RowNumber) 
from gaps a where a.rownumber = gaps.rownumber)  where TestCase is null
--select * from gaps

--2)
drop trigger TR_SelectAll
create trigger TR_SelectAll
on dbo.gaps
for select
as
begin
rollback;
print 'Select All is not possible'
end




--3)
select row_number() over(partition by Distributor,facility,zone order by OrderId) 
as [CriteriaId],orderId from GroupCriteria

select  FIRST_VALUE(Criteria) over(partition by Distributor, Facility, Zone 
									order by OrderId) as [CriteriaId],
		orderId, Distributor, Facility, Zone ,Amount
		from
		(
			select  
			row_number() over(partition by Distributor, Facility, Zone 
													order by OrderId) as [Criteria], *
			from GroupCriteria
		) as SourceTable
--6)
select distinct productcode from products1 where productcode not in
(select productCode from products1 a
where product = any (select product from products1 
					where productCode <> a.productCode))


--7)
--Create a numbers table of the numbers 1 through 10 and their factorial. 
create table numbers(number int, factorial int)
--select * from numbers

declare @n int
set @n = 1
declare @fact int
declare @i int
while(@n <= 10)
begin
set @fact = 1
set @i = 1
			while(@i < @n)
			begin
				set @fact = @fact * @i;
				set @i = @i + 1
			end
insert into numbers values(@n, @fact);
set @n = @n + 1
end


--9)
select * from TheMultiCheckingCondition where any <> 'pawan'
where not any'pawan' and 
		b <> 'pawan' and 
		c <> 'pawan' and 
		d <> 'pawan' and 
		e <> 'pawan' and 
		f <> 'pawan' 

--10
select visited_on , amount,
sum(lead(amount,7))
from customer

--5)
select * from BalancedString
select rownumber, expectedOutcome, MatchString,
case when 
	substring(matchstring,1,(len(matchString) / 2))
	= 
	substring(matchstring, (len(matchString) / 2) + 1, len(matchString))
then 'Balanced'
else 'Unbalanced'
end as OutCome
from BalancedString


select substring(matchstring,1,(len(matchString) / 2)) from BalancedString
select substring(matchstring, (len(matchString) / 2) +1, len(matchString)) from BalancedString
select * from BalancedString
