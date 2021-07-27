--	BUILD BLOCK SIDE REGION


	set echo off;
--	=============================================================================
--	Build Block Side Region using Block & Road Side Region tables
--	=============================================================================

--	Truncate table	garland.Block_Side_Region	reuse storage;

--	=============================================================================

	truncate table	garland.plan_table		reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id = 'block side region'	into garland.plan_table	for
--	=============================================================================

	insert into	garland.Block_Side_Region

	select distinct

		b.block_id,
		r.parity,
		r.region_type,
		r.region_id,
		r.priority

	from	garland.Block			b,
		garland.Road_Side_Region	r,
		garland.Trvehrcl			t

	where t.addr_name		= b.addr_name
	and	t.addr_block	= b.addr_block
	and	r.road_id		= b.road_id
	and	r.junction		= 'F'
	and	r.road_id		= t.mslink
	;	

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

	analyze table	garland.Block_Side_Region		compute statistics;

--	=============================================================================
	set echo on;
