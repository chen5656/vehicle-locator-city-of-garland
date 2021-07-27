--	=========================================================
--	gis_app_addr	view of esri tax extract	(nov 2001)
--	tax extract contains index number and address
--	tax extract is in gis_objects
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
	select	null,
			'',
			item02,		--	address
			'',
			'',
			'',		
			'',		
			'',
			null,			--	segment id
			null,			--	verify code
			item01,		--	esri index
			rowid
			,'***  ***'

	from		gis_objects;
