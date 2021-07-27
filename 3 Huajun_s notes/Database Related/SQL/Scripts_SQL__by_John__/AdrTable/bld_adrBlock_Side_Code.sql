	set echo	off;
	set timing	on;
--	==========================================================	
--	update Block_Side CODE INSPECTION AREA
--	==========================================================	

--	==========================================================	

--	truncate table	plan_table;
--	explain plan	set statement_id = 'council'		for

	update	garland.Block_Side	S

	set		CODE_INSPECT_AREA	=					--	CHANGE
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
			p.CODE_INSPECT_AREA		region,			--	CHANGE
			count(*)	  		total

	from		garland.cdrelpar		P,
			garland.cdreladr		A
	where		a.parcel_id	= p.parcel_id

	group by	a.addr_name,  a.addr_type,   a.addr_pfx,	a.addr_sfx,
			trunc (a.addr_num,-2), 
			mod	(a.addr_num,02), 
			p.CODE_INSPECT_AREA					--	CHANGE
)
	group by	addr_name,  addr_type,   addr_pfx,	addr_sfx,
			addr_block, addr_parity,
			region
)
	group by	addr_name,  addr_type,   addr_pfx,	addr_sfx,
			addr_block, addr_parity
)
	X
	
	where	x.addr_name		= s.addr_name
	and	x.addr_type		= s.addr_type
	and	x.addr_pfx		= s.addr_pfx
	and	x.addr_sfx		= s.addr_sfx
	and	x.addr_block	= s.addr_block
	and	x.addr_parity	= s.addr_parity
);

--	=======================================================

	commit;
--	alter rollback segment rb1	offline;

--	=======================================================
--	select * from explain_plan;
--	=======================================================
--	set echo	on;

