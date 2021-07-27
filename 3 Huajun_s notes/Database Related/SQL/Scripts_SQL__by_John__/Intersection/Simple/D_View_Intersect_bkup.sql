
	create or replace view	garland.Temp_View3		as

	select
		s1.addr_name		s1_addr_name,
		s1.addr_type		s1_addr_type,
		s1.addr_pfx			s1_addr_pfx,
		s1.addr_sfx			s1_addr_sfx,
		s1.addr_block		s1_addr_block,

		s2.addr_name		s2_addr_name,
		s2.addr_type		s2_addr_type,
		s2.addr_pfx			s2_addr_pfx,
		s2.addr_sfx			s2_addr_sfx,
		s2.addr_block		s2_addr_block,

		s1.this_node		node_id

	from	garland.Temp_View2	S1,
		garland.Temp_View2	S2

	where	s1.this_node  = s2.this_node
	and	s1.road_id	 <> s2.road_id
	and (	s1.addr_name <> s2.addr_name
	or	s1.addr_type <> s2.addr_type )
	;

