USE Publication

SELECT id, name
FROM article
WHERE anotation LIKE '%�������� �����1%%�������� �����2%';

SELECT journal.id, journal.name
FROM journal JOIN release ON journal.id = release.idJournal
JOIN article ON release.id = article.idRelease
JOIN author_article ON article.id = author_article.idArticle
JOIN author ON author_article.idAuthor = author.id
WHERE author.surname LIKE '������������ �����' AND author.firstname LIKE '������������ �����' AND author.patronymic LIKE '������������ �����';