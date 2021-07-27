	set echo off;
--	================================================================================================

	create or replace view	garland.Temp_View	as
	select	item01	parcel_id,
			item02	location_no,
			item03	water_id
	from	garland.GIS_OBJECTS;

--	================================================================================================

	select * from garland.Temp_View  where water_id is not null and rownum < 11;

	update garland.Temp_View
	set	location_no = water_id
	where	location_no = '0';	

	commit;

--	================================================================================================
/*
	update garland.Temp_View
	set	parcel_id = garland.Convert_Old_ParcelID(Parcel_ID)

	select parcel_id from garland.Temp_View where rownum < 11;

	rollback;
*/
--	================================================================================================

