
--	desc trvehrcl;


	select addr_pfx, addr_name, addr_type, addr_sfx, mslink,
		chr(10),
		'lo', addr_lo, addr_left_from ||'-'|| addr_rght_from,
		chr(10),
		'hi', addr_hi, addr_left_to   ||'-'|| addr_rght_to,
		chr(10)

	from	trvehrcl

	where	addr_lo <> least (addr_left_from, addr_rght_from)
	
	or	addr_hi <> greatest (addr_left_to, addr_rght_to)

	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_lo;