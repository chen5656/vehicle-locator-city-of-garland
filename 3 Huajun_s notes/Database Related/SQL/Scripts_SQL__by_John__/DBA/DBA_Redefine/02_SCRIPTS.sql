
	set echo		off;
	set charwidth	100;

--	================================================================================
--	GENERATE RE-ORG SCRIPTS
--	================================================================================

	@c:\deacutis\scripts\ora_create\create_table_as.sql;			--	create tables as select
	spool off;


	@c:\deacutis\scripts\ora_create\create_index.sql;			--	create indexes
	spool off;


	@c:\deacutis\scripts\ora_create\create_constraint.sql;		--	create constraints
	spool off;


	@c:\deacutis\scripts\ora_create\create_foreign.sql;			--	create foreign keys
	spool off;


	@c:\deacutis\scripts\ora_create\create_trigger.sql;			--	create triggers
	spool off;


	@c:\deacutis\scripts\ora_create\create_grant.sql;			--	create grants
	spool off;


	@c:\deacutis\scripts\ora_create\create_drop.sql;			--	drop tables


	@c:\deacutis\scripts\ora_create\create_rename.sql;			--	rename tables


	@c:\deacutis\scripts\ora_create\create_analyze.sql;			--	analyze tables


--	================================================================================
--	GENERATE RE-ORG SCRIPTS
--	================================================================================
/*
	@d:\scripts\ora_create\NEW\create_table_as.sql;			--	create tables as select


	@d:\scripts\ora_create\NEW\create_index.sql;			--	create indexes


	@d:\scripts\ora_create\NEW\create_constraint.sql;		--	create constraints


	@d:\scripts\ora_create\NEW\create_foreign.sql;			--	create foreign keys


	@d:\scripts\ora_create\NEW\create_trigger.sql;			--	create triggers
	spool off;


	@d:\scripts\ora_create\NEW\create_grant.sql;			--	create grants
	spool off;


	@d:\scripts\ora_create\NEW\drop_table.sql;			--	drop tables


	@d:\scripts\ora_create\NEW\rename_table.sql;			--	rename tables


	@d:\scripts\ora_create\NEW\create_analyze.sql;			--	analyze tables

*/
--	================================================================================
