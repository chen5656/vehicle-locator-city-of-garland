
CREATE TABLE ADDRESS_INSERT

(STNO 	NUMBER(5),
 PREFIX 	VARCHAR2(2),
 STREET 	VARCHAR2(20),
 STR_TYPE 	VARCHAR2(4),
 SUFFIX 	VARCHAR2(4),
 ZIP  	NUMBER(5),
 X_CORD 	NUMBER(13,5),
 Y_CORD 	NUMBER(13,5)
)

ORGANIZATION EXTERNAL
(TYPE ORACLE_LOADER
 DEFAULT DIRECTORY GIS_EX_DATA
 ACCESS PARAMETERS(
 RECORDS DELIMITED BY NEWLINE
 FIELDS TERMINATED BY ','
 MISSING FIELD VALUES ARE NULL
))
LOCATION ('Address_Insert.dat')
);


--	============================================================================================
/*
 
           (STNO 		CHAR(2),
            PREFIX      CHAR(2)		"decode(:prefix,null,' ',' ')",
            STREET 	CHAR(20),
            STR_TYPE 	CHAR(4),
            SUFFIX 	CHAR(2)		"decode(:suffix,null,' ',' ')",,
            ZIP 		CHAR(5),
            X_CORD 	CHAR(13),
            Y_CORD 	CHAR(13)

*/
--	============================================================================================
