

--	which address ranges contain maximum potential range

	select distinct addr_pfx, addr_name, addr_type, addr_sfx, addr_lo, addr_hi
	from	trvehrcl
	where addr_hi < 9999
	and	mod(addr_hi,100) = 99
	order by 2, 3, 1, 4, 5;