	set echo	off;

--	=======================================================================
--	update CDRELPAR region from ESRI extract
--	=======================================================================

--	=======================================================================
--	Prepare Input

--	save ESRI extract as \\loader\esri_region.dat
--	truncate table esri_address
--	sql*load using esri_region.ctl & esri_region.dat

--	define tmp_view of table to be updated	(see \\Views.sql)

--	update region in adrBlock_Side		(see \\adrTable\bld_adrBlock_Side_...)
--	=======================================================================

--	analyze table	gis_objects		compute statistics;
--	=======================================================================

	alter rollback segment	rb1		online;
	set transaction	use rollback segment rb1;

--	=======================================================================
	truncate table	plan_table;
	explain plan	set statement_id = 'a'		for

	update tmp_view1		v
	set	 region	=
(
	select
		  nvl (min(e.region), v.region)
	from	  esri_address	e
	where	  e.mslink		= rtrim(v.mslink)
--	where	  e.parcel_id	= v.parcel_id
);

	select * from explain_plan;
--	select * from explain_indexed;
--	=======================================================================
	
	commit;
	alter rollback segment	rb1		offline;

--	=======================================================================

--	select a.*
	select count(*) 

	from	 tmp_view		v,
		 cdreladr		a
	where	v.region_id is null
	and	v.parcel_id = a.parcel_id

/*
	and	a.parcel_id in
	(
	select parcel_id
	from 	 cdrelpar
	group by parcel_id
	having count(*) > 1
	)
*/

;

--	=======================================================================

	set echo	on;
