
--	=========================================================
--	gis_app_addr view of gis_objects
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
		parcel_id,
		segment_id,
		verify_code,
		rec_key,
		row_id
		,app_id
	)
	as
	select
			null,
			null,
			item01,
			null,
			null,
			
			null, null,
			null, null,
			null,

			item02,
			rowid
			,'***  ***'

	from		gis_objects;




