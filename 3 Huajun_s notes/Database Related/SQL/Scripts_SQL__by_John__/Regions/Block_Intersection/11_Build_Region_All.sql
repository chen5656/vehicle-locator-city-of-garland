	set echo off;
--	=============================================================
--	mslink, region ===>> block,region
--	=============================================================

	truncate table	gis_temp3	reuse storage;
	truncate table	plan_table	reuse storage;

	alter rollback segment	rb1	online;
	commit;
	set transaction	use rollback segment rb1;

--	explain plan set statement_id = 'regions'		for	

	insert into block_region3_view

	select	addr_name, addr_type, addr_pfx, addr_sfx, addr_block,
			item02, null
	from
(
	select	b.addr_name, b.addr_type, b.addr_pfx, b.addr_sfx, b.addr_block,
			g.item02

	from	trvehrcl		r,
		block			b,
		gis_objects		g

	where	r.mslink		= to_number (g.item01)
	and	g.item02 > '0'

	and	b.addr_name		= r.addr_name
	and	b.addr_type		= r.addr_type
	and	b.addr_pfx		= r.addr_pfx
	and	b.addr_sfx		= r.addr_sfx
	and	b.addr_block	= trunc(r.addr_lo, -2)

	order by	1,2,3,4,5,6
)	;

--	select * from explain_plan;

	commit;
	alter rollback segment	rb1	offline;

	analyze table	gis_temp3	compute statistics;

--	=============================================================
	set echo on;
