 	set echo off;
--	===============================================================
--	adrResult_User = 
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

		MACCTNO,		--	record key
		rowid,		--	record rowid

		substr(PROPADDR,21,06),			--	addr_num,
		substr(PROPADDR,19,01),			--	addr_pfx,
		rpad  (PROPADDR,18),			--	addr_name,
		rtrim(substr(PROPADDR,27,04)),	--	addr_type,
		'',						--	addr_sfx,

		'',		--	addr_code1,
		'',		--	addr_unit1,
		'',		--	addr_code2, 
		''		--	addr_unit2

	from	garland.TAX
	;

--	===============================================================
