	set echo off;
--	=============================================================================
--	Build Intersection Region table from Corner & Road Side Region tables
--	Obtain regions for block-block intersections only
--	=============================================================================

	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi') || '  BUILD INTERSECTION REGION' " "	from dual;

	Truncate table	garland.Intersection_Region	reuse storage;

--	=============================================================================

	truncate table	garland.plan_table		reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	=============================================================================
	explain plan set statement_id = 'intersection region1'		into garland.plan_table	for

	insert 	--+ append
	into		garland.Intersection_Region

	select
		c.intersect_id,
		r.region_type,
		r.region_id,
		0					-- intersection priority
	
	from	garland.Corner			c,
		garland.Road_Side_Region	r

	where	c.road1_id		= r.road_id
	and	c.side1		= r.side
	and	r.priority		= 01
	and	r.region_id is not null;


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

	analyze table	garland.Intersection_Region	compute statistics;

--	=============================================================================
	set echo on;

