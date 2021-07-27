 	set echo off;
--	===============================================================
--	adrResult_User = Sani_Asset
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
		null,
		rowid,

		addr_num,
		addr_pfx,
		addr_name,
		null,
		addr_sfx,

		addr_code,
		addr_unit,
		null, null

	from	sani_asset_view
	where	asset_type = 'FL'
	;

--	===============================================================

