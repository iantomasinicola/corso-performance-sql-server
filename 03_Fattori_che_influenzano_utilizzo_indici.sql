--********************************************
--LEZIONE 1: INDICI E PIANI DI ESECUZIONE
--********************************************
CREATE DATABASE QEP;
GO
USE QEP;
GO

---------------------------------
--Lettura e ricerca di dati
---------------------------------

--Creiamo una tabella e popoliamola con qualche riga
CREATE TABLE dbo.Clienti (NumeroCliente INT   NOT NULL, 
					      Nome varchar(50)    NOT NULL, 
					      Cognome varchar(50) NOT NULL);

INSERT INTO dbo.Clienti (NumeroCliente,Nome,Cognome)
VALUES ( 1,'Nicola','Iantomasi'),
	   (2,'Giovanni','Rossi'), 
	   (3,'Alberto','Verdi');

/*Analizziamo i piani di esecuzione di queste tre query
Per attivare la visualizzazione del piano di esecuzione effettivo
cliccare su "Includi piano di esecuzione effettivo" 
(oppure CTRL + M)*/

SELECT * FROM dbo.Clienti;
SELECT * FROM dbo.Clienti WHERE Nome = 'Nicola';
SELECT * FROM dbo.Clienti WHERE NumeroCliente = 1;

--Aggiungiamo una chiave primaria
ALTER TABLE    dbo.Clienti 
ADD CONSTRAINT ChiavePrimaria 
PRIMARY KEY    (NumeroCliente);

--Analizziamo come sono cambiati i piani di esecuzione 
--delle tre query precedenti
SELECT * FROM dbo.Clienti ;
SELECT * FROM dbo.Clienti WHERE Nome = 'Nicola';
SELECT * FROM dbo.Clienti WHERE NumeroCliente = 1;

--Aggiungiamo un indice sulla colonna nome
CREATE INDEX IX_clienti_nome ON dbo.Clienti(Nome);

--Rilanciamo le tre query precedenti
SELECT * FROM dbo.Clienti; 
SELECT * FROM dbo.Clienti WHERE Nome = 'Nicola';
SELECT * FROM dbo.Clienti WHERE NumeroCliente = 1;

--Modifichiamo la clausola SELECT
SELECT NumeroCliente, Nome FROM dbo.Clienti ;
SELECT NumeroCliente, Nome FROM dbo.Clienti WHERE Nome = 'Nicola';
SELECT NumeroCliente, Nome FROM dbo.Clienti WHERE NumeroCliente = 1;


--Aggiungiamo nuove righe tutte con lo stesso valore nella
--colonna nome
INSERT INTO Clienti (NumeroCliente, Nome, Cognome)
SELECT 3 + ROW_NUMBER() OVER(ORDER BY (SELECT NULL)),'Nicola','Rossi' 
FROM   sys.objects a CROSS JOIN sys.objects b;

--Analizziamo nuovamente i QEP
SELECT * FROM dbo.Clienti WHERE Nome = 'Nicola' ;
SELECT * FROM dbo.Clienti WHERE Nome = 'Giovanni'; 

--è possibile forzare l'utilizzo di un indice, ma 
--il risultato è il più delle volte pessimo
SELECT * 
FROM   dbo.Clienti 
WHERE  Nome = 'Nicola';

SELECT * 
FROM   dbo.Clienti WITH(INDEX(IX_clienti_nome)) 
WHERE  Nome = 'Nicola'; 


--Vediamo che invece la situazione cambia 
--se utilizzo delle variabili
DECLARE @Nome VARCHAR(50);
SET @Nome = 'Nicola' ;

SELECT * 
FROM   dbo.Clienti 
WHERE  Nome = @Nome;

SET @Nome = 'Giovanni' ;

SELECT * 
FROM   dbo.Clienti 
WHERE  Nome = @Nome;


--Con le procedure il comportamento 
--è ancora differente.
--Anticipiamo il problema 
--del parameter sniffing
CREATE PROCEDURE dbo.Ricerca 
@ParNome varchar(250)
AS 
SELECT * 
FROM   dbo.Clienti 
WHERE  Nome = @ParNome;

EXEC dbo.Ricerca @ParNome = 'Nicola';
EXEC dbo.Ricerca @ParNome = 'Giovanni';

--Diverso invece è il comportamento delle 
--viste parametrice (inline table value function)
CREATE FUNCTION dbo.VistaRicerca (@ParNome as varchar(50))
RETURNS TABLE 
AS RETURN
SELECT * 
FROM   dbo.Clienti 
WHERE  Nome = @ParNome;
	
SELECT * FROM dbo.VistaRicerca('Nicola');
SELECT * FROM dbo.VistaRicerca('Giovanni'); 	

--ovviamente tutto viene perso se uso
--le variabili all'estero
DECLARE @nome varchar(50); 
SET @nome = 'Giovanni';

SELECT * FROM dbo.VistaRicerca(@nome);
