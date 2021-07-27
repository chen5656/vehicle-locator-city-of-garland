--	EXTEND INTERSECTION REGION	2


	set echo off;
--	=================================================================================================
--	Extend Intersection Region table from block-block intersections to all other intersection types 

--	Look for non block-block intersection having a qualifier subset of the block-block intersection

--	Temporarily set Priority = quadrant count
--	This will be updated later to Priority = 1,2,3... according to quadrant count
--	=================================================================================================

	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi') || '  EXTEND INTERSECTION REGION' " "	from dual;

	truncate table	garland.plan_table		reuse storage;

--	=============================================================================

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	=============================================================================
	explain plan set statement_id = 'intersection region2'	into garland.plan_table	for


	insert --+ append
	into	garland.Intersection_Region

	select
		intersect_id,
		region_type,
		counter,			--  temporary "priority judge" = occurrences
		region_id
	from
(
	select
		x2.intersect_id,
		r1.region_type,
		r1.region_id,
		count(*)			counter

	from	garland.Intersection_Region	r1,		-- block-block region
		garland.Intersection		x1,		-- block-block intersection 		(source)
		garland.Intersection		x2		-- non block-block intersection	(target)
	
	where	x2.node_id		= x1.node_id
	and	r1.intersect_id	= x1.intersect_id
	and	r1.priority		= 01


	and	x1.addr1_block > 0
	and	x1.addr2_block > 0
	and	x2.addr1_block * x2.addr2_block = 0

	and	x2.addr1_name	= x1.addr1_name
	and	x2.addr2_type	= x1.addr2_type

	and	x2.addr1_block	in (0, x1.addr1_block)
	and	x2.addr2_block	in (0, x1.addr2_block)

	and	x2.addr1_pfx	in (' ', x1.addr1_pfx)
	and	x2.addr2_pfx	in (' ', x1.addr2_pfx)

	and	x2.addr1_sfx	in (' ', x1.addr1_sfx)
	and	x2.addr2_sfx	in (' ', x1.addr2_sfx)

	group by	x2.intersect_id, r1.region_type, r1.region_id
)

	order by
		intersect_id,
		region_type,
		counter		desc,
		region_id
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

	analyze table	garland.Intersection_Region	compute statistics;

--	=============================================================================
	set echo on;


