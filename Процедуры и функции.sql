create proc [dbo].[article]
	@Id int, @a int
	as
begin
	update article set IsDeleted = 0 where Id = @Id; 
end
go
create proc [dbo].[AddNewArticle]
	@name nvarchar(150),
	@anotation nvarchar (50),
	@content text,
	@dateRelease date,
	@nomerRelease nvarchar(50)
	as
begin
	declare @idRelease int = (select id from release where [dateRelease] = @dateRelease and nomerRelease = @nomerRelease)
	insert into 
	article(idRelease, name, anotation, content)
	values (@idRelease, @name, @anotation, @content)
end


create proc [dbo].[AddNewAuthor]
	@name nvarchar(150),
    @authorid int
	as

begin
	declare @idArticle int = (select id from article where [name] = @name)
	insert into 
	author_article(idArticle, idAuthor)
	values (@idArticle, @authorid)
end

alter proc [dbo].[AddNewAuthor]
	@name nvarchar(150),
	@authorsurname nvarchar(50),
	@authorfirstname nvarchar(50),
	@authorpatronymic nvarchar(50)
	as

begin
	declare @idArticle int = (select id from article where [name] = @name)
	declare @idAuthor int = (select id from author where [firstname] = @authorfirstname and patronymic = @authorpatronymic and surname = @authorsurname)
	insert into 
	author_article(idArticle, idAuthor)
	values (@idArticle, @idAuthor)
end

create function [dbo].[author] (@id int, @surname nvarchar(50), @firstname nvarchar(50), @patronymic nvarchar(50))
returns id
with execute as caller
as
begin
	declare @AuthorId int = (
	Select top(1) author.id
	From author Join author_article On author.id =author_article.idAuthor Join article On author_article.idArticle = article.id
	Group By  author.id
	Order By Count(article.id) Desc)
	return (@AuthorId)
end

create function [dbo].[article] ()
returns int
with execute as caller
as
begin
		declare @ArticleName int = (select Count(article.name) As "Количество статей", journal.name, author.firstname,author.patronymic, author.surname
	from author Join author_article On author.id =author_article.idAuthor Join article On author_article.idArticle 
		= article.id Join release On article.idRelease
		= release.id Join journal On release.idJournal = journal.id
	Group By author.firstname, author.patronymic, author.surname, journal.name
	Order By COUNT(article.name) Desc)
	return(@ArticleName)
end

create function [dbo].[journal] ()
returns nvarchar(50)
with execute as caller
as
begin
	declare @JournalName nvarchar(50) = (
	select top(1) journal.name, article.name, count(article.name)
	from journal Join release On journal.id = release.idJournal Join article On article.idRelease = release.id
	group by journal.name, article.name
	order by count(article.name) desc)
	return (@JournalName)
end
