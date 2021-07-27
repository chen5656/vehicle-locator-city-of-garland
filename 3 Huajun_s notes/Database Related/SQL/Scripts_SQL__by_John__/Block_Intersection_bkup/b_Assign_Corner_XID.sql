--	ASSIGN CORNER XID

	set echo off;
--	=============================================================================
--	Assign Intersect IDs from Intersection table to Corner table
--	=============================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id = 'corner xid'	into garland.plan_table	for
--	===========================================================================

	update garland.Corner		c
	set	c.Intersect_id = 
(
	select intersect_id
	from	 garland.Intersection	x,
		 garland.Trvehrcl		r1,
		 garland.Trvehrcl		r2

	where	r1.addr_name = x.addr1_name
	and	r2.addr_name = x.addr2_name

	and	r1.mslink	= c.road1_id
	and	r2.mslink	= c.road2_id

	and	x.road1_id	= c.road1_id
	and	x.road2_id	= c.road2_id

	and	x.addr1_block * x.addr2_block > 0
)
	where	c.intersect_id is null;

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

	analyze table	garland.Corner	compute statistics;

--	=============================================================================
	set echo on;


