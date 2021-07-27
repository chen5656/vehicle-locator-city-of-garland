	set echo	off;
--	=======================================================
--	STEP 1	

--	Specify Table Synonyms		\\90_Synonyms.sql

--	=======================================================
--	STEP 2

	@c:\deacutis\scripts\dba\Reformat_Table\90_Synonyms.sql;

	@c:\deacutis\scripts\dba\Reformat_Table\21_Copy_To_Script.sql;

	@c:\deacutis\scripts\dba\Reformat_Table\22_Copy_From_Script.sql;


--	=======================================================
--	STEP 3

--	Verify Script	\\scripts\Execute_1.sql;	
--	Verify Script	\\scripts\Executs_2.sql;

--	=======================================================
	set echo	on;
