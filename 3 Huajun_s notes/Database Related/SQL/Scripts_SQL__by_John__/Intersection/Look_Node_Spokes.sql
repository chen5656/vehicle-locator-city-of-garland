
--	display intersecting streets at intersection node


	select 
		rpad(node,5)	node, 
		mslink, 
		rpad(terminal,01) " ",
		addr_lo, addr_hi, addr_pfx, addr_name, addr_type, addr_sfx

	from	spoke			s,
		trvehrcl		r
	where	s.segment_id = rtrim(mslink)


	and	 node	in 

--	specify nodes
(

--	 5053, 2164, 2097, 

	4187,

0)

	order by	node, addr_name, addr_type, addr_pfx, addr_sfx;
	