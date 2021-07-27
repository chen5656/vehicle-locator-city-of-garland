	set echo	off;
--	===================================================================================
	select '*** Parse Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss')	" "  from dual;
--	===================================================================================

	@c:\deacutis\scripts\address_resolve\rules\Rule_Norm_Parse.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Safe_Parse.sql;

	@c:\deacutis\scripts\address_resolve\jobs\08_Main_Run.sql;

--	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Parse_Sample.sql;

--	@c:\deacutis\scripts\address_resolve\reports\make_report\N5_Alien_Name.sql;

	@c:\deacutis\scripts\address_resolve\Parse_Refine_Display.sql;
	@c:\deacutis\scripts\address_resolve\Parse_Refine_Update.sql;

--	===================================================================================
	select '*** Finish Parse Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "  from dual;
--	===================================================================================
	set echo	on;
