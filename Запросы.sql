USE Publication

SELECT id, name
FROM article
WHERE anotation LIKE '%Ключевое слово№1%%Ключевое слово№2%';

SELECT journal.id, journal.name
FROM journal JOIN release ON journal.id = release.idJournal
JOIN article ON release.id = article.idRelease
JOIN author_article ON article.id = author_article.idArticle
JOIN author ON author_article.idAuthor = author.id
WHERE author.surname LIKE 'Определенный автор' AND author.firstname LIKE 'Определенный автор' AND author.patronymic LIKE 'Определенный автор';