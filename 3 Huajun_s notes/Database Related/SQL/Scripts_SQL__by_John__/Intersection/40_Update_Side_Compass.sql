	set echo off;
--	======================================================================================
--	for non block-block intersection, set street corner compass to side-of-street compass
--	======================================================================================

--	do for both primary & secondary
--	do for both compass = N,S & E,W
--	===============================================================================

	truncate table	garland.plan_table;

	alter rollback segment	rb1	online;
	commit;

--	===============================================================================

	set transaction	use rollback segment	rb1;

	explain plan	set statement_id = 'a'	into garland.plan_table		for

	update	intersection		X
	set		corner_compass =
(
	select	corner_compass || compass
	from
(
	select	node_id, addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block,
			min (rtrim(corner_compass, 'EW'))	compass
	from		intersection
	where		intersect_id like 'BB%'
	group by	node_id, addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block
	having	count (distinct rtrim(corner_compass, 'EW')) = 1
)							C		
	where	x.node_id		= c.node_id
	and	x.addr1_name	= c.addr1_name
	and	x.addr1_type	= c.addr1_type
	and	x.addr1_pfx		= c.addr1_pfx
	and	x.addr1_sfx		= c.addr1_sfx
	and	x.addr1_block	= c.addr1_block
)
	where	x.addr1_block > 0
	and	x.addr2_block = 0;

	commit;

--	======================================================================

	alter rollback segment	rb1	offline;

--	======================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_analyze;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_cost;
--	select * from garland.explain_remote;
--	======================================================================
	set echo on;

