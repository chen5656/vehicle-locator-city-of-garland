




	spool c:\deacutis\scripts\ora_create\Script_Analyze.sql;

	select 'analyze table ' || schema_ ||'.'|| key_ || '   compute statistics;'		" "
	from	tmp_view
	where	type_ = 'table';

	spool off;

