--From the following table write a query in SQL to change the display of product 
--line categories to make them more understandable. Return ProductNumber,category,
--and name of the product. Sort the result set in ascending order onProductNumber.
select ProductNumber, Name,
case when ProductLine = 'R' then 'Road'
when ProductLine = 'M' then 'Mountain'
when ProductLine = 'T' then 'Touring'
when ProductLine = 'S' then 'Other Sale Item'
else 'not for sale'
end as ProductLineCategory
from Production.Product
order by ProductNumber

select ProductLine from Production.Product

--From the following table write a query in SQL to evaluate whether
--the values in the MakeFlag and FinishedGoodsFlag columns are the same
select ProductID, MakeFlag, FinishedGoodsFlag, 
case when MakeFlag = FinishedGoodsFlag then 'Equal'
else 'not Equal'
end
from Production.Product

--From the following table write a query in SQL to select the data from
--the first column that has a nonnull value. Retrun Name, Class, Color, 
--ProductNumber, and FirstNotNull.

select name, Class, Color, ProductNumber, 
case when class is null then (case when color is null then ProductNumber
else color end)
else class
end as FirstNotNull
from Production.Product

select name, Class, Color, ProductNumber, 
coalesce(class,color,productNumber) as FirstNotNull
from Production.Product


