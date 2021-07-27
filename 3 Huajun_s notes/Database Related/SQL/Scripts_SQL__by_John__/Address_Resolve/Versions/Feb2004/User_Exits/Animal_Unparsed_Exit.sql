
--	select count(*)

	select addr_name
	from 	garland.gis_app_addr

	where ( instr(addr_name, '-') + instr(addr_name, '&') + instr(addr_name, ' OR ') > 0
	or	translate (addr_name, '123456789', '000000000') like '%00.00%'
	)

	and (	addr_name not like '%-30%'
	and	addr_name not like '%BOIS-%'	
	and	addr_name not like '%STRAIT%'
	)



