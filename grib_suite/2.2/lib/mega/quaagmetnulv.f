c Copyright (C) 2000 

c Questo programma � software libero; � lecito ridistribuirlo e/o
c modificarlo secondo i termini della Licenza Pubblica Generica SMR come
c pubblicata da ARPA SMR ; o la versione 1 della licenza o (a scelta)
c una versione successiva.

c Questo programma � distribuito nella speranza che sia utile, ma SENZA
c ALCUNA GARANZIA; senza neppure la garanzia implicita di
c COMMERCIABILIT� o di APPLICABILIT� PER UN PARTICOLARE SCOPO. Si veda
c la Licenza Pubblica Generica SMR per avere maggiori dettagli.

c Ognuno dovrebbe avere ricevuto una copia della Licenza Pubblica
c Generica SMR insieme a questo programma; in caso contrario, la si pu�
c ottenere da Agenzia Regionale Prevenzione e Ambiente (ARPA) Servizio
c Meteorologico Regionale (SMR), Viale Silvani 6, 40122 Bologna, Italia





	SUBROUTINE QUAAGMETNULV(FLAG,IATT,IER)
COMSTART QUAAGMETNULV
C	SUBROUTINE QUAGMETNULV(FLAG,IATT,IER)

c	Routine per annullare i valori ritenuti errati in quanto hanno
c	superato nel contatore di errore quella che viene ritenuta la
c	soglia di accettabilita` del dato.
c	IATT e` questa soglia e il dato viene restituito mancante (32767)
c	se FLAG >= IATT.
c
C	INPUT:
c	FLAG(18)	BYTE	contatore di errore associato alle
c				18 variabili AGRMET
C	IATT		I*4	solglia di attendibilita` richiesta per dato
c				considerato errato (solitamente 2)
C	OUTPUT:
c	FLAG(18)	BYTE	azzerato se inizialmente uguale o superiore
c				a IATT per le 18 variabili AGRMET
c	IER		I*4	condizione di errore
c			IER=0	tutto O.K.
C			IER=1	tipo messaggio errato

c	COMMON /RRW/RRW
C	RRW(26)		I*2	RRW(26) per passare dati AGRMET come dichiarato
c				in LOC$inc:agrmet.inc
COMEND
	COMMON /RRW/RRW

	BYTE FLAG(18)
	INTEGER*2 RRW(26)
	INTEGER STAZ,DATA(2),ORA(2),TIPO

	ier=0

	CALL GETHEA (STAZ,DATA,ORA,TIPO,RRW)

	IF (TIPO.lt.12.or.tipo.gt.14)THEN
		IER=1
		RETURN
	END IF

	DO NVAR=7,24
	  IF (FLAG(NVAR-6).GE.IATT)THEN
		FLAG(NVAR-6)=0
		RRW(NVAR)=32767
	  END IF		
	END DO

	RETURN
	END