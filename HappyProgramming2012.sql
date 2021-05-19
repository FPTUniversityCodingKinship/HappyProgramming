USE [master]
GO
/****** Object:  Database [HappyProgramming]    Script Date: 5/19/2021 10:26:41 AM ******/
CREATE DATABASE [HappyProgramming]
 CONTAINMENT = NONE
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HappyProgramming].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HappyProgramming] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HappyProgramming] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HappyProgramming] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HappyProgramming] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HappyProgramming] SET ARITHABORT OFF 
GO
ALTER DATABASE [HappyProgramming] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HappyProgramming] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HappyProgramming] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HappyProgramming] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HappyProgramming] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HappyProgramming] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HappyProgramming] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HappyProgramming] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HappyProgramming] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HappyProgramming] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HappyProgramming] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HappyProgramming] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HappyProgramming] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HappyProgramming] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HappyProgramming] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HappyProgramming] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HappyProgramming] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HappyProgramming] SET RECOVERY FULL 
GO
ALTER DATABASE [HappyProgramming] SET  MULTI_USER 
GO
ALTER DATABASE [HappyProgramming] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HappyProgramming] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HappyProgramming] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HappyProgramming] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
USE [HappyProgramming]
GO
/****** Object:  Table [dbo].[users]    Script Date: 5/19/2021 10:26:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[username] [varchar](20) NOT NULL,
	[email] [varchar](255) NULL,
	[password] [varchar](20) NOT NULL,
	[fullname] [nvarchar](50) NULL,
	[phone] [varchar](10) NULL,
	[address] [nvarchar](255) NULL,
	[dob] [date] NULL,
	[sex] [varchar](5) NULL,
	[image] [nvarchar](255) NULL,
	[roleID] [nvarchar](10) NULL,
	[status] [bit] NULL,
	[emailStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[users] ([username], [email], [password], [fullname], [phone], [address], [dob], [sex], [image], [roleID], [status], [emailStatus]) VALUES (N'guestsss', NULL, N'123456', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[users] ([username], [email], [password], [fullname], [phone], [address], [dob], [sex], [image], [roleID], [status], [emailStatus]) VALUES (N'sa', NULL, N'123456', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
USE [master]
GO
ALTER DATABASE [HappyProgramming] SET  READ_WRITE 
GO
