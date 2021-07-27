	set echo	off;
--	===========================================================================

--	how many water serial numbers correspond to many locations

	select count(*)		serial, 
		 sum(counter)	locations
	from
(
	select serial, count(*) counter
	from	temp_view1
	group by serial
	having count(distinct location) > 1
);



--	how many locations occur multiple times

	select 
		lpad(nvl(addr_num,   0),05)		"num", 
		rpad(nvl(addr_pfx, ' '),02)		"pf", 
		rpad(nvl(addr_name,' '),20)		"name",
		rpad(nvl(addr_type,' '),04)		"type",	 
		rpad(nvl(addr_sfx, ' '),02)		"sf",

		rpad(count(distinct location),5)	"count",
		rpad(min(serial),10)			"serial",
		rpad(max(serial),10)			"serial"

	from	temp_view2

	group by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num
	having	count(distinct location) > 1;


--	===========================================================================
	set echo	on;
