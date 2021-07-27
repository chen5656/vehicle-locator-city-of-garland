	set echo	off;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan set statement_id =  'xxx'	into garland.plan_table	for

	update garland.Block	b

	set ( intersect1_id, intersect2_id ) = 
(
	select 
		min(x.intersect_id), min(y.intersect_id)

--		b.addr_block, b.addr_pfx, b.addr_name, b.addr_type, b.addr_sfx, 
--		x.addr2_pfx ||' '|| x.addr2_name ||' '|| x.addr2_type ||' '|| x.addr2_sfx	intersect1,
--		y.addr2_pfx ||' '|| y.addr2_name ||' '|| y.addr2_type ||' '|| y.addr2_sfx	intersect2

	from	garland.Intersection	x,
		garland.Intersection	y

	where	b.addr_pfx		= x.addr1_pfx
	and	b.addr_name		= x.addr1_name
	and	b.addr_type		= x.addr1_type
	and	b.addr_sfx		= x.addr1_sfx

	and	b.addr_pfx		= y.addr1_pfx
	and	b.addr_name		= y.addr1_name
	and	b.addr_type		= y.addr1_type
	and	b.addr_sfx		= y.addr1_sfx

	and	b.addr_block	= x.addr1_block
	and	b.addr_block	= y.addr1_block

	and	x.addr2_name	>= y.addr2_name
	and	x.addr2_name ||'.'|| x.addr2_type <> y.addr2_name ||'.'|| y.addr2_type

	group by	b.addr_block, b.addr_pfx, b.addr_name, b.addr_type, b.addr_sfx 
);

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

	commit;
	alter rollback segment rb1 offline;
--	===========================================================================
	set echo	on;
