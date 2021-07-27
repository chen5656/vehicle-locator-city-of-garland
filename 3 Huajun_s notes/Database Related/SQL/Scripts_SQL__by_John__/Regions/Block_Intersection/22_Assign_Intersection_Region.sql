	set echo	off;
--	===========================================================================
--	update intersection regions using blocks lying entirely w/in one region
--	===========================================================================

--	analyze table	intersection	compute statistics;
--	analyze table	block_side		compute statistics;

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;
--	insert into	garland.plan_table (object_name,object_owner) values ( '' , '' );

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan set statement_id =	'xxx'		into garland.plan_table	for

	update intersection_region_view	x
	set	region =
(
	select	distinct(b.region1)
	from		block_region1_view	b

	where		region1 > '0'
	and 		b.addr_name		= x.addr1_name
	and		b.addr_type		= x.addr1_type
	and		b.addr_pfx		= x.addr1_pfx
	and		b.addr_sfx		= x.addr1_sfx
	and		b.addr_block	= x.addr1_block
)
	where		x.addr1_block > 0
	and		nvl(x.region,'0') <= '0';
	
--	===========================================================================
--	explain plan set statement_id =	'yyy'		into garland.plan_table	for

	update intersection_region_view	x
	set	region =
(
	select	distinct(b.region1)
	from		block_region1_view	b

	where		region1 > '0'
	and 		b.addr_name		= x.addr2_name
	and		b.addr_type		= x.addr2_type
	and		b.addr_pfx		= x.addr2_pfx
	and		b.addr_sfx		= x.addr2_sfx
	and		b.addr_block	= x.addr2_block
)
	where		x.addr2_block > 0
	and		nvl(x.region,'0') <= '0';

--	===========================================================================

	select kind, count(*) "     TOTAL"  from intersection_region_view where region > '0';

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

--	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;
--	===========================================================================
	set echo	on;

--	desc intersection;

