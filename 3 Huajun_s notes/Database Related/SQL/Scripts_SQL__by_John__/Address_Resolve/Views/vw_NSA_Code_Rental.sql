 	set echo off;
--	===============================================================
--	adrResult_User = NSA_CODE_RENTAL
--	===============================================================

	create or replace	view	garland.adrResult_User
	(
		rec_key,

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

	rowidtochar(rowid),	--	rec_key
--		,			--	rec_key		(unique key or rowid)

		addr_num,			--	addr_num
		addr_pfx,			--	addr_pfx
		addr_name,			--	addr_name		
		addr_type,			--	addr_type
		addr_sfx,			--	addr_sfx

		'',			--	addr_code1
		'',			--	addr_unit1
		'',			--	addr_code2
		''			--	addr_unit2

	from	nsa_code_rental	--	(application table)
	;

--	===============================================================


