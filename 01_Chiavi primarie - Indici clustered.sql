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

