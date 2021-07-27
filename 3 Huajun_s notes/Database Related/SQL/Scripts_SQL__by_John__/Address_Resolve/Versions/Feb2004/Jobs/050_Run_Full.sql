	set echo 	off;
	set timing	off;
--	------------------------------------------------------------------------------------------
	select '*** Full Address Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
--	------------------------------------------------------------------------------------------

	@c:\deacutis\scripts\address_resolve\jobs\001_Table_View.sql;

	@c:\deacutis\scripts\address_resolve\jobs\002_Load_Table.sql;

--	------------------------------------------------------------------------------------------

--	@c:\deacutis\scripts\address_resolve\rules\Rule_Safer_Full.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Safe_Full.sql;
	@c:\deacutis\scripts\address_resolve\rules\Rule_Norm_Full.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Risk_Full.sql;

--	@c:\deacutis\scripts\address_resolve\rules\Rule_App_Full.sql;		-- Alpha5

--	------------------------------------------------------------------------------------------

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

