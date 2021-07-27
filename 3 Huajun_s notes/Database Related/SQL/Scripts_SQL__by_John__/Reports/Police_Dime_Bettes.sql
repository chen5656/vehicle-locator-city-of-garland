	set echo		off;
	set termout		ON;
	set serveroutput	on	size 999999;
--	======================================================================
--	generate "dime" list of all address ranges in Garland 
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
	from	sde.ROAD_GIS	T,			--  Versioned Table
		sde.ADDRESS_GIS			A,
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
		rpad(nvl(ltrim(t.leftbeat ),' '),04)   	l_beat,
		rpad(nvl(ltrim(garland.assign_beat_district(t.leftbeat) ),' '),04)   	l_dist,
		rpad(nvl(ltrim(t.leftfire ),' '),04)	l_fire,
		rpad(' ',5), ' ',				-- zipcode & council id
		rpad(nvl(ltrim(t.rightbeat),' '),04)   	r_beat,
		rpad(nvl(ltrim(garland.assign_beat_district(t.rightbeat) ),' '),04)   	r_dist,
		rpad(nvl(ltrim(t.rightfire),' '),04)	r_fire
	from	sde.ROAD_GIS	T		-- Versioned Table
	where	nvl(t.leftfrom, 0) > 0
	and	nvl(t.rightfrom,0) > 0
	and	not exists
(
	select 'x'
	from	sde.ADDRESS_GIS		A,
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
	and	look.left_side	= seg.left_side
	and	look.rght_side	= seg.rght_side
	then
		null;
	else
		dbms_output.put_line (	look.left_side ||' '|| look.rght_side  ||' '|| 
						look.st_pfx    ||' '|| look.st_name    ||' '||
						look.st_type   ||' '|| look.st_sfx     ||' '|| 
						look.l_beat	   ||' '|| look.l_dist	   ||' '|| look.l_fire   ||' '||
						look.zip_code  ||' '|| look.council_id ||' '||
						look.r_beat	   ||' '|| look.r_dist	   ||' '|| look.r_fire	
					); 

		report_count := report_count + 01;
	end if;

	seg	:= look;

end loop;

	dbms_output.put_line ('total records:  ' || report_count);

end;
