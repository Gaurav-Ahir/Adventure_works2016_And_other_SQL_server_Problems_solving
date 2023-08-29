alter procedure sp_upsert2
as
begin
declare @error_flag varchar(100)
set @error_flag = null

--update destination table
if((select top 1 id from temp where id in (select id from destination_tbl))is not null)

begin try
	update destination_tbl
	set destination_tbl.name = temp.name
	from destination_tbl
	join temp
	on destination_tbl.id = temp.id

		print concat('Data Updated = ',@@rowcount)

end try
begin catch
	print error_number();
	print error_message();
	set @error_flag = ERROR_NUMBER();

end catch

else
begin
print null
end

--insert into destination table
if((select top 1 id from temp where id not in (select id from destination_tbl))is null)
begin
	begin try
	insert into destination_tbl
	select t.id,t.name
	from temp t
	left join destination_tbl d
	on t.id = d.id
	where d.id is null

		print concat('Record Inserted',@@rowcount)
	end try
	begin catch
		print error_number();
		print error_message();
		set @error_flag = ERROR_NUMBER();
	end catch
end
else
begin
print null
end
--truncate temp table
if((select top 1 id from temp) is not null and @error_flag is null)
begin
truncate table temp
print 'Temp table truncated Successfully'
end

else
begin
	print 'Temp table is already empty'
end

end