--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================

--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
	explain plan set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================
   
	truncate table	garland.gis_Temp1	reuse storage;

	insert --+ append
	into	garland.view_Parcel_Master
	select 
		Pipe_ID,
		Parcel_ID
	from	jdeacutis.Water_Parcel_Pipe_External
	order by pipe_id;

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

