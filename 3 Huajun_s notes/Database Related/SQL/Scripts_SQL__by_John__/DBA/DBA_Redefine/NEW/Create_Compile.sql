
	spool c:\deacutis\scripts\ora_create\Script_Recompile.sql;

	select 'alter ' || object_type || ' ' || owner ||'.'|| object_name || ' compile;'		" "
	from	dba_objects
	where	status = 'INVALID'
	and	object_type <> 'PACKAGE BODY'; 

	spool off;

