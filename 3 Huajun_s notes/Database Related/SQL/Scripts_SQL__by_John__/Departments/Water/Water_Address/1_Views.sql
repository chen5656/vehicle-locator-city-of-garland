	set echo off;
--	================================================================================================

	create or replace view	garland.Temp_View		as
	select	item01	PARCEL_ID,
			item02	LOCATION_NO,
			item03	WATER_ID
	from	garland.GIS_OBJECTS;

--	================================================================================================

	create or replace view	garland.Temp_View1	as
	select	item01	ADDRESS_ID,
			item02	ZONE,
			item03	BASIN
	from	garland.GIS_TEMP1;

--	================================================================================================

	analyze table	garland.GIS_OBJECTS	compute statistics;

	analyze table	garland.GIS_TEMP1		compute statistics;

--	================================================================================================

	select * from garland.temp_view	where rownum < 11;

	select * from garland.temp_view1	where rownum < 11;

--	================================================================================================

