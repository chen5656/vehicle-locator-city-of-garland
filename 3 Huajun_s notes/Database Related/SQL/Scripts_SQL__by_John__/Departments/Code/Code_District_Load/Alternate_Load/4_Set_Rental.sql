--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================
--	set jdeacutis is_rental = garland is_rental
--	=====================================================================

--    analyze table jdeacutis.code_district  compute statistics;
--    analyze table garland.code_district  compute statistics;

--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
	explain plan set statement_id = 'aaa '	into jdeacutis.plan_table for
--	=====================================================================
	update jdeacutis.code_district    J
	set is_rental = 
(
	select is_rental
	from   garland.code_district		G
	where	 g.parcel_id = j.parcel_id
);

	COMMIT;

	update jdeacutis.code_district    J
	set is_rental = 0
	where is_rental is null;

	COMMIT;

--	=====================================================================
	select * from jdeacutis.explain_Plan;

--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('JDEACUTIS', '');
--	delete   from jdeacutis.plan_table where object_name like 'SDE%' or object_name like 'GDB%';

--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;

--	select * from jdeacutis.explain_Table;
--	select * from jdeacutis.explain_Index;
--	select * from jdeacutis.explain_Constraint;
--	select * from jdeacutis.explain_Dependent;
--	select * from jdeacutis.explain_Column;
--	=====================================================================