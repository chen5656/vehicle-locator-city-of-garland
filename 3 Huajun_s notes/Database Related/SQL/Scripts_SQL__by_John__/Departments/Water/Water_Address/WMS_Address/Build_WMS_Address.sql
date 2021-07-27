	set echo 		off;
--	=================================================================================
--	WMS ADDRESS holds less than this extract generates
--	check with Morgan on WMS ADDRESS origin


--	into	 garland.WMS_ADDRESS							-- 108000
--	select	count(*)								-- 126350
--	select	count(distinct a.mslink||'.'||u.location_no)		-- 125900

--	=================================================================================

--	=================================================================================
--	PREPARATION

--	Load GIS_OBJECTS & GIS_TEMP1 
--	from \\deacutis\loader\WATER_ADDRESS_UMS & WATER_ADDRESS_ZONE_BASIN

--	=================================================================================

--	TRUNCATE table	garland.WMS_ADDRESS	reuse storage;

--	=================================================================================
--	loader\WATER_ADDRESS_ZONE_BASIN

/*
	create or replace	view	garland.Temp_View		as

	select
		item01	addressid,
		item02	zone,
		item03	basin
	from	garland.GIS_Temp1;

--	---------------------------------------------------------------------------------
--	loader\WATER_ADDRESS_UMS 
	
	create or replace	view	garland.Temp_View1	as

	select
		item01	parcelid,
		item02	location_no
	from	garland.GIS_objects;

*/

--	=================================================================================

--	update  garland.temp_view1
--	set	parcelid	= garland.convert_old_parcelid (parcelid);

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

--	insert --+ append
--	into	 garland.WMS_ADDRESS							-- 108000
(

--	select	count(*)								-- 126350
	select	count(distinct a.mslink||'.'||u.location_no)		-- 125900

/*	
	select	distinct	

			a.mslink,
			null,				-- subaddressid
			a.parcel_id_new,
			u.location_no,

			a.addr_num.
			a.addr_pfx,
			a.addr_name,
			a.addr_type,
			a.addr_sfx,
			null,				-- unitnum

			r.zone,
			r.basin,
			null				-- fire district
*/


	from	garland.cdreladr		A,
		garland.Temp_View		R,	-- Regions
		garland.Temp_View1	U	-- UMS Location

	where	r.addressid		= rtrim(a.mslink)
	and	u.parcelid		= rtrim(a.parcel_id)
	and	ltrim(a.unit_num) is null
);


	Commit;

--	=================================================================================
--	display duplicate addresses

/*
	select address_id, custserv_id, streetnum, streetprefix, streetname, streettype, streetsuffix
	from	garland.WMS_ADDRESS
	where address_id  in
(
	select address_id
	from garland.WMS_Address
	group by address_id
	having count(*) > 1
)
	order by streetname, streettype, streetprefix, streetsuffix, streetnum;
*/

--	=================================================================================
/*

	select sum(counter) from	--232
	(select count(*) counter from garland.temp_view1
	 group by location_no  having count(*) > 1);

	select sum(counter) from	-- null
	(select count(*) counter from garland.temp_view
	 group by addressid  having count(*) > 1);

*/
--	=================================================================================
--	select * from garland.explain_Plan;
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

