--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
-- set pagesize	74;
-- set pagesize	57;
-- alter session set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	===========================================================================================

	select 'BUILD CORNER  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	Truncate table	garland.GIS_Temp1		reuse storage;

--	===========================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	insert --+ append
	into	garland.Temp_View1

	select
		s1.addr_name,
		s1.addr_type,
		s1.addr_pfx,	
		s1.addr_sfx,	
		s1.addr_blok,

		s2.addr_name,
		s2.addr_type,
		s2.addr_pfx,	
		s2.addr_sfx,	
		s2.addr_blok,

		s1.hub_node,	

		s1.fromto,	
		s2.fromto,	

		s1.x_vector,	
		s1.y_vector,	
		s2.x_vector,	
		s2.y_vector,

		(s1.x_vector * s2.y_vector) - (s2.x_vector * s1.y_vector)  vector_product

	from	garland.Temp_View3	S1,
		garland.Temp_View3	S2

	where	s1.hub_node   = s2.hub_node
	and	s1.road_id	 <> s2.road_id
	and (	s1.addr_name <> s2.addr_name
	or	s1.addr_type <> s2.addr_type )
	;

--	=================================================================================
--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

	Commit;

--	=================================================================================

