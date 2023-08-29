--insert into temp values
--(100,'gaurav'),
--(101,'rahul'),
--(102,'ram')
--create table destination_tbl(id int, name int);
--drop table destination_tbl
--insert into destination_tbl values(100,'gaurav')
--insert into temp values(111,'M')
--update temp set name = 'K' where id = 103

--insert into destination_tbl(id,name) values(100,'A')




--drop table destination_tbl

alter procedure sp_upsert1
as
begin
declare @error_flag varchar(100)
set @error_flag = null
--update destination_tbl table
if((select top 1 id from temp where id in (select id from destination_tbl))is not null)
begin
	begin try
		update destination_tbl
		set destination_tbl.name = temp.name
		from destination_tbl
		join temp
		on destination_tbl.id = temp.id


			print concat('Record Updated = ',@@rowcount)

	end try
	begin catch
		print error_number();
		print error_message();
		rollback transaction;
		set @error_flag = error_number()
	end catch
end
else
begin
	print null
end

--insert into destination_tbl table
if((select top 1 id from temp where id not in (select id from destination_tbl))is not null)
begin
	begin try
		insert into destination_tbl
		select t.id,t.name 
		from temp t
		left join destination_tbl d
		on t.id = d.id
		where d.id is null

			print concat('Record Inserted = ',@@rowcount)
	end try
	begin catch

		print error_number();
		print error_message();
		rollback transaction;
		set @error_flag = error_number()
	end catch
end
else
begin
	print null
end


--truncate temp table

if((select top 1 id from temp) is not null and @error_flag is null)
begin
	truncate table temp;
	print 'Temp table truncated successfully'
end
else
begin
	print 'Temp table is already empty'
end
end

--exec sp_upsert1

--truncate table destination_tbl

select * from temp

select * from destination_tbl



