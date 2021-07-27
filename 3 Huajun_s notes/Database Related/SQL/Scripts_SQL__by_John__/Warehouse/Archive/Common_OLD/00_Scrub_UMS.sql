	set echo 	off;
	set timing	off;
    set linesize	2000;
--	------------------------------------------------------------------------------------------
	select '*** Full Address Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
--	------------------------------------------------------------------------------------------

--	------------------------------------------------------------------------------------------
--	CHOOSE PROCESSING OPTIONS (RULE)

	@c:\deacutis\scripts\address_resolve\rules\Rule_App_Full.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Safe_Full.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Risk_Full.sql;

--	------------------------------------------------------------------------------------------

	@c:\deacutis\scripts\address_resolve\views\vw_UMS_LOCATION.sql;

	@c:\deacutis\scripts\address_resolve\user_exits\01_DEFAULT_UNPARSED_EXIT.sql;
	@c:\deacutis\scripts\address_resolve\user_exits\01_DEFAULT_PARSED_EXIT.sql;

--	------------------------------------------------------------------------------------------

	@c:\deacutis\scripts\address_resolve\jobs\002_Load_Table.sql;

	@c:\deacutis\scripts\address_resolve\jobs\08_Main_Run.sql;

--	------------------------------------------------------------------------------------------
 
	@c:\deacutis\scripts\address_resolve\50_Base_Report.sql;

	@c:\deacutis\scripts\address_resolve\51_Name_Report.sql;

	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Parse_Sample.sql;

	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Street_Sample.sql;

	@c:\deacutis\scripts\address_resolve\Parse_Refine_Display.sql;

--	------------------------------------------------------------------------------------------
	select '*** Finish Full Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
--	------------------------------------------------------------------------------------------
	set echo 	on;
