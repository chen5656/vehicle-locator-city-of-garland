	set echo off;
--	=============================================================================
--	Build Block Side Region using Block & Road Side Region tables
--	=============================================================================

	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi') || '  BUILD BLOCK SIDE REGION' " "	from dual;

--	Truncate table	garland.Block_Side_Region	reuse storage;

--	=============================================================================

	truncate table	garland.plan_table		reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id = 'block side region'	into garland.plan_table	for
--	=============================================================================

	insert --+ append
	into	garland.Block_Side_Region

	select distinct

		b.block_id,
		r.parity,
		r.region_type,
		r.region_id,
		r.priority

	from	garland.Block			b,
		garland.Road_Side_Region	r,
		garland.Trvehrcl			t

	where b.addr_name		= t.addr_name
	and	b.addr_type		= t.addr_type
	and	b.addr_pfx		= t.addr_pfx
	and	b.addr_sfx		= t.addr_sfx

	and	b.addr_block	between trunc(t.addr_lo, -2)  and t.addr_hi

	and	r.road_id		= t.mslink

	and	r.road_id		= b.road_id
	and	r.junction		= 'F'
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
