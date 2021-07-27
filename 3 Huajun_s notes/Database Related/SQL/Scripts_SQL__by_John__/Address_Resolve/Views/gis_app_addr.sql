	set echo off;
--	===============================================================
--	gis_app_addr = adrResult_Source
--	===============================================================

	create or replace	view	garland.gis_app_addr
	(
		addr_num,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx,

		addr_code,
		addr_unit,

		parcel_id,
		segment_id,
		verify_code,

		rec_key,
		row_id
	)
	as
	select
		appl_num,			--	CHANGE
		appl_pfx,
		appl_name,
		appl_type,
		appl_sfx,

		appl_code1,
		appl_unit1,

		null,				--	parcel_id,
		null,				--	segment_id,
		null,				--	verify_code,

		rec_key,
		rec_rowid

	from	adrResult_Source
	;

--	===============================================================


