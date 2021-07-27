
--	=========================================================
--	gis_app_addr view of gis_objects for library
--	=========================================================

	create or replace	view	garland.gis_app_addr		
	(
		addr_num,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx,
		addr_code,
		addr_unit,

--		parcel_id,
--		segment_id,
--		verify_code,

		rec_key,
		row_id
		,app_id
	)
	as
	select
			addr_num,
			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,
			addr_code,
			addr_unit,

			patron_key,
			rowid
			,'***  ***'

	from		library_patron

	;
--	=====================================================================================================
