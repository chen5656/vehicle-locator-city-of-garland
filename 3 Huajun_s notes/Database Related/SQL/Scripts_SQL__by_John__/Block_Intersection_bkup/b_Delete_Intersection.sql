--	DELETE INTERSECTION

	set echo off;
--	=============================================================================
--	Show "Deleted" Intersection with no corresponding Centerline records
--	=============================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id = 'delete intersection'	into garland.plan_table	for
--	===========================================================================

	select
		x.addr1_block,
		x.addr1_pfx,
		x.addr1_name,
		x.addr1_type,
		x.addr1_sfx,
		chr(10),

		x.addr2_block,
		x.addr2_pfx,
		x.addr2_name,
		x.addr2_type,
		x.addr2_sfx,
		chr(10),

		x.intersect_id,
		x.road1_id,
		x.road2_id,
		x.side1,
		x.side2,
--		x.rowid
		chr(10)

	from	garland.Intersection	x

	where	x.addr1_block > 0
	and	x.addr2_block > 0
	
	and not exists
(
	select 'x'
	from	garland.Corner		c,
		garland.Trvehrcl		r1,
		garland.Trvehrcl		r2

	where	c.road1_id	= r1.mslink
	and	c.road2_id	= r2.mslink

	and	x.addr1_name	= r1.addr_name
	and	x.addr1_type	= r1.addr_type
	and	x.addr1_pfx		= r1.addr_pfx
	and	x.addr1_sfx		= r1.addr_sfx
	and	x.addr1_block	= trunc(c.street1_num,-2)

	and	x.addr2_name	= r2.addr_name
	and	x.addr2_type	= r2.addr_type
	and	x.addr2_pfx		= r2.addr_pfx
	and	x.addr2_sfx		= r2.addr_sfx
	and	x.addr2_block	= trunc(c.street2_num,-2)
)
	;

--	===========================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;

--	analyze table	garland.GIS_Objects	compute statistics;

--	=============================================================================
	set echo on;







