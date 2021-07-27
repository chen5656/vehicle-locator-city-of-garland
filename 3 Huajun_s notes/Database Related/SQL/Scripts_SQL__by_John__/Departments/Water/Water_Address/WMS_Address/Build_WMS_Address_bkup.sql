	set echo 		off;
--	=================================================================================

	Truncate table	garland.WMS_ADDRESS	reuse storage;

--	=================================================================================
/*
	create or replace	view	garland.Temp_View		as

	select
		item01	addressid,
		item02	zone,
		item03	basin
	from	garland.GIS_Objects;

--	---------------------------------------------------------------------------------

	create or replace	view	garland.Temp_View1	as

	select
		item01	parcelid,
		item02	location_no
	from	garland.GIS_Temp1;
*/
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;
	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

--	insert --+ append
--	into	 garland.WMS_ADDRESS
(

	select	count(*)

/*		
	select	a.addressid,
			null,				-- subaddressid
			a.parcelid,
			u.location_no,

			a.streetnum,
			a.streetprefix,
			a.streetname,
			a.streettype,
			a.streetsuffix,
			null,				-- unitnum

			r.zone,
			r.basin
*/


	from	gis.ADDRESS			A,
		garland.Temp_View		R,	-- Regions
		garland.Temp_View1	U	-- UMS Location

	where	r.addressid		= rtrim(a.addressid)
	and	u.parcelid		= rtrim(a.parcelid)
);


	Commit;

--	=================================================================================
	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

	Rollback;
	Commit;

