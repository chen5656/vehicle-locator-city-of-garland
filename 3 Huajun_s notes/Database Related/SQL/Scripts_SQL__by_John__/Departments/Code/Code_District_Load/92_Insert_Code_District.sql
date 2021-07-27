	set echo	off;
--	=================================================================================
--	Insert new Code Districts from Fred
--	=================================================================================

--	analyze table	garland.gis_objects		compute statistics;
--	analyze table	garland.code_district		compute statistics;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = 'bbb'	into garland.plan_table	for
--	=================================================================================

	select count(*) from

--	insert into garland.Code_District		C
(
	select distinct
		g.item01,
		g.item02,
		g.item03,
		g.item04,
		p.council_id,
		p.police_beat,
		p.zip_code

	from	garland.GIS_Objects	G,
		garland.CDRELPAR		P

	where	g.item01	= p.parcel_id
	and	g.item10 	= 'x'

	and not exists
(
	select 'x'
	from	 garland.Code_District
	where	 parcel_id = garland.convert_new_parcelid (p.parcel_id)
)
);

	commit;

--	=================================================================================
--	what are the new Code District Parcel IDs

/*


	select item01	from
(
	select item01 			from garland.gis_objects
	minus
	select lpad(parcel_id,7,'0') 	from garland.code_district
)
	order by 1;



*/
--	=================================================================================
--	select * from garland.explain_Plan;
--	=================================================================================
	set echo	on;

