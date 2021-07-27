--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================
   
	truncate table	garland.gis_Temp2	reuse storage;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================
	insert --+ append
	into	garland.view_Valve_Master
	select 
		x1 || y1		Node_ID,
		featureid		Valve_ID,
		featurename		Valve_Name
	from	gis.feature_coordinates
	where	featureclass = 'WTVA'
	order by featureid;

	Commit;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;

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

