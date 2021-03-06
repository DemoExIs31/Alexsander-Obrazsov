USE [master]
GO
/****** Object:  Database [Publication]    Script Date: 17.05.2021 14:17:47 ******/
CREATE DATABASE [Publication]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Publication', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Publication.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Publication_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Publication_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Publication] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Publication].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Publication] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Publication] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Publication] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Publication] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Publication] SET ARITHABORT OFF 
GO
ALTER DATABASE [Publication] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Publication] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Publication] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Publication] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Publication] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Publication] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Publication] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Publication] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Publication] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Publication] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Publication] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Publication] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Publication] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Publication] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Publication] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Publication] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Publication] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Publication] SET RECOVERY FULL 
GO
ALTER DATABASE [Publication] SET  MULTI_USER 
GO
ALTER DATABASE [Publication] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Publication] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Publication] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Publication] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Publication] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Publication] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Publication', N'ON'
GO
ALTER DATABASE [Publication] SET QUERY_STORE = OFF
GO
USE [Publication]
GO
/****** Object:  Table [dbo].[article]    Script Date: 17.05.2021 14:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[article](
	[id] [int] NOT NULL,
	[idRelease] [int] NOT NULL,
	[name] [varchar](150) NOT NULL,
	[anotation] [varchar](50) NOT NULL,
	[content] [varchar](500) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_article] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TRIGGER [OnDeleted] on [article]
instead of delete as
update article set isDeleted = 1 where id = (select id from deleted)
GO
/****** Object:  Table [dbo].[author]    Script Date: 17.05.2021 14:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[author](
	[id] [int] NOT NULL,
	[surname] [varchar](50) NOT NULL,
	[firstname] [varchar](50) NOT NULL,
	[patronymic] [varchar](50) NULL,
	[position] [varchar](50) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_author] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TRIGGER [OnDeleted] on [author]
instead of delete as
update author set isDeleted = 1 where id = (select id from deleted)
GO
/****** Object:  Table [dbo].[author_article]    Script Date: 17.05.2021 14:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[author_article](
	[idArticle] [int] NOT NULL,
	[idAuthor] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_author_article] PRIMARY KEY CLUSTERED 
(
	[idArticle] ASC,
	[idAuthor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TRIGGER [OnDeleted] on [author_article]
instead of delete as
update author_article set isDeleted = 1 where idArticle = (select idArticle from deleted)
update author_article set isDeleted = 1 where idAuthor = (select idAuthor from deleted)
GO
/****** Object:  Table [dbo].[journal]    Script Date: 17.05.2021 14:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[journal](
	[id] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[address] [varchar](150) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_journal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TRIGGER [OnDeleted] on [journal]
instead of delete as
update journal set isDeleted = 1 where id = (select id from deleted)
GO
/****** Object:  Table [dbo].[release]    Script Date: 17.05.2021 14:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[release](
	[id] [int] NOT NULL,
	[idJournal] [int] NOT NULL,
	[dateRelease] [varchar](50) NOT NULL,
	[nomerRelease] [varchar](50) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_release] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TRIGGER [OnDeleted] on [release]
instead of delete as
update release set isDeleted = 1 where id = (select id from deleted)
go
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (1, 1, N'Правовая система Российской Федерации в условиях международной интеграции', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (2, 2, N'Методология, результаты и проблемы прогноза землетрясений', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (3, 3, N'Районирование ледяного покрова Охотского и Японского морей', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (4, 4, N'Обобщённый портрет академического диссертационного совета', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (5, 5, N'Использование генетических ресурсов для селекции инновационных сортов кормовых культур', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (6, 6, N'Перевод автотранспорта на газ: возможные проблемы', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (7, 7, N'Реакции синтеза — основной источник внутренней энергии Земли', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (8, 8, N'География и устойчивое развитие региона Каспийского моря', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (9, 9, N'Философские аспекты нейрофизиологии', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (10, 10, N'Пример успешной модернизации Европейского религиозного университета', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (11, 11, N'Первая мировая война и мобилизационная модель организации академической науки', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (12, 12, N'Третья конференция стран СНГ "Золь-гель 2014"', N'0', N'0', 0)
INSERT [dbo].[article] ([id], [idRelease], [name], [anotation], [content], [isDeleted]) VALUES (13, 13, N'География и устойчивое развитие региона Каспийского моря', N'0', N'0', 0)
GO
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (1, N'Хабриева', N'Татьяна', N'Яшкова', N'Старший редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (2, N'Соболев', N'Генадий', N'Андреев', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (3, N'Трусков', N'Петр', N'Александров', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (4, N'Покрашенко', N'Сергей', N'Александров', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (5, N'Романюк', N'Владимир', N'Александров', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (6, N'Пищальник', N'Виктор', N'Максимович', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (7, N'Минервин', N'Ильяз', N'Генадьевич', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (8, N'Пахомов', N'Сергей', N'Ильиничин', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (9, N'Гуртов', N'Владимир', N'Артемович', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (10, N'Щёголева', N'Лера', N'Викторовна', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (11, N'Шамсутдинов', N'Захар', N'Шамильев', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (12, N'Косолапов', N'Виктор', N'Максимович', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (13, N'Белан', N'Борис', N'Дмитриевич', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (14, N'Терез', N'Эдуард', N'Эдуардович', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (15, N'Пармон', N'Виталий', N'Никитович', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (16, N'Андреев', N'Игорь', N'Львович', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (17, N'Арефьев', N'Александр', N'Львович', N'Старший редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (18, N'Колчинский', N'Эдуард', N'Игоревич', N'Главный редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (19, N'Снытко', N'Виталий', N'Александрович', N'Редактор', 0)
INSERT [dbo].[author] ([id], [surname], [firstname], [patronymic], [position], [isDeleted]) VALUES (20, N'Тишков', N'Александр', N'Александрович', N'Редактор', 0)
GO
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (1, 1, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (2, 2, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (3, 3, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (4, 4, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (5, 5, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (6, 6, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (7, 7, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (8, 8, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (9, 9, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (10, 10, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (11, 11, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (12, 12, 0)
INSERT [dbo].[author_article] ([idArticle], [idAuthor], [isDeleted]) VALUES (13, 13, 0)
GO
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (1, N'0', N'107258, г. Александров, ул. Маяковского (Красносельский), дом 161, квартира 15', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (2, N'0', N'359024, г. Акъяр, ул. Куракина, дом 69, квартира 311', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (3, N'0', N'215656, г. Россошь, ул. Карачаровское ш, дом 98, квартира 706', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (4, N'0', N'142963, г. Фершампенуаз, ул. Стрельнинская, дом 25, квартира 107', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (5, N'0', N'142963, г. Фершампенуаз, ул. Стрельнинская, дом 25, квартира 107', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (6, N'0', N'623618, г. Рыльск, ул. Парголовский пер, дом 189, квартира 483', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (7, N'0', N'450961, г. Карсун, ул. Лассаля, дом 12, квартира 774', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (8, N'0', N'682364, г. Шенкурск, ул. Преображенская пл, дом 200, квартира 299', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (9, N'0', N'461227, г. Павловск, ул. Пихтовая, дом 196, квартира 347', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (10, N'0', N'461227, г. Павловск, ул. Пихтовая, дом 196, квартира 347', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (11, N'0', N'429073, г. Истра, ул. Кабельная 2-я, дом 22, квартира 679', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (12, N'0', N'624092, г. Междуреченск, ул. 1-я Конная Лахта, дом 23, квартира 906', 0)
INSERT [dbo].[journal] ([id], [name], [address], [isDeleted]) VALUES (13, N'0', N'142963, г. Фершампенуаз, ул. Стрельнинская, дом 25, квартира 107', 0)
GO
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (1, 1, N'10.апр
', N'1
', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (2, 2, N'25.июл
', N'2', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (3, 3, N'10.апр
', N'1', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (4, 4, N'25.июл
', N'2
', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (5, 5, N'25.июл
', N'2', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (6, 6, N'26.сен
', N'3', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (7, 7, N'26.сен
', N'3', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (8, 8, N'10.апр
', N'1', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (9, 9, N'25.июл
', N'2', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (10, 10, N'25.июл
', N'2', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (11, 11, N'26.сен
', N'3', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (12, 12, N'10.апр
', N'1', 0)
INSERT [dbo].[release] ([id], [idJournal], [dateRelease], [nomerRelease], [isDeleted]) VALUES (13, 13, N'26.сен
', N'3', 0)
GO
ALTER TABLE [dbo].[article] ADD  CONSTRAINT [DF_article_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[author] ADD  CONSTRAINT [DF_author_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[author_article] ADD  CONSTRAINT [DF_author_article_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[journal] ADD  CONSTRAINT [DF_journal_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[release] ADD  CONSTRAINT [DF_release_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[article]  WITH CHECK ADD  CONSTRAINT [FK_article_release] FOREIGN KEY([idRelease])
REFERENCES [dbo].[release] ([id])
GO
ALTER TABLE [dbo].[article] CHECK CONSTRAINT [FK_article_release]
GO
ALTER TABLE [dbo].[author_article]  WITH CHECK ADD  CONSTRAINT [FK_author_article_article] FOREIGN KEY([idArticle])
REFERENCES [dbo].[article] ([id])
GO
ALTER TABLE [dbo].[author_article] CHECK CONSTRAINT [FK_author_article_article]
GO
ALTER TABLE [dbo].[author_article]  WITH CHECK ADD  CONSTRAINT [FK_author_article_author] FOREIGN KEY([idAuthor])
REFERENCES [dbo].[author] ([id])
GO
ALTER TABLE [dbo].[author_article] CHECK CONSTRAINT [FK_author_article_author]
GO
ALTER TABLE [dbo].[release]  WITH CHECK ADD  CONSTRAINT [FK_release_journal] FOREIGN KEY([idJournal])
REFERENCES [dbo].[journal] ([id])
GO
ALTER TABLE [dbo].[release] CHECK CONSTRAINT [FK_release_journal]
GO
USE [master]
GO
ALTER DATABASE [Publication] SET  READ_WRITE 
GO
