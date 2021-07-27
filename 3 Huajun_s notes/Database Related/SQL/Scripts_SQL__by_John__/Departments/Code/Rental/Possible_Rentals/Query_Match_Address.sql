	set echo off;
--	=================================================================

	select count(*) from

(
	select addr_name, addr_type, addr_pfx, addr_sfx, addr_num
	from	garland.adrResult

	where	appl_unit2 = 'KNOWN'
--	where	appl_unit2 = 'DCAD'
--	where	appl_unit2 = 'SECTION8'
--	where	appl_unit2 = 'HOMESTEAD'

	intersect

	select addr_name, addr_type, addr_pfx, addr_sfx, addr_num
	from	garland.adrResult

--	where	appl_unit2 = 'KNOWN'
	where	appl_unit2 = 'DCAD'
--	where	appl_unit2 = 'SECTION8'
--	where	appl_unit2 = 'HOMESTEAD'

);


--	=================================================================
	set echo on
