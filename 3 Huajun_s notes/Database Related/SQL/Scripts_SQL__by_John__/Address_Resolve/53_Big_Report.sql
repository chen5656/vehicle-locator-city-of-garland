	set termout	off;
	set echo	off;
	set timing	off;

	set termout	off;
	select '*** build reports ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	============================================================================================

	@c:\deacutis\scripts\address_resolve\reports\make_report\A1_Summary.sql;

--	============================================================================================

	@c:\deacutis\scripts\address_resolve\reports\51_Name_Report.sql;

--	============================================================================================

	@c:\deacutis\scripts\address_resolve\reports\make_report\S1_Add_Prefix.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\S1_Add_Suffix.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\S1_Add_Type.sql;


	@c:\deacutis\scripts\address_resolve\reports\make_report\S2_Change_Prefix.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\S2_Change_Suffix.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\S2_Change_Type.sql;


	@c:\deacutis\scripts\address_resolve\reports\make_report\S3_Remove_Prefix.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\S3_Remove_Suffix.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\S3_Remove_Type.sql;

--	============================================================================================
/*
	@c:\deacutis\scripts\address_resolve\reports\make_report\V10_No_Number.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V20_Bad_Block.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V30_Bad_Range.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V40_Good_Range.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V50_Good_Number.sql;

*/
--	============================================================================================
--	============================================================================================
/*

	spool c:\deacutis\scripts\address_resolve\reports\report_possible_address1.sql;
	@c:\deacutis\scripts\address_resolve\list_possible_address1.sql;
	spool off;

	spool c:\deacutis\scripts\address_resolve\reports\report_possible_range1.sql;
	@c:\deacutis\scripts\address_resolve\list_possible_range1.sql;
	spool off;

	spool c:\deacutis\scripts\address_resolve\reports\report_segment_gap.sql;
	@c:\deacutis\scripts\address_resolve\list_segment_gap.sql;
	spool off;
	
	@c:\deacutis\scripts\address_resolve\list_address_gap.sql;

	@c:\deacutis\scripts\address_resolve\list_number_permute.sql;

	@c:\deacutis\scripts\address_resolve\list_possible_alteration.sql;

	set termout	on;

--	============================================================================================

--	@c:\deacutis\scripts\address_resolve\list_completed_address.sql;
--	@c:\deacutis\scripts\address_resolve\list_altered_address.sql;

--	spool	c:\deacutis\scripts\address_resolve\reports\report_parse_qualifier.sql;
--	@c:\deacutis\scripts\address_resolve\list_parse_qualifier.sql;
--	spool off;

*/
--	============================================================================================
	
	set termout		on;
