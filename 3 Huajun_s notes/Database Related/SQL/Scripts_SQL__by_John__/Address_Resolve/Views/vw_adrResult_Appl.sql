 	set echo off;
--	===============================================================
--	adrResult_User = adrResult_Input
--	===============================================================

	drop   synonym	garland.TEMP_SYN;

	create synonym	garland.TEMP_SYN		for garland.adrResult_INPUT;	--  <<<<<<<   S P E C I F Y

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

		rec_key,			--	rec_key		(unique key or rowid)
		rec_rowid,			--	rec_rowid

		appl_num,		--	addr_num	
		appl_pfx,		--	addr_pfx
		appl_name,		--	addr_name
		appl_type,		--	addr_type
		appl_sfx,		--	addr_sfx

		appl_code1,		--	addr_code1
		appl_unit1,		--	addr_unit1
		appl_code2,		--	addr_code2
		appl_unit2		--	addr_unit2


	from	garland.TEMP_SYN

--	where	translate(addr_num, '/0123456789', '/') is null
	;

--	================================================================================

