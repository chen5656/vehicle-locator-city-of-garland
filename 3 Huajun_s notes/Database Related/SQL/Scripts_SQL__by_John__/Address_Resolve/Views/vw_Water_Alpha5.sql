 	set echo off;
--	===============================================================
--	adrResult_User = Water Alpha 5
--	===============================================================

	create or replace	view	garland.adrResult_User
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

		item01,		--	record key
		rowid,		--	record rowid

		'',		--	addr_num,
		'',		--	addr_pfx,
		item02,		--	addr_name,
		'',		--	addr_type,
		'',		--	addr_sfx,

		'',		--	addr_code1,
		item05,		--	addr_unit1,
		'',		--	addr_code2, 
		''		--	addr_unit2

	from	garland.gis_Objects
	;

--	===============================================================
