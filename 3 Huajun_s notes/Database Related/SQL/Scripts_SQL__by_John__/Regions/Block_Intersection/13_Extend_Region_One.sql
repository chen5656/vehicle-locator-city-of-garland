	set echo	off;
--	===========================================================================
--	Since block_side regions are initially populated from CDRELPAR,
--	it is possible to find additional blocks lying w/in focus region
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;
--	insert into	garland.plan_table (object_name,object_owner) values ( '' , '' );

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;
--	===========================================================================

--	explain plan set statement_id = 'xxx'  for

	insert into	block_region1_view
(
	select	addr_name, addr_type, addr_pfx, addr_sfx, addr_block, 
			region, null
	from
(
	select	x.addr_name, x.addr_type, x.addr_pfx, x.addr_sfx, x.addr_block, x.region
	from		block_region_view		x,
			block_region_view		y

	where		x.addr_name		= y.addr_name
	and		x.addr_type		= y.addr_type
	and		x.addr_pfx		= y.addr_pfx
	and		x.addr_sfx		= y.addr_sfx
	and		x.addr_block	= y.addr_block
	and		x.addr_parity	= 0
	and		y.addr_parity	= 1

	and		x.region		= y.region
	and		x.region > '0'
)	Z

	where not exists
(
	select 'x'
	from	 block_region1_view
	where	 addr_name		= z.addr_name
	and	 addr_type		= z.addr_type
	and	 addr_pfx		= z.addr_pfx
	and	 addr_sfx		= z.addr_sfx
	and	 addr_block		= z.addr_block
)
);

--	select * from explain_plan;

--	===========================================================================
--	Rollback;
	commit;

	alter rollback segment rb1 offline;
	set echo	on;
