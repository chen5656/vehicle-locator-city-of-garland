--	=======================================================

	truncate table	garland.Block_Side	reuse storage;

--	=======================================================

	insert into	garland.Block_Side
	select	
		addr_pfx,   addr_name, addr_type, addr_sfx,
		addr_block, 
		 0,					--	parity = even
		 0,					--	block id
		'00000',				--	zip
		'00000',				--	subdiv
		'0',					--	council
		'00',					--	code inspect area
		'0',					--	fire district
		 0,					--	police beat
		'0'					--	police district
	from	 garland.Block
	union	
	select	
		addr_pfx,   addr_name, addr_type, addr_sfx,
		addr_block, 
		 1,					--	parity = odd
		 0,					--	block id
		'00000',				--	zip
		'00000',				--	subdiv
		'0',					--	council
		'00',					--	code inspect area
		'0',					--	fire district
		 0,					--	police beat
		'0'					--	police district
	from	 garland.Block;
	commit;

--	=======================================================
	update	garland.Block_Side	S
	set		POLICE_BEAT	=							--	region
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
			p.POLICE_BEAT		region,				--	region
			count(*)	  		total

	from		garland.cdrelpar		p,
			garland.cdreladr		a
	where		a.parcel_id	= p.parcel_id
	group by	a.addr_name,  a.addr_type,   a.addr_pfx,	a.addr_sfx,
			trunc (a.addr_num,-2), 
			mod	(a.addr_num,02), 
			p.POLICE_BEAT							--	region
)
	group by	addr_name,  addr_type,   addr_pfx,	addr_sfx,
			addr_block, addr_parity,
			region
)
	group by	addr_name,  addr_type,   addr_pfx,	addr_sfx,
			addr_block, addr_parity
)	X
	where	x.addr_name		= s.addr_name
	and	x.addr_type		= s.addr_type
	and	x.addr_pfx		= s.addr_pfx
	and	x.addr_sfx		= s.addr_sfx
	and	x.addr_block	= s.addr_block
	and	x.addr_parity	= s.addr_parity
);
	commit;

--	==========================================================	
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

	commit;
--	==========================================================	

	update	garland.Block_Side	S
	set		COUNCIL_ID	=								--	region
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
			p.COUNCIL_ID		region,					--	region
			count(*)	  		total

	from		garland.cdrelpar		p,
			garland.cdreladr		a
	where		a.parcel_id	= p.parcel_id
	group by	a.addr_name,  a.addr_type,   a.addr_pfx,	a.addr_sfx,
			trunc (a.addr_num,-2), 
			mod	(a.addr_num,02), 
			p.COUNCIL_ID								--	region
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

	commit;
--	==========================================================	

	update	garland.Block_Side	S
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
	X
	where	x.addr_name		= s.addr_name
	and	x.addr_type		= s.addr_type
	and	x.addr_pfx		= s.addr_pfx
	and	x.addr_sfx		= s.addr_sfx
	and	x.addr_block	= s.addr_block
	and	x.addr_parity	= s.addr_parity
);

	commit;
--	==========================================================	

	update	garland.Block_Side	S
	set		FIRE_DISTRICT	=							--	region
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
			p.fire_district		region,				--	region
			count(*)	  		total
	from		garland.cdrelpar		p,
			garland.cdreladr		a
	where		a.parcel_id	= p.parcel_id
	group by	a.addr_name,  a.addr_type,   a.addr_pfx,	a.addr_sfx,
			trunc (a.addr_num,-2), 
			mod	(a.addr_num,02), 
			p.fire_district							--	region
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
--	==========================================================	

	update	garland.Block_Side	S
	set		SUBDIV_ID	=							--	region
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
			p.SUBDIV_ID		region,				--	region
			count(*)	  		total
	from		garland.cdrelpar		p,
			garland.cdreladr		a
	where		a.parcel_id	= p.parcel_id
	group by	a.addr_name,  a.addr_type,   a.addr_pfx,	a.addr_sfx,
			trunc (a.addr_num,-2), 
			mod	(a.addr_num,02), 
			p.SUBDIV_ID							--	region
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

	commit;
--	==========================================================	

	update	garland.Block_Side	S
	set		ZIP_CODE	=					--	region
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
			p.ZIP_CODE			region,		--	region
			count(*)	  		total
	from		garland.cdrelpar		p,
			garland.cdreladr		a
	where		a.parcel_id	= p.parcel_id
	group by	a.addr_name,  a.addr_type,   a.addr_pfx,	a.addr_sfx,
			trunc (a.addr_num,-2), 
			mod	(a.addr_num,02), 
			p.ZIP_CODE						--	region
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

	commit;
--	=======================================================
