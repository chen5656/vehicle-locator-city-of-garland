
	set echo	off;

--	analyze all tables that have been re-org'd

--	================================================================================
/*
	spool c:\deacutis\scripts\ora_create\Script_Analyze.sql;
	select 'analyze table ' || schema_ ||'.'|| key_ || '   compute statistics;'		" "
	from	tmp_view
	where	tablespace_ = '=table=';
	spool off;
*/
--	================================================================================

	@c:\deacutis\scripts\ora_create\Script_Analyze.sql;

--	================================================================================


	
	
