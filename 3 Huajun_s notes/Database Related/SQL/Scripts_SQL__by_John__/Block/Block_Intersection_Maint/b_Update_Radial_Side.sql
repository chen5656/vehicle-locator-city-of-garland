	set echo off;
--	=============================================================================
--	Populate Radial Side regions  from Road Side Region
--	If 2 regions are on Radial Side, then manually populate Road Side Region with 2nd region id
--	=============================================================================

	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi') || '  UPDATE RADIAL SIDE' " "	from dual;

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id = 'update Radial side'  into garland.plan_table	for
--	===========================================================================

	update garland.Radial_Side		s
	set	 s.region_id = 
(
	select r.region_id
	from	garland.Road_Side_Region	r

	where	r.road_id		= s.road_id
	and	r.side		= s.side
	and	r.region_type	= s.region_type
	and	r.priority		= 01

)
	where	s.region_id is null;

--	===========================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

	commit;
	alter rollback segment rb1 offline;

	analyze table	garland.Radial_Side	compute statistics;

--	=============================================================================
	set echo on;





