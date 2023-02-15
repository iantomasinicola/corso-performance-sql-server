----------------------------------------
--Covered Index e indici su più colonne
----------------------------------------

Use Gestionale;


--Supponiamo di aver bisogno nella select anche della colonna
--DataFattura
SELECT F.IdFattura, F.DataFattura, C.*
FROM   dbo.Fatture as F
INNER JOIN dbo.Clienti as C
	on F.IdCliente = C.IdCliente;

--Creiamo un indice con la clausola INCLUDE
CREATE INDEX IX_IdCliente 
ON dbo.Fatture(IdCliente) 
INCLUDE (DataFattura)
WITH (DROP_EXISTING = ON);

SELECT F.IdFattura, F.DataFattura, C.*
FROM   dbo.Fatture as F
INNER JOIN dbo.Clienti as C
	on F.IdCliente = C.IdCliente;

--Cosa succede se utilizzo la colonna in un filtro?
SELECT F.IdFattura, F.DataFattura, C.*
FROM   dbo.Fatture as F
INNER JOIN dbo.Clienti as C
	on F.IdCliente = C.IdCliente
WHERE  F.DataFattura >= '20210205';

--Proviamo a creare un indice sulla coppia di colonne
CREATE INDEX IX_IdClienteDataFattura 
ON dbo.Fatture(IdCliente, DataFattura);

SELECT F.IdFattura, F.DataFattura, C.*
FROM   dbo.Fatture as F
INNER JOIN dbo.Clienti as C
	on F.IdCliente = C.IdCliente
WHERE  F.DataFattura >= '20210205';

--Siccome l'indice non viene utilizzato posso eliminarlo
DROP INDEX IX_IdClienteDataFattura ON dbo.Fatture;

--Cosa succede se creo l'indice con le colonne invertite
CREATE INDEX IX_DataFatturaIdCliente 
ON dbo.Fatture(DataFattura,IdCliente);

--Non viene utilizzato
SELECT F.IdFattura, F.DataFattura, C.*
FROM   dbo.Fatture as F
INNER JOIN dbo.Clienti as C
	on F.IdCliente = C.IdCliente
WHERE  F.DataFattura >= '20210205';

--Proviamo a cambiare query modificando il filtro
SELECT F.IdFattura, F.DataFattura, C.*
FROM   dbo.Fatture as F
INNER JOIN dbo.Clienti as C
	on F.IdCliente = C.IdCliente
WHERE  F.DataFattura = '20210205';

--Viene utilizzato solo per quel che 
--riguarda la ricerca della dataFattura

DROP INDEX IX_DataFatturaIdCliente ON dbo.Fatture;

CREATE INDEX IX_DataFattura 
ON dbo.Fatture(DataFattura);

SELECT F.IdFattura, F.DataFattura, C.*
FROM   dbo.Fatture as F
INNER JOIN dbo.Clienti as C
	on F.IdCliente = C.IdCliente
WHERE  F.DataFattura = '20210205';
