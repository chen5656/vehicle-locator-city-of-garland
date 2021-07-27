	set echo off;
--	===========================================

	select * from garland.Temp_View

--	where	source = 'KNOWN'
	where	source = 'SECTION8'
--	where	source = 'HOMESTEAD'
--	where	source = 'DCAD'

	and rownum < 11;

--	===========================================

	select addr_num, addr_name	
	from	garland.adrResult

	where	appl_unit2 = 'KNOWN'
--	where	appl_unit2 = 'DCAD'
--	where	appl_unit2 = 'SECTION8'
--	where	appl_unit2 = 'HOMESTEAD'

	and	rownum < 111

	and	addr_num >'0'
	;

--	===========================================

	select sum(sign(known) + sign(dcad) + sign(section8) + sign(homestead))
	from garland.temp_view1;


	select count(*) from garland.adrREsult
	where rtrim(addr_unit1) > '0'
	and	addr_unit1 not in  ( 'KNOWN',  'DCAD', 'SECTION8', 'HOMESTEAD');

--	===========================================
	set echo on;
