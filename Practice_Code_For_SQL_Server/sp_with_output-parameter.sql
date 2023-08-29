--CREATE TABLE error_log (errorno int, errormsg varchar(max))


DEClare @error_flag as integer
set @error_flag = -1;

CREATE PROCEDURE check1
AS
BEGIN
begin try
	

		--print concat('Record printed',@@rowcount)
end try
begin catch
INSERT INTO error_log values (ERROR_NUMBER(), ERROR_MESSAGE())

		--select ERROR_NUMBER() as errorNo
		--print error_number();
		--print error_message();
		--set @error_flag = ERROR_NUMBER();
end catch
END

exec check1


alter proc sp_return_eg 
@no1 int
as
begin 
select @no1 + @no1
end
exec sp_return_eg @no1 = 22

declare @op int
exec @op = sp_return_eg 12
select @op
----------------------------------------
alter proc sp_return_eg
@no1 int,
@no2 int output
as
begin
set @no2 = @no1 + @no1
end

declare @no3 int
exec sp_return_eg 11,@no3 output
select @no3

------------------------------------------------------------------
create function scal_fun(@var1 int,@var2 int)
returns int
as
begin
return @var1
end

select dbo.scal_fun(1,2)

select agent_code,agent_name,country,commision,
case
when 
country = 'US'
then 
comission * 1.1;