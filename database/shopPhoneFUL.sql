USE [ShopDienThoai]
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rela_phone_gallery', @level2type=N'COLUMN',@level2name=N'position'
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rela_phone_gallery', @level2type=N'COLUMN',@level2name=N'id_phone'
GO
/****** Object:  StoredProcedure [dbo].[SP_phone_price_PL]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP PROCEDURE [dbo].[SP_phone_price_PL]
GO
/****** Object:  StoredProcedure [dbo].[SP_phone_brand_PL]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP PROCEDURE [dbo].[SP_phone_brand_PL]
GO
/****** Object:  StoredProcedure [dbo].[SP_PageList_Table]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP PROCEDURE [dbo].[SP_PageList_Table]
GO
/****** Object:  StoredProcedure [dbo].[SP_PageList_RETURN]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP PROCEDURE [dbo].[SP_PageList_RETURN]
GO
/****** Object:  StoredProcedure [dbo].[sp_PageList_all]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP PROCEDURE [dbo].[sp_PageList_all]
GO
/****** Object:  StoredProcedure [dbo].[SP_PageList]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP PROCEDURE [dbo].[SP_PageList]
GO
/****** Object:  StoredProcedure [dbo].[prc_PhanTrang]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP PROCEDURE [dbo].[prc_PhanTrang]
GO
ALTER TABLE [dbo].[rela_phone_gallery] DROP CONSTRAINT [FK_rela_phone_gallery_phone]
GO
ALTER TABLE [dbo].[rela_phone_gallery] DROP CONSTRAINT [FK_rela_phone_gallery_gallery]
GO
ALTER TABLE [dbo].[rela_brand_phone] DROP CONSTRAINT [FK_rela_brand_phone_phone]
GO
ALTER TABLE [dbo].[rela_brand_phone] DROP CONSTRAINT [FK_rela_brand_phone_brand]
GO
ALTER TABLE [dbo].[phone] DROP CONSTRAINT [FK_phone_brand]
GO
/****** Object:  Table [dbo].[users]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP TABLE [dbo].[users]
GO
/****** Object:  Table [dbo].[rela_phone_gallery]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP TABLE [dbo].[rela_phone_gallery]
GO
/****** Object:  Table [dbo].[rela_brand_phone]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP TABLE [dbo].[rela_brand_phone]
GO
/****** Object:  Table [dbo].[gallery]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP TABLE [dbo].[gallery]
GO
/****** Object:  Table [dbo].[brand]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP TABLE [dbo].[brand]
GO
/****** Object:  UserDefinedFunction [dbo].[TA]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP FUNCTION [dbo].[TA]
GO
/****** Object:  Table [dbo].[phone]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP TABLE [dbo].[phone]
GO
/****** Object:  UserDefinedFunction [dbo].[SP_SoTrang]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP FUNCTION [dbo].[SP_SoTrang]
GO
/****** Object:  UserDefinedTableType [dbo].[LocationTableType]    Script Date: 11/10/2017 2:23:30 PM ******/
DROP TYPE [dbo].[LocationTableType]
GO
/****** Object:  FullTextCatalog [Name_brand]    Script Date: 11/10/2017 2:23:30 PM ******/
GO
DROP FULLTEXT CATALOG [Name_brand]
GO
/****** Object:  FullTextCatalog [nam1]    Script Date: 11/10/2017 2:23:30 PM ******/
GO
DROP FULLTEXT CATALOG [nam1]
GO
/****** Object:  FullTextCatalog [nam1]    Script Date: 11/10/2017 2:23:30 PM ******/
CREATE FULLTEXT CATALOG [nam1]WITH ACCENT_SENSITIVITY = OFF
AS DEFAULT
GO
/****** Object:  FullTextCatalog [Name_brand]    Script Date: 11/10/2017 2:23:30 PM ******/
CREATE FULLTEXT CATALOG [Name_brand]WITH ACCENT_SENSITIVITY = ON
GO
/****** Object:  UserDefinedTableType [dbo].[LocationTableType]    Script Date: 11/10/2017 2:23:30 PM ******/
CREATE TYPE [dbo].[LocationTableType] AS TABLE(
	[LocationName] [varchar](50) NULL,
	[CostRate] [int] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[SP_SoTrang]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SP_SoTrang](@quantity_row INT) RETURNS INT
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
/****** Object:  Table [dbo].[phone]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phone](
	[id_phone] [int] IDENTITY(1,1) NOT NULL,
	[phone_name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[image_feature] [nvarchar](255) NULL,
	[price] [money] NULL,
	[status] [int] NULL,
	[position] [int] NULL,
	[id_brand] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK_phone] PRIMARY KEY CLUSTERED 
(
	[id_phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[TA]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[TA]()
RETURNS TABLE 
AS
RETURN SELECT * FROM phone
GO
/****** Object:  Table [dbo].[brand]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brand](
	[id_brand] [int] IDENTITY(1,1) NOT NULL,
	[brand_name] [nvarchar](50) NULL,
	[description] [nvarchar](255) NULL,
	[image_feature] [nvarchar](255) NULL,
	[status] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK_brand] PRIMARY KEY CLUSTERED 
(
	[id_brand] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gallery]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gallery](
	[id_gallery] [int] IDENTITY(1,1) NOT NULL,
	[gallery_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_gallery] PRIMARY KEY CLUSTERED 
(
	[id_gallery] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rela_brand_phone]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rela_brand_phone](
	[id_brand] [int] NOT NULL,
	[id_phone] [int] NOT NULL,
	[position] [int] NULL,
 CONSTRAINT [PK_rela_brand_phone] PRIMARY KEY CLUSTERED 
(
	[id_phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rela_phone_gallery]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rela_phone_gallery](
	[id_phone] [int] NOT NULL,
	[id_gallery] [int] NOT NULL,
	[position] [int] NULL,
 CONSTRAINT [PK_rela_phone_gallery] PRIMARY KEY CLUSTERED 
(
	[id_phone] ASC,
	[id_gallery] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id_user] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[fullname] [nvarchar](50) NULL,
	[image_feature] [nvarchar](50) NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[phone]  WITH CHECK ADD  CONSTRAINT [FK_phone_brand] FOREIGN KEY([id_brand])
REFERENCES [dbo].[brand] ([id_brand])
GO
ALTER TABLE [dbo].[phone] CHECK CONSTRAINT [FK_phone_brand]
GO
ALTER TABLE [dbo].[rela_brand_phone]  WITH CHECK ADD  CONSTRAINT [FK_rela_brand_phone_brand] FOREIGN KEY([id_brand])
REFERENCES [dbo].[brand] ([id_brand])
GO
ALTER TABLE [dbo].[rela_brand_phone] CHECK CONSTRAINT [FK_rela_brand_phone_brand]
GO
ALTER TABLE [dbo].[rela_brand_phone]  WITH CHECK ADD  CONSTRAINT [FK_rela_brand_phone_phone] FOREIGN KEY([id_phone])
REFERENCES [dbo].[phone] ([id_phone])
GO
ALTER TABLE [dbo].[rela_brand_phone] CHECK CONSTRAINT [FK_rela_brand_phone_phone]
GO
ALTER TABLE [dbo].[rela_phone_gallery]  WITH CHECK ADD  CONSTRAINT [FK_rela_phone_gallery_gallery] FOREIGN KEY([id_gallery])
REFERENCES [dbo].[gallery] ([id_gallery])
GO
ALTER TABLE [dbo].[rela_phone_gallery] CHECK CONSTRAINT [FK_rela_phone_gallery_gallery]
GO
ALTER TABLE [dbo].[rela_phone_gallery]  WITH CHECK ADD  CONSTRAINT [FK_rela_phone_gallery_phone] FOREIGN KEY([id_phone])
REFERENCES [dbo].[phone] ([id_phone])
GO
ALTER TABLE [dbo].[rela_phone_gallery] CHECK CONSTRAINT [FK_rela_phone_gallery_phone]
GO
/****** Object:  StoredProcedure [dbo].[prc_PhanTrang]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[prc_PhanTrang]
(
@pageSize int,
@pageNumber int
)
AS
BEGIN
	SELECT  [id_phone],[phone_name],[description],[price] FROM [dbo].[phone]
	ORDER BY [price]
	OFFSET @pageSize *10 ROWS FETCH NEXT @pageNumber ROWS ONLY

END
GO
/****** Object:  StoredProcedure [dbo].[SP_PageList]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*SP cơ bản*/
/*--------Phân trang-----------*/
CREATE PROCEDURE [dbo].[SP_PageList]
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
/****** Object:  StoredProcedure [dbo].[sp_PageList_all]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_PageList_all]
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
/****** Object:  StoredProcedure [dbo].[SP_PageList_RETURN]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PageList_RETURN]
@Page INT,
@quantity_row INT
--,@total INT OUTPUT
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
	   
	   DECLARE @surplus INT ,@total INT
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
GO
/****** Object:  StoredProcedure [dbo].[SP_PageList_Table]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PageList_Table]
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
/****** Object:  StoredProcedure [dbo].[SP_phone_brand_PL]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_phone_brand_PL]
@Page INT,
@quantity_row INT,
@id_brand INT,
@total INT OUTPUT
AS
BEGIN
	-----
	DECLARE @surplus INT
	SELECT @total=COUNT(id_phone) FROM [dbo].[phone]
	WHERE id_brand = @id_brand
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
GO
/****** Object:  StoredProcedure [dbo].[SP_phone_price_PL]    Script Date: 11/10/2017 2:23:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_phone_price_PL]
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bảng này lưu dữ thông tin các điện thoại theo bộ sưu tập của nó.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rela_phone_gallery', @level2type=N'COLUMN',@level2name=N'id_phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'position là vị trí sắp xếp của item trong 1 hãng của bảng.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rela_phone_gallery', @level2type=N'COLUMN',@level2name=N'position'
GO
