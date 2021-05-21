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

create function [dbo].[author] (@id int, @surname nvarchar(50), @firstname nvarchar(50), @patronymic nvarchar(50), @articlename nvarchar(50))
returns id
with execute as caller
as
begin
	declare @idAuthor int = (select [id] from author where [surname] = @surname and [firstname] = @firstname and [patronymic] = @patronymic, 
	[articlename] = @articlename)
	Select 
	From author Join author_article On author.id =author_article.idAuthor Join article On author_article.idArticle = article.id;
	return (@idAuthor)
end

create function [dbo].[article] (@id int, @name nvarchar(50), @authorsurname nvarchar(50), @authorfirstname nvarchar(50), @authorpatronymic nvarchar(50))
return id
with execute as caller
as
begin
	declare @idArticle int = (select [id] from article where [authorsurname] = @authorsurname and [authorfirstname] = @authorfirstname and 
	[@authorpatronymic] = @authorpatronymic)
	return (@idArticle)
end

create function [dbo].[journal] (@name nvarchar(50), @articlename nvarchar(50))
returns nvarchar(50)
with execute as caller
as
begin
	declare @name nvarchar(50) = (select [nvarchar] from journal where [name] = @name and [authorname] = @authorname)
	return (@name)
end