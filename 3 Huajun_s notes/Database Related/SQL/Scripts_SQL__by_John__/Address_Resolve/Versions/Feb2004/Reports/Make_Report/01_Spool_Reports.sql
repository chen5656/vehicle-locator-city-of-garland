	set echo	off;
--	=============================================================================================
--	Wrong & Partial Street Reports
--	=============================================================================================

	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V54_Partial_Address.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V54_Partial_Address.sql;
	spool off;


	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V44_Partial_Range.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V44_Partial_Range.sql;
	spool off;


	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V34_Partial_Block.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V34_Partial_Block.sql;
	spool off;


	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V24_Partial_Orphan.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V24_Partial_Orphan.sql;
	spool off;


	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V14_Partial_Street.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V14_Partial_Street.sql;
	spool off;

--	=============================================================================================

	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V53_Wrong_Address.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V53_Wrong_Address.sql;
	spool off;

	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V43_Wrong_Range.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V43_Wrong_Range.sql;
	spool off;

	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V33_Wrong_Block.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V33_Wrong_Block.sql;
	spool off;

--	=============================================================================================

	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V12_Mixed_Street.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V12_Mixed_Street.sql;
	spool off;

	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V22_Mixed_Orphan.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V22_Mixed_Orphan.sql;
	spool off;

	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V32_Mixed_Block.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V32_Mixed_Block.sql;
	spool off;

	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V42_Mixed_Range.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V42_Mixed_Range.sql;
	spool off;

	spool c:\deacutis\scripts\address_resolve\reports\Made_Report\V52_Mixed_Address.sql;
	@c:\deacutis\scripts\address_resolve\reports\Make_Report\V52_Mixed_Address.sql;
	spool off;

--	=============================================================================================
	set echo	on;
