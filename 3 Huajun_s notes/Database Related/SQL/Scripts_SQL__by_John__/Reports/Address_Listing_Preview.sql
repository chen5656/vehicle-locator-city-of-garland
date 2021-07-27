	set echo off;
--	=======================================================
--	how many addresses are on the most populous streets
--	=======================================================

	select * from
	(
	select addr_pfx, addr_name, addr_type, addr_sfx,
		 count(*) counter
	from	cdreladr

	where	rtrim(unit_type) is null
	and	rtrim(unit_num)  is null

	group by addr_pfx, addr_name, addr_type, addr_sfx
	having count(*) > 100
	)
	order by counter desc, addr_name, addr_type, addr_pfx;

--	=======================================================
	set echo on;
