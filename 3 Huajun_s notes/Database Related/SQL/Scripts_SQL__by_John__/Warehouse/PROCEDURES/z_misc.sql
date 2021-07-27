--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	=====================================================================

--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

--	=====================================================================
	select * from jdeacutis.explain_Plan;
	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

