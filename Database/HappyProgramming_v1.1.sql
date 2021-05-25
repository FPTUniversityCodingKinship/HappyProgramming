USE [master]
GO
/****** Object:  Database [HappyProgramming]    Script Date: 5/24/2021 10:25:55 PM ******/
CREATE DATABASE [HappyProgramming]
 CONTAINMENT = NONE
 GO
ALTER DATABASE [HappyProgramming] SET COMPATIBILITY_LEVEL = 150
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
ALTER DATABASE [HappyProgramming] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HappyProgramming] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [HappyProgramming] SET QUERY_STORE = OFF
GO
USE [HappyProgramming]
GO
/****** Object:  Table [dbo].[comments]    Script Date: 5/24/2021 10:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comments](
	[commentID] [varchar](10) NOT NULL,
	[menteeID] [varchar](8) NOT NULL,
	[mentorID] [varchar](8) NOT NULL,
	[rate] [int] NOT NULL,
	[comments] [nvarchar](1500) NOT NULL,
	[timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_comments] PRIMARY KEY CLUSTERED 
(
	[commentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[followers]    Script Date: 5/24/2021 10:25:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[followers](
	[followID] [varchar](10) NOT NULL,
	[menteeID] [varchar](8) NOT NULL,
	[mentorID] [varchar](8) NOT NULL,
	[timestamp] [datetime] NOT NULL,
 CONSTRAINT [PK_followers] PRIMARY KEY CLUSTERED 
(
	[followID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mentorDetails]    Script Date: 5/24/2021 10:25:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mentorDetails](
	[mentorID] [varchar](8) NOT NULL,
	[facebook] [nvarchar](255) NULL,
	[github] [nvarchar](255) NULL,
	[profession] [nvarchar](100) NULL,
	[language] [nvarchar](255) NULL,
	[introduction] [nvarchar](500) NULL,
	[serviceDescription] [nvarchar](500) NULL,
	[achievementDescription] [nvarchar](500) NULL,
 CONSTRAINT [PK_mentorDetails] PRIMARY KEY CLUSTERED 
(
	[mentorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mentorSkills]    Script Date: 5/24/2021 10:25:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mentorSkills](
	[mentorSkillID] [varchar](8) NOT NULL,
	[mentorID] [varchar](8) NOT NULL,
	[SkillID] [varchar](8) NOT NULL,
	[yearExperience] [int] NULL,
	[rate] [int] NULL,
 CONSTRAINT [PK_mentorSkills] PRIMARY KEY CLUSTERED 
(
	[mentorSkillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[requests]    Script Date: 5/24/2021 10:25:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[requests](
	[requestID] [varchar](25) NOT NULL,
	[menteeID] [varchar](8) NOT NULL,
	[mentorID] [varchar](8) NOT NULL,
	[skillsID] [varchar](40) NOT NULL,
	[deadline] [datetime] NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[reqContent] [nvarchar](500) NULL,
	[status] [varchar](1) NOT NULL,
	[openedTime] [datetime] NOT NULL,
	[approvedTime] [datetime] NULL,
	[canceledTime] [datetime] NULL,
	[closedTime] [datetime] NULL,
 CONSTRAINT [PK_requests] PRIMARY KEY CLUSTERED 
(
	[requestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[skills]    Script Date: 5/24/2021 10:25:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[skills](
	[skillID] [varchar](8) NOT NULL,
	[skillName] [nvarchar](50) NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_skills] PRIMARY KEY CLUSTERED 
(
	[skillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 5/24/2021 10:25:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[userID] [varchar](8) NOT NULL,
	[username] [varchar](20) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[password] [varchar](20) NOT NULL,
	[fullname] [nvarchar](50) NULL,
	[phone] [varchar](10) NULL,
	[address] [nvarchar](255) NULL,
	[dob] [date] NULL,
	[sex] [varchar](1) NOT NULL,
	[image] [nvarchar](255) NULL,
	[status] [bit] NOT NULL,
	[emailStatus] [bit] NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[mentorDetails] ([mentorID], [facebook], [github], [profession], [language], [introduction], [serviceDescription], [achievementDescription]) VALUES (N'MT000001', N'https://www.facebook.com/profile.php?id=100005993042124', N'https://github.com/yukiakira269', N'Still Nothing', N'Vietnamese', N'Still Nothing', N'Still Nothing', N'Still Nothing')
GO
INSERT [dbo].[mentorDetails] ([mentorID], [facebook], [github], [profession], [language], [introduction], [serviceDescription], [achievementDescription]) VALUES (N'MT000005', N'https://www.facebook.com/phucvo811', N'https://github.com/funnything811', N'Still Nothing', N'Vietnamese', N'Still Nothing', N'Still Nothing', N'Still Nothing')
GO
INSERT [dbo].[users] ([userID], [username], [email], [password], [fullname], [phone], [address], [dob], [sex], [image], [status], [emailStatus]) VALUES (N'AD000000', N'admin', N'noreply@gmail.com', N'admin', N'Administrator', N'0000000000', N'nowhere', CAST(N'2001-01-01' AS Date), N'X', N'defaultAvatar.jpg', 1, 1)
GO
INSERT [dbo].[users] ([userID], [username], [email], [password], [fullname], [phone], [address], [dob], [sex], [image], [status], [emailStatus]) VALUES (N'ME000002', N'giangnt', N'GiangNTSE150746@fpt.edu.vn', N'123456', N'Nguyễn Trường Giang', N'0838382196', N'nowhere', CAST(N'2001-11-01' AS Date), N'M', N'defaultAvatar.jpg', 1, 1)
GO
INSERT [dbo].[users] ([userID], [username], [email], [password], [fullname], [phone], [address], [dob], [sex], [image], [status], [emailStatus]) VALUES (N'ME000003', N'inactive', N'saoranngu@gmail.com', N'123456', N'Need Email Verification', N'0123321123', N'nowhere', CAST(N'2001-01-01' AS Date), N'F', N'defaultAvatar.jpg', 1, 1)
GO
INSERT [dbo].[users] ([userID], [username], [email], [password], [fullname], [phone], [address], [dob], [sex], [image], [status], [emailStatus]) VALUES (N'ME000004', N'phongnt', N'PhongNTSE150974@fpt.edu.vn', N'123456', N'Nguyễn Trần Phong', N'0123456787', N'nowhere', CAST(N'2001-01-01' AS Date), N'M', N'defaultAvatar.jpg', 1, 1)
GO
INSERT [dbo].[users] ([userID], [username], [email], [password], [fullname], [phone], [address], [dob], [sex], [image], [status], [emailStatus]) VALUES (N'MT000001', N'anhnt', N'AnhNTSE150633@fpt.edu.vn', N'123456', N'Nguyễn Tuấn Anh', N'0123456789', N'nowhere', CAST(N'2001-09-26' AS Date), N'M', N'defaultAvatar.jpg', 1, 1)
GO
INSERT [dbo].[users] ([userID], [username], [email], [password], [fullname], [phone], [address], [dob], [sex], [image], [status], [emailStatus]) VALUES (N'MT000005', N'phucvvt', N'PhucVVTSE150980@fpt.edu.vn', N'123456', N'Võ Văn Thanh Phúc', N'0123456788', N'nowhere', CAST(N'2001-01-01' AS Date), N'M', N'defaultAvatar.jpg', 1, 1)
GO
ALTER TABLE [dbo].[comments]  WITH CHECK ADD  CONSTRAINT [FK_comments_users] FOREIGN KEY([menteeID])
REFERENCES [dbo].[users] ([userID])
GO
ALTER TABLE [dbo].[comments] CHECK CONSTRAINT [FK_comments_users]
GO
ALTER TABLE [dbo].[comments]  WITH CHECK ADD  CONSTRAINT [FK_comments_users1] FOREIGN KEY([mentorID])
REFERENCES [dbo].[users] ([userID])
GO
ALTER TABLE [dbo].[comments] CHECK CONSTRAINT [FK_comments_users1]
GO
ALTER TABLE [dbo].[followers]  WITH CHECK ADD  CONSTRAINT [FK_followers_users] FOREIGN KEY([menteeID])
REFERENCES [dbo].[users] ([userID])
GO
ALTER TABLE [dbo].[followers] CHECK CONSTRAINT [FK_followers_users]
GO
ALTER TABLE [dbo].[followers]  WITH CHECK ADD  CONSTRAINT [FK_followers_users1] FOREIGN KEY([mentorID])
REFERENCES [dbo].[users] ([userID])
GO
ALTER TABLE [dbo].[followers] CHECK CONSTRAINT [FK_followers_users1]
GO
ALTER TABLE [dbo].[mentorSkills]  WITH CHECK ADD  CONSTRAINT [FK_mentorSkills_mentorDetails] FOREIGN KEY([mentorID])
REFERENCES [dbo].[mentorDetails] ([mentorID])
GO
ALTER TABLE [dbo].[mentorSkills] CHECK CONSTRAINT [FK_mentorSkills_mentorDetails]
GO
ALTER TABLE [dbo].[mentorSkills]  WITH CHECK ADD  CONSTRAINT [FK_mentorSkills_skills] FOREIGN KEY([SkillID])
REFERENCES [dbo].[skills] ([skillID])
GO
ALTER TABLE [dbo].[mentorSkills] CHECK CONSTRAINT [FK_mentorSkills_skills]
GO
ALTER TABLE [dbo].[requests]  WITH CHECK ADD  CONSTRAINT [FK_requests_users] FOREIGN KEY([menteeID])
REFERENCES [dbo].[users] ([userID])
GO
ALTER TABLE [dbo].[requests] CHECK CONSTRAINT [FK_requests_users]
GO
ALTER TABLE [dbo].[requests]  WITH CHECK ADD  CONSTRAINT [FK_requests_users1] FOREIGN KEY([mentorID])
REFERENCES [dbo].[users] ([userID])
GO
ALTER TABLE [dbo].[requests] CHECK CONSTRAINT [FK_requests_users1]
GO
USE [master]
GO
ALTER DATABASE [HappyProgramming] SET  READ_WRITE 
GO
