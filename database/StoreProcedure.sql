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
		SELECT *
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
		PRINT 'Page>0 & quantity>0';
		THROW;
	END CATCH
END;


  ------------------------------------
GO
ALTER FUNCTION SP_SoTrang(@quantity_row INT) RETURNS INT
AS 
BEGIN
	DECLARE @surplus INT, @total INT
	SELECT @total=COUNT(id_phone) FROM [dbo].[phone]
	SET @surplus = @total % @quantity_row
	SET @total = @total / @quantity_row
	IF @surplus!=0
		SET @total = @total + 1
	RETURN @total
END;
GO
 PRINT [dbo].[SP_SoTrang](15)
GO 
ALTER PROCEDURE sp_PageList_all
@Page INT,
@quantity_row INT,
@table_name NVARCHAR(50),
@PK_col_name NVARCHAR(50),
@total INT OUTPUT
AS
BEGIN
/*
@statement: là câu lệnh bạn yêu cầu thực hiện, có kiểu dữ liệu NVARCHAR(MAX) (với SQL Server 2000 là NTEXT). Chú ý là nó chỉ chấp nhận kiểu NVARCHAR là unicode chứ không chấp nhận kiểu VARCHAR.

@params: là định nghĩa các tham số dùng trong câu lệnh, cũng yêu cầu kiểu dữ liệu NVARCHAR(MAX) (hoặc NTEXT với SQL Server 2000)

Các tham số còn lại dùng để gán giá trị cho các tham số đã được khai báo trong @ParamDefinition
*/
	
/**/
	DECLARE @SQLCMD NVARCHAR(MAX)
	
	BEGIN TRY
		SET @total = [dbo].[SP_SoTrang](@quantity_row)
		/**/
		SET @SQLCMD = N'SELECT *
		FROM '+ @table_name +'
		ORDER BY '+ @PK_col_name +' 
		OFFSET (@Page-1)*@quantity_row
		ROWS FETCH NEXT @quantity_row ROWS ONLY'
	   DECLARE @STATEMENT NVARCHAR(MAX),@ParamDefinition NVARCHAR(MAX) -- EXEC SP_EXECUTESQL 
	   SET @ParamDefinition = N'@Page INT, @quantity_row INT'
	   EXEC SP_EXECUTESQL 
		@STATEMENT = @SQLCMD, 
		@params = @ParamDefinition,
		@Page = @Page,
		@quantity_row = @quantity_row
	   /**/
	  
	   --RETURN @total --Tổng số trang
	END TRY
	BEGIN CATCH
		PRINT 'Page>0 & quantity>0';
		THROW;
	END CATCH
	/**/

END;
GO
DECLARE @output INT
EXEC sp_PageList_all 1, 10, N'phone', N'id_phone', @output OUTPUT
PRINT @output

/*---------------------------------------------*/
GO
CREATE PROC SP_phone_price_PL
@Page INT,
@quantity_row INT,
@order BIT,
@total INT OUTPUT
AS
BEGIN
	-----
	SET @total = [dbo].[SP_SoTrang](@quantity_row)
	-----
	IF @order!=0
	BEGIN
		SELECT *
		FROM [ShopDienThoai].[dbo].[phone]
		ORDER BY [price]
		OFFSET (@Page-1)*@quantity_row --Page bắt đầu từ 0
		ROWS FETCH NEXT @quantity_row ROWS ONLY
	END;
	ELSE BEGIN
		SELECT *
		FROM [ShopDienThoai].[dbo].[phone]
		ORDER BY [price] DESC
		OFFSET (@Page-1)*@quantity_row --Page bắt đầu từ 0
		ROWS FETCH NEXT @quantity_row ROWS ONLY
	END;
END;

GO
CREATE PROC SP_phone_brand_PL
@Page INT,
@quantity_row INT,
@id_brand INT,
@total INT OUTPUT
AS
BEGIN
	-----
	DECLARE @surplus INT
	SELECT @total=COUNT(id_phone) FROM [dbo].[phone]
	SET @surplus = @total % @quantity_row
	SET @total = @total / @quantity_row
	IF @surplus!=0
		SET @total = @total + 1
	-----
	SELECT *
	FROM [ShopDienThoai].[dbo].[phone]
	WHERE id_brand = @id_brand
	ORDER BY id_phone
	OFFSET (@Page-1)*@quantity_row --Page bắt đầu từ 0
	ROWS FETCH NEXT @quantity_row ROWS ONLY
END;