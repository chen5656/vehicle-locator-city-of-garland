	set echo	off;
--	=================================================================================
--	Update Code District with records from Fred
--	=================================================================================

--	analyze table	garland.gis_objects		compute statistics;
--	analyze table	garland.code_district		compute statistics;

--	=================================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan	set statement_id = 'ccc'	into garland.plan_table	for
--	=================================================================================

--	select count(council_id)	from

	update garland.Code_District	C

	set	( parcel_id, district, inspector, phone,  council_id, police_beat, zip_code)		=
(
	select distinct
		nvl(g.item01,	cc.parcel_id),
		nvl(g.item02,	cc.district),
		nvl(g.item03,	cc.inspector),
		nvl(g.item04,	cc.phone),
		nvl(p.council_id, cc.council_id)		council_id,
		nvl(p.police_beat,cc.police_beat),
		nvl(p.zip_code,   cc.zip_code)

	from	garland.Code_District	CC,
		garland.GIS_Objects	G,
		garland.cdrelpar		P

--		,garland.Code_District	C

	where	cc.rowid				= c.rowid
	and	lpad(cc.parcel_id,7,'0')	= g.item01 (+)
	and	'x'					= g.item10 (+)	
	and	p.parcel_id	(+)			= garland.convert_new_parcelid (cc.parcel_id)
);


--	where	c.parcel_id < 0200000

--	=================================================================================

	select * from garland.code_district  where rownum < 22	and parcel_id < 0200000;

--	=================================================================================
--	select * from garland.explain_Plan;
--	=================================================================================

--	rollback;
	commit;

--	=================================================================================
	set echo	on;

