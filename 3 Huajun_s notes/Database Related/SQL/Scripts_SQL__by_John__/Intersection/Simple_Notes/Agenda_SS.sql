
	truncate table  garland.INTERSECTION  reuse storage;

	insert --+ append
	into	garland.INTERSECTION
	(
		addr1_block,
		addr1_pfx,
		addr1_name,
		addr1_type,
		addr1_sfx,
		addr2_block,
		addr2_pfx,
		addr2_name,
		addr2_type,
		addr2_sfx,
		intersect_id
	)
	select distinct
		0,	
		s1.addr_pfx,
		s1.addr_name,	
		s1.addr_type,	
		s1.addr_sfx,
		0,	
		s2.addr_pfx,	
		s2.addr_name,	
		s2.addr_type,	
		s2.addr_sfx,
		'SS'
	from	garland.ROAD_NODE_BLOCK		R1,
		garland.ROAD_NODE_BLOCK		R2,
		garland.ADRSTREETS		S1,
		garland.ADRSTREETS		S2
	where	r1.roadid	     <> r2.roadid
	and	r1.xcoord		= r2.xcoord
	and	r1.ycoord		= r2.ycoord
	and	s1.street_id	= r1.streetid
	and	s2.street_id	= r2.streetid
	and	s1.addr_name ||'.'|| s1.addr_type <> (s2.addr_name ||'.'|| s2.addr_type;
