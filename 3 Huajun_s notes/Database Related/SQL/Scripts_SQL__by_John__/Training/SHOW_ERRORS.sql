

--		C:\ORANT\SCRIPTS\AdrVerify\SHOerrors.sql

--		DISPLAY PROCEDURE, FUNCTION, AND PACKAGE COMPILE ERRORS


--	===================================================================================
/*
	SELECT	*
	FROM		ALL_OBJECTS
	WHERE		OBJECT_NAME LIKE 	'ADR%'
	AND		OBJECT_TYPE	IN	( 'PROCEDURE', 'FUNCTION', 'PACKAGE', 'PACKAGE BODY')
	;
*/
--	===================================================================================


	SELECT
		 	RPAD (NAME,24)			"OBJECT NAME",
			TYPE					"OBJECT TYPE",
			LPAD (LINE,04)			"LINE",
			TEXT					"TEXT 1",	 
			SUBSTR(TEXT, 081, 80)		"TEXT 2" 

--			SUBSTR(TEXT, 161, 80)		"TEXT 3"

	FROM 		USER_ERRORS

	WHERE		NAME = 'SMP_VAB_SAVED_JOB'
	;
	

--	===================================================================================


