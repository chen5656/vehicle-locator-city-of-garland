
/*
--	=====================================================================================================
	LOG ON
	
		user		jdeacutis
		password	jdeacutis1
		server	gisp.world

--	=====================================================================================================
--	=====================================================================================================
--	GIS

	select * from sys.all_tables					where rownum < 11 and owner not like 'SYS%';

--	=====================================================================================================
--	OMS

--	select * from all_tables@omst					where rownum < 11 and owner not like 'SYS%';

--	=====================================================================================================
--	CODE

--	select * from all_tables@cdep.world				where rownum < 11 and owner not like 'SYS%';

--	select * from all_tab_columns@cdep.world			where owner not like 'SYS%'
--	and table_name = 'CODEADDR';

--	select * from cog.case_violation@cdep.world		where rownum < 11;

--	=====================================================================================================
--	PARKS

	select * from all_tables@clas.world				where rownum < 11 and owner not like 'SYS%';

	select * from class.edl_facility_master@clas.world	where rownum < 11;

--	=====================================================================================================

--	IMAGING

	select * from all_tables@imgp.world			where rownum < 111 and owner like 'SYSADM%';

	select * from sysadm.active_volume@imgp.world	where rownum < 11;

--	=====================================================================================================

--	PERMITS

	select * from all_tables@pt01.world			where rownum < 11	and owner not like 'SYS%';

	select * from dbo.adr_base@pt01.world		where rownum < 11;

--	=====================================================================================================
--	UMS

--	create public database link 	umsp.world		using 'umsp';

	select * from all_tables@umsp.world			where rownum < 11 and owner not like 'SYS%';
	select * from all_tables@umsp.world			where rownum < 11 and owner like 'SFG%';

	select table_name, column_name
	from	 all_tab_columns@umsp.world
	where	 owner = 'SFG'
	and	 column_name like '%ADDR%'
	order by 1, 2;
	
	select * from sfg.um00100m@umsp.world		where rownum < 111;

--	=====================================================================================================
--	P2K  (HR)

	LOG ON		P2K	COG1	P2KPROD
			P2K		P2KPILOT	

--	=====================================================================================================

*/

