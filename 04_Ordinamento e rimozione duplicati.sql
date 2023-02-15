----------------------------------------
--Aggiungiamo una distinct e un order by
--sulla colonna chiave primaria
SELECT NumeroCliente FROM dbo.Clienti;
SELECT DISTINCT NumeroCliente FROM dbo.Clienti;
SELECT NumeroCliente FROM dbo.Clienti ORDER BY NumeroCliente;
SELECT DISTINCT NumeroCliente FROM dbo.Clienti ORDER BY NumeroCliente;

--Aggiungiamo una distinct e un order by
--su una colonna con indice
SELECT Nome FROM dbo.Clienti;
SELECT DISTINCT Nome FROM dbo.Clienti;
SELECT Nome FROM dbo.Clienti ORDER BY Nome;
SELECT DISTINCT Nome FROM dbo.Clienti ORDER BY Nome;

--Aggiungiamo una distinct e un order by
--su una colonna senza indice
SELECT Cognome FROM dbo.Clienti;
SELECT DISTINCT Cognome FROM dbo.Clienti;
SELECT Cognome FROM dbo.Clienti ORDER BY Cognome;
SELECT DISTINCT Cognome FROM dbo.Clienti ORDER BY Cognome;

--con la group by il comportamento è analogo,
--attenzione però a cosa inseriamo nella select perché
--potremmo perdere i vantaggi dati dalla presenza di un indice
SELECT Nome, COUNT(*) FROM dbo.Clienti GROUP BY Nome;
SELECT Nome, COUNT(numerocliente) FROM dbo.Clienti GROUP BY Nome;
SELECT Nome, COUNT(Cognome) FROM dbo.Clienti GROUP BY Nome;
SELECT Cognome, COUNT(*) FROM dbo.Clienti GROUP BY Cognome;