	set echo on;

	update garland.code_district
	set parcel_id_old = garland.convert_new_parcelid(parcel_id);

	select parcel_id, parcel_id_old from garland.code_district where rownum < 11;


	commit;
	rollback;