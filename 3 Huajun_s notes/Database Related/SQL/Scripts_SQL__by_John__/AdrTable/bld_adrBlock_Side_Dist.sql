	set echo	off;
	set timing	on;

--	==========================================================	
--	update adrBlock_Side POLICE DISTICT
--	==========================================================	

--	alter rollback segment rb1	online;
--	commit;
--	set transaction use rollback segment rb1;

--	==========================================================	
--	truncate table	plan_table;
--	explain plan	set statement_id = 'district'		for
--	==========================================================	

	update	garland.Block_Side	s
	set		POLICE_DISTRICT	=						--	region
(
	select	region		from
(
	select	addr_name,  addr_type,   addr_pfx,	addr_sfx,
			addr_block, addr_parity,
			max (region)		region
	from
(
	select	addr_name,  addr_type,   addr_pfx,	addr_sfx,
			addr_block, addr_parity,
			region,	
			max (total)	
	from
(	
	select	a.addr_name,  a.addr_type,   a.addr_pfx,	a.addr_sfx,
			trunc (a.addr_num, -2)	addr_block,
			mod	(a.addr_num, 02)	addr_parity, 
			p.POLICE_DISTRICT		region,				--	region
			count(*)	  		total

	from		garland.cdrelpar		p,
			garland.cdreladr		a
	where		a.parcel_id	= p.parcel_id

	group by	a.addr_name,  a.addr_type,   a.addr_pfx,	a.addr_sfx,
			trunc (a.addr_num,-2), 
			mod	(a.addr_num,02), 
			p.POLICE_DISTRICT							--	region
)
	group by	addr_name,  addr_type,   addr_pfx,	addr_sfx,
			addr_block, addr_parity,
			region
)
	group by	addr_name,  addr_type,   addr_pfx,	addr_sfx,
			addr_block, addr_parity
)
	x
	
	where	x.addr_name		= s.addr_name
	and	x.addr_type		= s.addr_type
	and	x.addr_pfx		= s.addr_pfx
	and	x.addr_sfx		= s.addr_sfx
	and	x.addr_block	= s.addr_block
	and	x.addr_parity	= s.addr_parity
);

	commit;
--	alter rollback segment rb1	offline;

--	=======================================================
--	select * from explain_plan;
--	=======================================================
--	set echo	on;
	set timing	off;

