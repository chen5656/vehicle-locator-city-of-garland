	set echo	off;
--	=============================================================
--	assign block region one  to block side table
--	=============================================================

	truncate table	plan_table	reuse storage;

	alter rollback segment	rb1	online;
	commit;
	set transaction	use rollback segment rb1;

--	explain plan set statement_id = 'assign'		for	

	update block_region_view	b
	set	region = 
(
	select region1
	from	block_region1_view	r

	where	b.addr_name		= r.addr_name
	and	b.addr_type		= r.addr_type
	and	b.addr_pfx		= r.addr_pfx
	and	b.addr_sfx		= r.addr_sfx
	and	b.addr_block		= r.addr_block
)
	where	nvl (b.region, '0')	<= '0';
	and exists
(
	select 'x'
	from	block_region1_view	rr
	where	b.addr_name		= rr.addr_name
	and	b.addr_type		= rr.addr_type
	and	b.addr_pfx		= rr.addr_pfx
	and	b.addr_sfx		= rr.addr_sfx
	and	b.addr_block		= rr.addr_block
);

--	select * from explain_plan;

--	Rollback;
	commit;
	alter rollback segment	rb1	offline;

--	=============================================================
	set echo	on;



