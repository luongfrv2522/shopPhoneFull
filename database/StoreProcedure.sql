/*SP cơ bản*/
/*--------Phân trang-----------*/
ALTER PROCEDURE SP_PageList
@Page INT,
@quantity_row INT,
@total INT OUTPUT
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
	   
	   DECLARE @surplus INT
	   SELECT @total=COUNT([id_phone]) FROM [dbo].[phone]
	   SET @surplus = @total % @quantity_row
	   SET @total = @total / @quantity_row
	   IF @surplus!=0
			SET @total = @total + 1
	   --RETURN @total --Tổng số trang
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
-----Test-----
GO
DECLARE @TOO INT =3
EXECUTE dbo.SP_PageList 5, 10,@TOO
PRINT @TOO
GO
/*-----------------------------*/
DECLARE @TOO1 INT =3
EXECUTE @TOO1=dbo.SP_PageList_RETURN 5, 10
PRINT @TOO1

GO
/*--------------PROC LỌC THEO BẢNG----------------*/
/* Create a table type. */  
CREATE TYPE LocationTableType AS TABLE   
( LocationName VARCHAR(50)  
, CostRate INT );  
GO
CREATE PROCEDURE SP_PageList_Table
@Page INT,
@quantity_row INT,
@total INT OUTPUT
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
	   
	   DECLARE @surplus INT
	   SELECT @total=COUNT([id_phone]) FROM [dbo].[phone]
	   SET @surplus = @total % @quantity_row
	   SET @total = @total / @quantity_row
	   IF @surplus!=0
			SET @total = @total + 1
	   --RETURN @total --Tổng số trang
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
