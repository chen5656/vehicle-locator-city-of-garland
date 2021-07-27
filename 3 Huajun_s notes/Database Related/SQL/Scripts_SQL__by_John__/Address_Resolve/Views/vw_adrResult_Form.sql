 	set echo off;
--	===============================================================
--	adrResult_User = adrResult_Input
--	===============================================================

	drop synonym	garland.adrResult;

	create synonym	garland.adrResult		for adrResult_Extract;

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

		addr_num,		--	addr_num	
		form_pfx,		--	addr_pfx
		form_name,		--	addr_name
		form_type,		--	addr_type
		form_sfx,		--	addr_sfx

		form_code1,		--	addr_code1
		form_unit1,		--	addr_unit1
		form_code2,		--	addr_code2
		form_unit2		--	addr_unit2

	from	garland.adrResult	

	where	translate (addr_num, '/0123456789', '/' ) is null	-- insure addr_num is numeric
	;
