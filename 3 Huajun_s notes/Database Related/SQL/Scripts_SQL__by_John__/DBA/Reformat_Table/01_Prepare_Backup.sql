	set echo	off;
--	=======================================================
--	Do each step separately
--	Verify each step before continuing
--	=======================================================
--	STEP 1	

--	Specify Table Synonyms		\\80_Synonyms.sql

--	=======================================================
--	STEP 2

	@c:\deacutis\scripts\dba\Reformat_Table\80_Synonyms.sql;

	@c:\deacutis\scripts\dba\Reformat_Table\21_Copy_To_Script.sql;

--	Verify Script	\\scripts\Execute_1.sql;	

--	=======================================================
	set echo	on;
