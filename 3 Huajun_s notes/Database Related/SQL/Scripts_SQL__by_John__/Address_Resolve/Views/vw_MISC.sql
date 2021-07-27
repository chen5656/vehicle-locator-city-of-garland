 	set echo off;
--	===============================================================================
--	adrResult_User = GDS Tax Account
--	===============================================================================
--	ASCII extract is obtained from Crystal Reports	\\Loader\GDS_Account_Method (document)
--	ASCII is loaded into GIS_Objects			\\Loader\GDS_Account
--									\\Loader\GDS_Account_Extract
--	GIS_Objects is loaded into GDS_Account		\\Warehouse\Common_GDS\Load_GDS_Account
--	===============================================================================

	create or replace  view	garland.adrResult_User		as
	select
		ITEM01				rec_key,
		NULL					rec_rowid,
		''					addr_num,
		''					addr_pfx,
		replace(ITEM03,'.',' ')		addr_name,
		''					addr_type,
		''					addr_sfx,
		''			addr_code1,
		''			addr_unit1,
		''			addr_code2, 
		''			addr_unit2
	from	garland.GIS_Objects
	;
--	===============================================================================
