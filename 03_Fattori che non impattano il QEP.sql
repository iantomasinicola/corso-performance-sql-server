------------------------------------------------
--Fattori che non influenzano le performance:
--posizione dei filtri
------------------------------------------------

USE Gestionale;
--Estrarre il numero di fatture con spedizione maggiore
--di 1 euro e associate a clienti che si chiamano
--Nicola

SELECT *
FROM  (
	   SELECT * 
	   FROM   dbo.Fatture 
	   WHERE  spedizione>1 ) as a
INNER JOIN
	  (
	   SELECT * 
	   FROM   dbo.Clienti 
	   WHERE  nome = 'Nicola'
	  ) as b
	on a.IdCliente = b.IdCliente;


SELECT * 
FROM   dbo.Fatture as f
INNER JOIN dbo.Clienti as c
  ON f.idcliente = c.idcliente
WHERE  c.Nome = 'Nicola' 
   AND f.Spedizione>1;

--Con questo esempio vediamo come l'ordine
--scelto da Sql Server per eseguire i filtri
--nella where non è in generale quello scritto
--nel codice
SELECT *
FROM   dbo.Clienti
where  CONVERT(INT, Regione)=1 
   AND Nome = 'Adamo';

--Anche se uso una subquery
SELECT * 
FROM   
   (
	SELECT *
	FROM   dbo.Clienti
	WHERE  CONVERT(INT,regione)=1
    ) as a
WHERE  Nome ='Adamo';

--anche se uso una CTE
WITH CTE AS(
	SELECT *
	FROM   dbo.Clienti
	WHERE  CONVERT(INT,regione)=1
    )
SELECT *
FROM   CTE
WHERE  Nome ='Adamo';

--ATTENZIONE: non ha senso ripetere l'esperimento
--con la left join perché avrei due query 
--completamente diverse, con risultati diversi
