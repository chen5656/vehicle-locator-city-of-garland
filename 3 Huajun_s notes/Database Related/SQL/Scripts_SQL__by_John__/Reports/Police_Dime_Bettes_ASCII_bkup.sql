	set echo		off;
	set termout		ON;
	set serveroutput	on	size 999999;
--	======================================================================
--	generate "Dime" ASCII of all address ranges in Garland 
--	======================================================================


declare
		do_compile		number	:= 0;

		report_count	number	:= 0;

cursor	Read_Dime_Info			is

--	======================================================================================
--	truncate table	garland.plan_table;
--	explain plan	set statement_id = 'test'	into garland.plan_table	for
--	======================================================================================

	select --+ all_rows
		t.leftfrom,  
		t.leftto,	
		t.rightfrom, 
		t.rightto,	
		t.streetprefix						st_pfx,	
		t.streetname						st_name,
		t.streettype						st_type,	
		t.streetsuffix						st_sfx,
		t.leftbeat    						l_beat,
		garland.assign_beat_district(t.leftbeat)   	l_dist,
		t.leftfire 							l_fire,
		p.zip_code,	
		p.council_id,
		t.rightbeat   						r_beat,
		garland.assign_beat_district(t.rightbeat)   	r_dist,
		t.rightfire							r_fire
	from	sde.ROAD_GIS	T,			
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
		t.leftfrom,  
		t.leftto,	
		t.rightfrom, 
		t.rightto,	
		t.streetprefix					st_pfx,	
		t.streetname					st_name,
		t.streettype					st_type,	
		t.streetsuffix					st_sfx,
		t.leftbeat 						l_beat,
		garland.assign_beat_district(t.leftbeat)	l_dist,
		t.leftfire 						l_fire,
		null, null,					
		t.rightbeat						r_beat,
		garland.assign_beat_district(t.rightbeat) r_dist,
		t.rightfire						r_fire
	from	sde.ROAD_GIS	T		
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
	order by	st_name, st_type, st_pfx, st_sfx, leftfrom, l_beat desc;

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
--	select * from explain_plan;
--	=================================================================================

	SEG		Read_Dime_Info%rowtype;

--	=================================================================================


begin

	if	do_compile > 0		then
		return;
	end if;

for look in	read_dime_info		loop

	if	look.st_name	= seg.st_name
	and	look.st_type	= seg.st_type
	and	look.st_pfx		= seg.st_pfx
	and	look.st_sfx		= seg.st_sfx
	and	look.leftfrom	= seg.leftfrom
	and	look.leftto		= seg.leftto
	and	look.rightfrom	= seg.rightfrom
	and	look.rightto		= seg.rightto
	then
		null;
	else
		dbms_output.put_line (	look.leftfrom ||';'|| look.leftto	   ||';'|| 		
						look.rightfrom||';'|| look.rightto	   ||';'|| 
						look.st_pfx    ||';'|| look.st_name    ||';'||
						look.st_type   ||';'|| look.st_sfx     ||';'|| 
						look.l_beat	   ||';'|| look.l_dist	   ||';'|| look.l_fire   ||';'||
						look.zip_code  ||';'|| look.council_id ||';'||
						look.r_beat	   ||';'|| look.r_dist	   ||';'|| look.r_fire	
					); 

		report_count := report_count + 01;
	end if;

	seg	:= look;

end loop;

	dbms_output.put_line ('total records:  ' || report_count);

end;
