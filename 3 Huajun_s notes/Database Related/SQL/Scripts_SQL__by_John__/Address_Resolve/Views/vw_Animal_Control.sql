--	=========================================================
--	gis_app_addr view of Animal_Control_Log
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
			null,
			addr_name,
			null,
			null,
			null,
			null,
			parcel_id,
			null,
			null,
			rec_key,
			rowid
			,'***  ***'

	from		animal_control_log

	where		length(addr_name) <= 40
	and		lower (addr_name) not like '%blk%'
	;
