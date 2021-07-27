 	set echo off;
--	===============================================================================
--	adrResult_User = GDS Tax Account
--	===============================================================================
--	ASCII extract is obtained from Crystal Reports	\\Loader\GDS_Account_Method (document)
--	ASCII is loaded into GIS_Objects			\\Loader\GDS_Account
--									\\Loader\GDS_Account_Extract
--	GIS_Objects is loaded into GDS_Account		\\Warehouse\Common_GDS\Load_GDS_Account
--	===============================================================================

	create or replace  view	garland.adrResult_User
	(
		rec_key,
		rec_rowid,
		addr_num,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx,
		addr_code1,
		addr_unit1,
		addr_code2,
		addr_unit2
	)
	as
	select
		ltrim(Account,'0'),	--	record key
		rowid,			--	record rowid
		ltrim(addr_num,'0'),	--	addr_num,
		'',				--	addr_pfx,
		addr_name,			--	addr_name,
		'',				--	addr_type,
		'',				--	addr_sfx,
		'',		--	addr_code1,
		'',		--	addr_unit1,
		'',		--	addr_code2, 
		''		--	addr_unit2
	from	garland.GDS_Account	A
	where	acct_type = 'R'
	;

--	===============================================================================
