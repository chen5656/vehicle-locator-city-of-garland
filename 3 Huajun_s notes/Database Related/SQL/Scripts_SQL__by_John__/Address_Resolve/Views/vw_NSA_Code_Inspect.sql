	set echo off;
--	=========================================================
--	adrResult_User = NSA CODE INSPECT
--	=========================================================

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
		case_number,		--	rec_key		(unique key or rowid)
		rowid,			--	rec rowid

		addr_num,			--	addr_num
		addr_pfx,			--	addr_pfx
		addr_name,			--	addr_name		(street name)
		addr_type,			--	addr_type
		addr_sfx,			--	addr_sfx

		unit_code,			--	addr_code1
		unit_num,			--	addr_unit1
		'',				--	addr_code2
		''				--	addr_unit2

	from	garland.NSA_CODE_INSPECT
	;

--	=========================================================
