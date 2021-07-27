
--	======================================================================================
	truncate table	garland.plan_table;
	explain plan	set statement_id = 'test'	into garland.plan_table	for
--	======================================================================================

	select --+ all_rows
		lpad(t.leftfrom, 05) ||'-'|| rpad(t.leftto, 05)	left_side,
		lpad(t.rightfrom,05) ||'-'|| rpad(t.rightto,05)	rght_side,

		rpad(t.streetprefix, 02)			st_pfx,	
		rpad(t.streetname,   20)			st_name,
		rpad(t.streettype,   04)			st_type,	
		rpad(t.streetsuffix, 02)			st_sfx,

		rpad(nvl(ltrim(t.leftbeat ),' '),04)   	l_beat,
		rpad(nvl(ltrim(garland.assign_beat_district(t.leftbeat) ),' '),04)   	l_dist,
		rpad(nvl(ltrim(t.leftfire ),' '),04)	l_fire,

		p.zip_code,
		p.council_id,

		rpad(nvl(ltrim(t.rightbeat),' '),04)   	r_beat,
		rpad(nvl(ltrim(garland.assign_beat_district(t.rightbeat) ),' '),04)   	r_dist,
		rpad(nvl(ltrim(t.rightfire),' '),04)	r_fire

	from	jdeacutis.ROAD_GIS	T,			--  Versioned Table
		gis.ADDRESS			A,
		garland.cdrelpar		P

	where	p.parcel_id		= lpad(a.parcelid,7,'0') || '.000'
	
	and	nvl(t.leftfrom, 0) > 0
	and	nvl(t.rightfrom,0) > 0

	and	a.streetname	= t.streetname
	and	a.streettype	= t.streettype
	and	a.streetprefix	= t.streetprefix
	and	a.streetsuffix	= t.streetsuffix
	and	a.streetnum 	>= t.rangelo
	and	a.streetnum 	<= t.rangehi

	UNION

	select
		lpad(t.leftfrom, 05) ||'-'|| rpad(t.leftto, 05)	left_side,
		lpad(t.rightfrom,05) ||'-'|| rpad(t.rightto,05)	rght_side,

		rpad(t.streetprefix, 02)			st_pfx,	
		rpad(t.streetname,   20)			st_name,
		rpad(t.streettype,   04)			st_type,	
		rpad(t.streetsuffix, 02)			st_sfx,

		null, null, null, null, null, null, null, null

	from	jdeacutis.ROAD_GIS	T			-- Versioned Table

	where	nvl(t.leftfrom, 0) > 0
	and	nvl(t.rightfrom,0) > 0

	and	not exists
(
	select 'x'
	from	gis.ADDRESS		A,
		garland.cdrelpar	P

	where	p.parcel_id		= lpad(a.parcelid,7,'0') || '.000'

	and	nvl(t.leftfrom,0) > 0
	and	nvl(t.leftto,  0) > 0

	and	a.streetname		= t.streetname
	and	a.streettype	 	= t.streettype
	and	a.streetprefix		= t.streetprefix
	and	a.streetsuffix		= t.streetsuffix
	and	a.streetnum 		>= t.rangelo
	and	a.streetnum 		<= t.rangehi
)
	order by	st_name, st_type, st_pfx, st_sfx, left_side, l_beat desc;

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
--	select * from explain_plan;
--	=================================================================================
