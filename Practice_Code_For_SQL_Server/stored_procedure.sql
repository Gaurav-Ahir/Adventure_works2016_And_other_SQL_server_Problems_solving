alter procedure sp_upsert2
as
begin
declare @flag varchar(100)
set @flag = null

--update
if((select top 1 id from temp where id in (select id from destination_tbl)) is not null)
begin
	update destination_tbl
	set destination_tbl.name = temp.name
	from temp,destination_tbl
	where destination_tbl.id = temp.id
	

end
else
begin

end
end

insert into destination_tbl values(100,'gaurav'),(101,'shyam'),(102,'ram')
select * from temp
select * from destination_tbl