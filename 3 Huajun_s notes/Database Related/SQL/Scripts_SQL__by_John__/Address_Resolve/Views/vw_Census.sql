 	set echo off;
--	===============================================================
--	adrResult_User = Census
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

		item08,	--	record key
		rowid,	--	record rowid

		item14,	--	addr_num,
		'',		--	addr_pfx,
		item15,	--	addr_name,
		'',		--	addr_type,
		'',		--	addr_sfx,

		'',		--	addr_code1,
		item16,	--	addr_unit1,
		'',		--	addr_code2, 
		''		--	addr_unit2

	from	garland.gis_objects

	where	item16 is not null			-- where unit exists
	;

--	===============================================================
