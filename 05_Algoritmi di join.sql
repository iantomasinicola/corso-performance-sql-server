--Analizziamo gli algoritmi di JOIN
USE GESTIONALE;

SELECT *
FROM   dbo.Fatture as F
INNER JOIN dbo.Clienti as C
	on F.IdCliente = C.IdCliente;



--Diminuendo ulteriormente il numero di righe 
--di clienti, sarà eseguita una nested join
SELECT *
FROM   dbo.Fatture as F
INNER JOIN dbo.Clienti as C
	ON F.IdCliente = C.IdCliente
WHERE  C.IdCliente = 1;


/*Possiamo forzare l'utilizzo di un particolare
algoritmo di join ma è (quasi) sempre meglio
far scegliere Sql Server

FROM   dbo.Fatture as F
INNER MERGE JOIN dbo.Clienti as C
INNER HASH JOIN dbo.Clienti as C
INNER LOOP JOIN dbo.Clienti as C

--Ad esempio
SELECT *
FROM   dbo.Fatture as F
INNER MERGE JOIN dbo.Clienti as C
	on F.IdCliente = C.IdCliente;

*/

--La merge join non è eseguita per via del costo
--dell'ordinamento. Potremmo pensare di evitare
--il sort creando un indice sulla colonna IdCliente
CREATE INDEX IX_IdCliente ON dbo.Fatture(IdCliente);

--Non cambia niente
SELECT *
FROM   dbo.Fatture as F
INNER JOIN dbo.Clienti as C
	on F.IdCliente = C.IdCliente;

--Ma modificando la select...
SELECT F.IdFattura, C.*
FROM   dbo.Fatture as F
INNER JOIN dbo.Clienti as C
	on F.IdCliente = C.IdCliente;


--Ma ogni regola ha un'eccezione
USE QEP

ALTER TABLE dbo.clienti 
ADD CHECK (nome in ('Alberto','Giovanni','Nicola'));

SELECT Nome, NumeroCliente 
FROM   dbo.Clienti 
WHERE  Nome = 'francesco';

SELECT * 
FROM   dbo.Clienti 
WHERE  Nome = 'francesco';
