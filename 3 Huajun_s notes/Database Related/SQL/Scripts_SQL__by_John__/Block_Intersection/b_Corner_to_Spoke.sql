--	CORNER TO Radial


	set echo off;
--	=============================================================================
--	Populate Radial Side region with Corner region
--	1 Corner corresponds to 2 Radial Sides
--	=============================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
	explain plan set statement_id = 'corner1_Radial'	into garland.plan_table	for

	update garland.Radial_Side	s
	set	s.region_id = 
(
	select region_id
	from	 garland.Corner		c
	where	 s.road_id		= c.road_id1
	and	 s.side		= c.side1
	and	 s.junction		= c.junction1
	and	 s.esri_node	= c.esri_node
	and	 s.region_type	= c.region_type
)
	where	 s.region_id is null;

--	===========================================================================
	explain plan set statement_id = 'corner2_Radial'	into garland.plan_table	for

	update garland.Radial_Side	s
	set	s.region_id = 
(
	select region_id
	from	 garland.Corner		c
	where	 s.road_id		= c.road_id2
	and	 s.side		= c.side2
	and	 s.junction		= c.junction2
	and	 s.esri_node	= c.esri_node
	and	 s.region_type	= c.region_type
)
	where	 s.region_id is null;

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

	analyze table	garland.Radial_Side		compute statistics;

--	=============================================================================
	set echo on;





