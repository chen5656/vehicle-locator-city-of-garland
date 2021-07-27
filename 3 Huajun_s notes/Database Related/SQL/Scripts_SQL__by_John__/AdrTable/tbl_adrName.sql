
--	CREATE ADRNAME TABLE FROM ADRSTREET TABLE

--	========================================================

	DROP TABLE		ADRNAME;

	CREATE TABLE	ADRNAME		
	tablespace	gis_data
	storage (initial 32k  next 32k  pctincrease 0 )

	AS	
	SELECT	DISTINCT

			ADDR_NAME,
			ADDR_COMPRESS,
			ADDR_COMPACT,
			ADDR_REDUCED,
			ADDR_ENDING,
			ADDR_SOUNDEX,
			ADDR_PERMUTE,
			SYSDATE			"DATE_CREATED"

	FROM		ADRSTREET
	;

--	========================================================

ALTER TABLE		ADRNAME
ADD
(
	CONSTRAINT	ADRNAME_PKEY	
	PRIMARY KEY	(ADDR_NAME)
);



--	========================================================

CREATE INDEX	ADRNAME_X_SOUNDEX
	 ON 		ADRNAME
			(ADDR_SOUNDEX)
	tablespace	gisindx
	storage	(initial 1m  next 1m  pctincrease 0);


CREATE INDEX	ADRNAME_X_COMPRESS
	 ON 		ADRNAME
			(ADDR_COMPRESS)
	tablespace	gisindx
	storage	(initial 1m  next 1m  pctincrease 0);


CREATE INDEX	ADRNAME_X_COMPACT
	 ON 		ADRNAME
			(ADDR_COMPACT)
	tablespace	gisindx
	storage	(initial 1m  next 1m  pctincrease 0);


CREATE INDEX	ADRNAME_X_PERMUTE
	 ON 		ADRNAME
			(ADDR_PERMUTE)
	tablespace	gisindx
	storage	(initial 1m  next 1m  pctincrease 0);

--	========================================================

SELECT	*
FROM		ADRNAME
WHERE		ROWNUM < 11
;


SELECT	COUNT(*)
FROM		ADRNAME
;

--	========================================================
