 	set echo off;
--	===============================================================
--	adrResult_User = DCAD

--	\scripts\department\DCAD\DCAD_Address
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

		dcad_id,		--	record key
		rowid,		--	record rowid

		addr_num,
		addr_pfx,
		addr_name,
		addr_type,
		null,

		'',		--	addr_code1,
		'',		--	addr_unit1,
		'',		--	addr_code2, 
		''		--	addr_unit2

	from	garland.Temp_View

	where	addr_unit1 is null
	and	addr_unit2 is null
	;

--	===============================================================

