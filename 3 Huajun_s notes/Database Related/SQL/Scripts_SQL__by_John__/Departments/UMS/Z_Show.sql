	set echo 		off;
	set timing		on;
	set charwidth	100;
	set serveroutput	on	size	99999;

--	=====================================================================
--	Display table columns having a specified value

--	Display includes message:  "ORA-00900 invalid SQL statement"	
--	IGNORE IT
--	=====================================================================

	set termout		off;
	spool	c:\deacutis\scripts\departments\ums\z_execute.sql;

	@c:\deacutis\scripts\departments\ums\z_test;

	spool off;

	set termout		on;
	@c:\deacutis\scripts\departments\ums\z_execute.sql;

--	=====================================================================
	set timing		off;
	set echo 		on;