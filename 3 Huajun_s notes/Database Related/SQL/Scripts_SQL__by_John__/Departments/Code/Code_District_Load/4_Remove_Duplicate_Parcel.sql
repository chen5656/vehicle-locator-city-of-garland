	set echo	off;
--	======================================================================================================
--	Remove duplicate Parcel ID
--	TEMPORARY work around
--	======================================================================================================

	truncate table	garland.gis_objects	reuse storage;

	insert --+ append
	into	garland.gis_objects
	(	item01, item02, item03, item04, item05, item06, item07, item08, item09, item10, item11	)

	select * from garland.code_district_new
	union
	select * from garland.code_district_new
	;

	commit;

--	======================================================================================================

	truncate table	garland.code_district_new	reuse storage;

	insert --+ append
	into	garland.code_district_new

	select item01, item02, item03, item04, item05, item06, item07, item08, item09, item10, item11	
	from	garland.gis_objects;

	commit;

--	======================================================================================================
