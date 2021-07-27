	set echo	off;
	select '*** First Street Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
--	=======================================================================================================

	@c:\deacutis\scripts\address_resolve\jobs\06_Output_into_Input.sql;

	@c:\deacutis\scripts\address_resolve\rules\Rule_Norm_Street.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Risk_Street.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Safe_Street.sql;

	@c:\deacutis\scripts\address_resolve\jobs\08_Main_Run.sql;

	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Street_Sample.sql;

--	------------------------------------------------------------------------------------
/*
	select '	comment on table adrResult_Input  is ''' || comments
		 || 	'''; --	<<<<=====	EXECUTE'		" "
	from	 dba_tab_comments
	where	 table_name = 'GIS_VERIFY_ADDR';	
*/
--	=======================================================================================================
	select '*** Finish First Street Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
	set echo	on;
