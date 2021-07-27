
--	DETERMINE WHICH DCAD_TAX_UB RECORDS ARE RENTAL PROPERTY
--	BY FINDING OWNERS WITH DIFFERENT LAST NAMES FROM OCCUPANTS
--	DEFINE SUBSETS BY ADDR_NAME RANGES A-L & M-Z
--	developed for Chris Gorham


set	charwidth	150
set	timing	on;
--set	termout	off;

	spool	C:\DEACUTIS\EXTRACT\GORHAM1.TXT	ADDR_NAME <  'M'
--	spool	C:\DEACUTIS\EXTRACT\GORHAM2.TXT	ADDR_NAME >= 'M'


--TRUNCATE TABLE	PLAN_TABLE;
--EXPLAIN PLAN	SET STATEMENT_ID = 'TEST'	FOR


	SELECT	COUNT(*)			--	COUNT = 13139 FOR COMPRESS NAMES
							--	COUNT = 14001 FOR SOUNDEX  NAMES

/*
SELECT
	ADDR_NUM	||';'||                      
	ADDR_PFX	||';'||                      
	ADDR_NAME	||';'||                     
	ADDR_TYPE	||';'||                     
	ADDR_SFX	||';'||                      
	OWNER		||';'||                         
	TAX_ADDR	||';'||                      
	TAX_CITY	||';'||                      
	TAX_ST	||';'||                        
	TAX_ZIP     ||';'||
	OCCUPANT    ||';'||               
	DCAD_ACCT	||';'||                     
	PARCEL_ID                     
*/

	FROM		DCAD_TAX_UB
	WHERE		DCAD_ACCT		IN

(
	SELECT 	DCAD_ACCT
	FROM		DCAD_TAX_UB


---- 	COMPARE SOUNDEX LAST NAMES									
--	WHERE	SOUNDEX (SUBSTR ( OWNER, 01, 	  INSTR (OWNER    || ' ', ' ') -01))  	
--	<>	SOUNDEX (SUBSTR ( OCCUPANT, 04, INSTR (OCCUPANT || ' ', ' ', 04) -04))

		
----  COMPARE COMPRESSED LAST NAMES									
--	WHERE	ADR_COMPRESS_NAME (SUBSTR ( OWNER, 01, 	INSTR (OWNER    || ' ', ' ') -01), 09)  	
--	<>	ADR_COMPRESS_NAME (SUBSTR ( OCCUPANT, 04, INSTR (OCCUPANT || ' ', ' ', 04) -04), 09)


--	WHEN OCCUPANT NAME HAS NO INITIALS, DO NOT SKIP FIRST 2 CHARACTERS
	AND	SUBSTR ( OWNER, 01,    INSTR (OWNER    || ' ', ' ') - 01) 
	 <> 	SUBSTR ( OCCUPANT, 01, INSTR (OCCUPANT || ' ', ' ') - 01)


--	AND	ADDR_NAME <  'M'
--	AND	ADDR_NAME >= 'M'

)
	ORDER BY	ADDR_NAME,
			ADDR_TYPE,
			ADDR_PFX,
			ADDR_NUM;


--@C:\DEACUTIS\SCRIPTS\PLANS\EXHIBIT.SQL

	spool 	off;
set	termout	on;
set	timing	off;
set	charwidth	80
