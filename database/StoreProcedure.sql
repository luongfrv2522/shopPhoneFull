/*SP cơ bản*/
/*--------Phân trang-----------*/
ALTER PROCEDURE SP_PageList
@Page INT,
@quantity_row INT
AS
BEGIN
	BEGIN TRY
		SELECT [id_phone]
			  ,[phone_name]
			  ,[description]
			  ,[image_feature]
			  ,[price]
			  ,[status]
			  ,[position]
			  ,[id_brand]
			  ,[created_at]
			  ,[updated_at]
		  FROM [ShopDienThoai].[dbo].[phone]
		  ORDER BY [id_phone]
		  OFFSET (@Page-1)*@quantity_row --Page bắt đầu từ 0
		  ROWS FETCH NEXT @quantity_row ROWS ONLY
	   
	   DECLARE @total INT,@surplus INT
	   SELECT @total=COUNT([id_phone]) FROM [dbo].[phone]
	   SET @surplus = @total % @quantity_row
	   SET @total = @total / @quantity_row
	   IF @surplus!=0
			SET @total = @total + 1
	   RETURN @total --Tổng số trang
	END TRY
	BEGIN CATCH
		/*SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_LINE() AS ErrorLine,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_MESSAGE() AS ErrorMessage*/
		PRINT 'Page>0 & quantity>0';
		THROW;
	END CATCH
  END;
-----Test
DECLARE @TOO INT
EXECUTE @TOO=dbo.SP_PageList 5, 10
PRINT @TOO
/*-----------------------------*/