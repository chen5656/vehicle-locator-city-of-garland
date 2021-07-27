	set echo off;
--	===============================================================
--	"Null View" of original application address in gis_verify_addr
--	===============================================================

	create or replace	view	garland.gis_app_addr_null		
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
		null,
		null,
		null,
		null,
		null,
		null,
		null,

		parcel_id,
		segment_id,
		verify_code,

		rec_key,
		rowid

	from	gis_app_addr
	;

--	===============================================================


