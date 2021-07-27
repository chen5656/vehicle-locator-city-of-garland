	set echo off;
--	=============================================================================
--	Populate Corner region with Radial Side region
--	1 Corner corresponds to 2 Radial Sides
--	=============================================================================

	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi') || '  RADIAL TO CORNER' " "	from dual;

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
	explain plan set statement_id = 'Radial-corner1'	into garland.plan_table	for

	update garland.Corner		c
	set	c.region_id = 
(
	select region_id
	from	 garland.Radial_Side	s
	where	 s.road_id		= c.road_id1
	and	 s.side		= c.side1
	and	 s.junction		= c.junction1
	and	 s.esri_node	= c.esri_node
	and	 s.region_type	= c.region_type
)
	where	 c.region_id is null;

--	===========================================================================
	explain plan set statement_id = 'Radial-corner2'	into garland.plan_table	for

	update garland.Corner		c
	set	c.region_id = 
(
	select region_id
	from	 garland.Radial_Side	s
	where	 s.road_id		= c.road_id2
	and	 s.side		= c.side2
	and	 s.junction		= c.junction2
	and	 s.esri_node	= c.esri_node
	and	 s.region_type	= c.region_type
)
	where	 c.region_id is null;

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

	analyze table	garland.Corner		compute statistics;

--	=============================================================================
	set echo on;




