	set echo off;
--	=================================================================================
--	Format initial code district extract (GIS_OBJECTS)
--	=================================================================================

	analyze table	garland.gis_objects		compute statistics;
	analyze table	garland.code_district_new	compute statistics;

--	=================================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan	set statement_id = 'aaa'	into garland.plan_table	for

--	=================================================================================
--	remove column header

	delete from garland.gis_objects  
	where lower(item01) like 'parcel%';

	commit;

--	=================================================================================
--	convert Parcel ID from text to number

	update  garland.gis_objects
	set	item01 = garland.convert_old_parcelid (item01);

	commit;

--	=================================================================================
--	remove trailing spaces

	update  garland.gis_objects
	set	item02 = rtrim(item02),
		item03 = rtrim(item03),
		item04 = rtrim(item04);
	
	commit;

--	=================================================================================
--	mark Parcel ID having unique code district

	update  garland.gis_objects		G
	set	item10 = 
(
	select 'x'
	from	 garland.gis_objects
	where	item01 = g.item01
	group by	item01
	having	count(distinct item02) = 1
);

	commit;

--	=================================================================================

	select
		rpad(item01,20)		item01,
		rpad(item02,20)		item02,
		rpad(item03,20)		item03,
		rpad(item04,20)		item04,
		rpad(item05,20)		item05,
		rpad(item06,20)		item06,
		rpad(item07,20)		item07,
		rpad(item08,20)		item08,
		' ' " "
	from	garland.gis_OBJECTS
	where	rownum < 111;

--	=================================================================================
--	select * from garland.explain_Plan;
--	=================================================================================
	set echo	on;
