USE [master]
GO
/****** Object:  Database [School]    Script Date: 25.6.2015 г. 22:19:02 ч. ******/
CREATE DATABASE [School]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Students', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Students.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Students_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Students_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [School] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [School].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [School] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [School] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [School] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [School] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [School] SET ARITHABORT OFF 
GO
ALTER DATABASE [School] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [School] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [School] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [School] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [School] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [School] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [School] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [School] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [School] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [School] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [School] SET  DISABLE_BROKER 
GO
ALTER DATABASE [School] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [School] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [School] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [School] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [School] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [School] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [School] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [School] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [School] SET  MULTI_USER 
GO
ALTER DATABASE [School] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [School] SET DB_CHAINING OFF 
GO
ALTER DATABASE [School] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [School] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [School]
GO
/****** Object:  User [vito]    Script Date: 25.6.2015 г. 22:19:02 ч. ******/
CREATE USER [vito] FOR LOGIN [vito] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 25.6.2015 г. 22:19:02 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [text] NOT NULL,
	[MaxStudents] [int] NOT NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Students]    Script Date: 25.6.2015 г. 22:19:02 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [text] NOT NULL,
	[Age] [int] NULL,
	[PhoneNumber] [text] NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[Students] SET (LOCK_ESCALATION = DISABLE)
GO
SET IDENTITY_INSERT [dbo].[Classes] ON 

INSERT [dbo].[Classes] ([id], [Name], [MaxStudents]) VALUES (1, N'A', 20)
INSERT [dbo].[Classes] ([id], [Name], [MaxStudents]) VALUES (2, N'B', 21)
INSERT [dbo].[Classes] ([id], [Name], [MaxStudents]) VALUES (3, N'C', 22)
INSERT [dbo].[Classes] ([id], [Name], [MaxStudents]) VALUES (4, N'D', 23)
INSERT [dbo].[Classes] ([id], [Name], [MaxStudents]) VALUES (5, N'E', 24)
INSERT [dbo].[Classes] ([id], [Name], [MaxStudents]) VALUES (6, N'F', 25)
INSERT [dbo].[Classes] ([id], [Name], [MaxStudents]) VALUES (7, N'G', 26)
INSERT [dbo].[Classes] ([id], [Name], [MaxStudents]) VALUES (8, N'H', 27)
INSERT [dbo].[Classes] ([id], [Name], [MaxStudents]) VALUES (9, N'Elite', 5)
SET IDENTITY_INSERT [dbo].[Classes] OFF
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([ID], [Name], [Age], [PhoneNumber]) VALUES (1, N'Peter', 21, N'23')
INSERT [dbo].[Students] ([ID], [Name], [Age], [PhoneNumber]) VALUES (2, N'Ivan', 32, N'232')
INSERT [dbo].[Students] ([ID], [Name], [Age], [PhoneNumber]) VALUES (5, N'2', 32, N'343-343-43')
INSERT [dbo].[Students] ([ID], [Name], [Age], [PhoneNumber]) VALUES (23, N'23', 23, N'32')
INSERT [dbo].[Students] ([ID], [Name], [Age], [PhoneNumber]) VALUES (24, N'123', 123, N'123')
INSERT [dbo].[Students] ([ID], [Name], [Age], [PhoneNumber]) VALUES (25, N'123', 12312, N'123')
INSERT [dbo].[Students] ([ID], [Name], [Age], [PhoneNumber]) VALUES (26, N'123', 123, N'123')
INSERT [dbo].[Students] ([ID], [Name], [Age], [PhoneNumber]) VALUES (27, N'Ivan', 1000, N'0000000-01')
INSERT [dbo].[Students] ([ID], [Name], [Age], [PhoneNumber]) VALUES (28, N'Dan', 12, N'213')
SET IDENTITY_INSERT [dbo].[Students] OFF
USE [master]
GO
ALTER DATABASE [School] SET  READ_WRITE 
GO
