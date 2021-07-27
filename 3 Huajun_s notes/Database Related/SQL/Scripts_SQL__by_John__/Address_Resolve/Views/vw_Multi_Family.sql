 	set echo off;
--	===============================================================
--	adrResult_User = Multi-Family Dwellings
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

		appl_num,		--	record key
		rowid,		--	record rowid

		cmplx_num,		--	addr_num,
		cmplx_pref,		--	addr_pfx,
		cmplx_street,	--	addr_name,
		cmplx_type,		--	addr_type,
		cmplx_suffix,	--	addr_sfx,

		'',		--	addr_code1,
		'',		--	addr_unit1,
		'',		--	addr_code2, 
		''		--	addr_unit2

	from	cog.mfamdwel@cdep.world
	;

--	===============================================================
