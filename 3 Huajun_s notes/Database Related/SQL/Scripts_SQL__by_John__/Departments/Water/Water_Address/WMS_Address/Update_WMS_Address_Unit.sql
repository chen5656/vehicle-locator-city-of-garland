	set echo off;
--	=================================================================================
--	Populate Unit_Num on WMS_ADDRESS
--	=================================================================================
--	SELECT COUNT(ucbprem_unit)  from ucbprem@bprd.world;
--	SELECT ucbprem_unit  from ucbprem@bprd.world	where rownum < 111 and ucbprem_unit is not null;
--	=================================================================================
/*
	truncate table	garland.gis_objects	reuse storage;

	insert --+ append
	into	 garland.gis_objects (item01, item02)
	select ucbprem_code, 
		 ucbprem_unit
	from	 ucbprem@bprd.world
	where	 ucbprem_unit > '0'
	;

	commit;

*/
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;
	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================
/*

	update garland.WMS_ADDRESS	A
	set	unitnum = 
(
	select item02
	from	 garland.gis_Objects
	where	 item01 = rtrim(custserv_id)
);

	commit;

*/
--	=================================================================================
--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analy

