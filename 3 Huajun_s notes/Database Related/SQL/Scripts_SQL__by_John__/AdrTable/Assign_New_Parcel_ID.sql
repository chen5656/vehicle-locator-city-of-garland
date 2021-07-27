	set echo off;
--	=================================================================

	update garland.cdrelpar 
	set parcel_id_new = garland.convert_new_parcelid (parcel_id);

	select parcel_id, parcel_id_new from garland.cdrelpar where rownum < 11;

	commit;

--	=================================================================
