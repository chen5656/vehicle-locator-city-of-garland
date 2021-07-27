
	select	rpad(mslink,10) mslink,	
			addr_pfx,	addr_name, addr_type, addr_sfx, 
					addr_lo,	addr_hi, 
			branch_no,	section_no
	from		trvehrcl

	where	 (	addr_name, addr_type, addr_pfx, addr_sfx, addr_lo	)	in
(
	select	addr_name, addr_type, addr_pfx, addr_sfx, addr_lo
	from		trvehrcl
	group by	addr_name, addr_type, addr_pfx, addr_sfx, addr_lo
	having	count(*) > 1
)

	and		branch_no < 9999

	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_lo, rpad(mslink,10);
