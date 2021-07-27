 	set echo off;
--	===============================================================
--	adrResult_User = Building Permit
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

		element_key,		--	record key
		rowid,			--	record rowid

		street_no,			--	addr_num,
		street_direction,		--	addr_pfx,
		street_name,		--	addr_name,

		'',		--	addr_type,
		'',		--	addr_sfx,

		'',		--	addr_code1,
		'',		--	addr_unit1,
		'',		--	addr_code2, 
		''		--	addr_unit2

	from	dbo.adr_base@pt01.world

	where	city_id = 'GARL'
	;

--	===============================================================
