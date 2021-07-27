	set echo	off;
--	==========================================================================================

	select source, addr_name, addr_type, addr_pfx, addr_sfx, addr_num
	from	 garland.temp_view
	group by source, addr_name, addr_type, addr_pfx, addr_sfx, addr_num
	having count(*) > 1;


--	==========================================================================================
/*
--	select count(*) from

(
	select 
		counter					"total", 
		rpad(source,' ', 06)			"source", 
		rpad(nvl(addr_name,' '),20)		"name",
		rpad(nvl(addr_type,' '),04)		"type",	 
		rpad(nvl(addr_pfx, ' '),02)		"pf", 
		rpad(nvl(addr_sfx, ' '),02)		"sf",
		lpad(nvl(addr_num,   0),05)		"num" 
	from
(
	select	source, addr_name, addr_type, addr_pfx, addr_sfx, addr_num,
			count(*) counter
	from		garland.TEMP_VIEW
	group by	source, addr_name, addr_type, addr_pfx, addr_sfx, addr_num
	having	count(*) > 1	
)
)

--	order by 3,4,5,6,7;
;

*/
--	==========================================================================================

/*
--	select count(*) from
(
	select count(*), appl_unit2, addr_name, addr_type, addr_pfx, addr_sfx, addr_num 
	from	garland.ADRRESULT
	group by	appl_unit2, addr_name, addr_type, addr_pfx, addr_sfx, addr_num 
	having	count(*) > 1	
	
)
	order by 3,4,5,6,7;

*/
--	==========================================================================================
	set echo	on;
