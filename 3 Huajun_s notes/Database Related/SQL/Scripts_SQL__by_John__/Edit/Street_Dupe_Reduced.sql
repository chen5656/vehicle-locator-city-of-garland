	set echo off;
--	=================================================

--	find duplicate "reduced" name


	select distinct addr_name	

--	from	garland.CDRELADR
	from	garland.TRVEHRCL


	where	addr_name	in

(
	select	min(addr_name) addr_name
	from		garland.adrStreets
	group by	addr_reduced
	having	count(distinct addr_name) > 1

	union	

	select	max(addr_name) addr_name
	from		garland.adrStreets
	group by	addr_reduced
	having	count(distinct addr_name) > 1

);

--	=================================================
	set echo on;

