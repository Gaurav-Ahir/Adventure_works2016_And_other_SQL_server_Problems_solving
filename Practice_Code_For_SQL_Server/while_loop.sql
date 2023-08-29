--begin
--declare @a as int
--set @a = 1
--while(@a <= 20)
--	begin
--		print replicate('* ',@a)
--		set @a = @a + 1
--	end
--end



begin
declare @result as varchar(max)
set @result = ''
DECLARE @TEMP AS INT
SET @TEMP = 2
DECLARE @FLAG AS INT
WHILE(@TEMP <= 1000)
    BEGIN
		SET @FLAG = 0
		DECLARE @TEMP1 AS INT
		SET @TEMP1 = 2

		WHILE(@TEMP1 < @TEMP)
		BEGIN
			IF(@TEMP % @TEMP1 = 0)
			BEGIN
			SET @FLAG = 1
			END
			SET @TEMP1 = @TEMP1 + 1
		END
	IF(@FLAG = 0)
	BEGIN
		set @result = @result+cast(@temp as varchar(50))+cast('&' as varchar(50))
	END
	SET @TEMP = @TEMP + 1
    end
	
	SELECT @result
END

-------------------------------------------------------------------
begin
declare @prime as varchar(max)
set @prime = ''
declare @var1 as int
set @var1 = 2

while(@var1 <= 1000)
begin
declare @flag as int
set @flag = 0
declare @var2 as int 
set @var2 = 2
    while(@var2 < @var1)
    begin
        if((@var1 % @var2) = 0)
        begin
            set @flag = 1
        end
    set @var2 = @var2 + 1
    end
if(@flag = 0)
begin
    set @prime = @prime + cast(@var1 as varchar(50)) + '&' 
end
set @var1 = @var1 + 1
end
select substring(@prime,1,(len(@prime) - 1))
end



