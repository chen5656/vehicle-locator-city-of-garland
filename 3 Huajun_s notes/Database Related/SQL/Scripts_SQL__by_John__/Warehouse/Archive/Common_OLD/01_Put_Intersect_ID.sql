--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
-- set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	================================================================
--	===========================================================================
--	Assign Intersect ID's to each address in Common GIS
--	===========================================================================

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id =  'xxx'	into garland.plan_table	for
--	===========================================================================

	update	JDEACUTIS.Common_GIS		G
	set	  (	intersect_id1, intersect_id2  ) =
(
	select	min(item02), max(item03)
	from		garland.GIS_Objects		T
	where		item01 = rtrim(G.address_id)
);

	Commit;

--	===========================================================================
--	select * from garland.explain_Plan;
--	insert into   garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	===========================================================================

