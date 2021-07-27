	set echo on;

--	=========================================================================
--	DROP ORIGINAL TABLE

	@c:\deacutis\scripts\ora_create\SCRIPT_DROP.sql;

--	@d:\scripts\ora_create\SCRIPT_DROP.sql;

--	=========================================================================
--	RENAME TO ORIGINAL TABLE

	@c:\deacutis\scripts\ora_create\SCRIPT_RENAME.sql;

--	@d:\scripts\ora_create\SCRIPT_RENAME.sql;



	set echo off;

--	=========================================================================
--	CREATE ORIGINAL INDEXES 

	@c:\deacutis\scripts\ora_create\SCRIPT_INDEX.sql;

--	@d:\scripts\ora_create\SCRIPT_INDEX.sql;

--	=========================================================================
--	CREATE ORIGINAL CONSTRAINTS

	@c:\deacutis\scripts\ora_create\SCRIPT_CONSTRAINT.sql;

--	@d:\scripts\ora_create\SCRIPT_CONSTRAINT.sql;

--	=========================================================================
--	CREATE FOREIGN KEYS

	@c:\deacutis\scripts\ora_create\SCRIPT_FOREIGN.sql;

--	@d:\scripts\ora_create\SCRIPT_FOREIGN.sql;

--	=========================================================================
--	CREATE TRIGGERS

	@c:\deacutis\scripts\ora_create\SCRIPT_TRIGGER.sql;

--	@d:\scripts\ora_create\SCRIPT_TRIGGER.sql;

--	=========================================================================
--	CREATE GRANTS

	@c:\deacutis\scripts\ora_create\SCRIPT_GRANT.sql;

--	@d:\scripts\ora_create\SCRIPT_GRANT.sql;

--	=========================================================================
