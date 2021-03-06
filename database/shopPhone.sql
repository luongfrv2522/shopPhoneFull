/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4001)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [master]
GO
/****** Object:  Database [ShopDienThoai]    Script Date: 02-Nov-17 9:48:40 AM ******/
CREATE DATABASE [ShopDienThoai]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ShopDienThoai', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\ShopDienThoai.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ShopDienThoai_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\ShopDienThoai_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ShopDienThoai] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ShopDienThoai].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ShopDienThoai] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ShopDienThoai] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ShopDienThoai] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ShopDienThoai] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ShopDienThoai] SET ARITHABORT OFF 
GO
ALTER DATABASE [ShopDienThoai] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ShopDienThoai] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ShopDienThoai] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ShopDienThoai] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ShopDienThoai] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ShopDienThoai] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ShopDienThoai] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ShopDienThoai] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ShopDienThoai] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ShopDienThoai] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ShopDienThoai] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ShopDienThoai] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ShopDienThoai] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ShopDienThoai] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ShopDienThoai] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ShopDienThoai] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ShopDienThoai] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ShopDienThoai] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ShopDienThoai] SET  MULTI_USER 
GO
ALTER DATABASE [ShopDienThoai] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ShopDienThoai] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ShopDienThoai] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ShopDienThoai] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ShopDienThoai] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ShopDienThoai] SET QUERY_STORE = OFF
GO
USE [ShopDienThoai]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [ShopDienThoai]
GO
/****** Object:  FullTextCatalog [nam1]    Script Date: 02-Nov-17 9:48:40 AM ******/
CREATE FULLTEXT CATALOG [nam1]WITH ACCENT_SENSITIVITY = OFF
AS DEFAULT
GO
/****** Object:  FullTextCatalog [Name_brand]    Script Date: 02-Nov-17 9:48:40 AM ******/
CREATE FULLTEXT CATALOG [Name_brand]WITH ACCENT_SENSITIVITY = ON
GO
/****** Object:  Table [dbo].[brand]    Script Date: 02-Nov-17 9:48:40 AM ******/
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
/****** Object:  Table [dbo].[gallery]    Script Date: 02-Nov-17 9:48:40 AM ******/
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
/****** Object:  Table [dbo].[phone]    Script Date: 02-Nov-17 9:48:40 AM ******/
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
/****** Object:  Table [dbo].[rela_brand_phone]    Script Date: 02-Nov-17 9:48:40 AM ******/
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
/****** Object:  Table [dbo].[rela_phone_gallery]    Script Date: 02-Nov-17 9:48:40 AM ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 02-Nov-17 9:48:40 AM ******/
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bảng này lưu dữ thông tin các điện thoại theo bộ sưu tập của nó.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rela_phone_gallery', @level2type=N'COLUMN',@level2name=N'id_phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'position là vị trí sắp xếp của item trong 1 hãng của bảng.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'rela_phone_gallery', @level2type=N'COLUMN',@level2name=N'position'
GO
USE [master]
GO
ALTER DATABASE [ShopDienThoai] SET  READ_WRITE 
GO
