	set echo off;
--	=================================================================================
--	Show Totals & Percentages of each App Key
--	Show Sample of each App Key
--	=================================================================================

	drop   synonym	garland.temp_syn;
	create synonym	garland.temp_syn		for garland.Common_Address_KEYS;

--	drop   synonym	garland.temp_syn;
--	create synonym	garland.temp_syn		for garland.Common_Address_IDS;

--	=================================================================================
--	Show Totals & Percents

	select lpad(a.counter,10) "     TOTAL", 
		 lpad(g.counter,10) "       GIS", 	lpad(g.counter*100/a.counter,05) "%GIS",
		 lpad(t.counter,10) "       TAX",	lpad(t.counter*100/a.counter,05) "%TAX",
		 lpad(u.counter,10) "       UMS",	lpad(u.counter*100/a.counter,05) "%UMS",
		 lpad(p.counter,10) "       PID",	lpad(p.counter*100/a.counter,05) "%PID"
	from
	(select count(*) counter from garland.Temp_Syn)	A,
	(select count(*) counter from garland.Temp_Syn	
		where Source = 'GIS')				G,
	(select count(*) counter from garland.Temp_Syn	
		where Source = 'TAX')				T,
	(select count(*) counter from garland.Temp_Syn	
		where Source = 'UMS')				U,
	(select count(PARCEL_ID) counter from garland.Temp_Syn)	P;


--	=================================================================================
--	Show Sample

	select
		lpad(nvl(addr_num,     0),05)		"num", 
		rpad(nvl(addr_pfx,   ' '),02)		"pf", 
		rpad(nvl(addr_name,  ' '),20)		"name",
		rpad(nvl(addr_type,  ' '),04)		"type",	 
		rpad(nvl(addr_sfx,   ' '),02)		"sf"
--		,rpad(nvl(addr_code, ' '),04)		"code"
--		,rpad(nvl(addr_bldg, ' '),04)		"bldg"
--		,rpad(nvl(addr_unit, ' '),04)		"unit"
		,rpad(GIS_key, 12)			"GIS"
		,rpad(TAX_key, 12)			"TAX"
		,rpad(UMS_key, 12)			"UMS"
		,rpad(PARCEL_ID, 11)			"PARCEL ID"
		,rpad(Source, 06)				"Source"
	from	garland.Temp_Syn
	where	rownum < 111

--	and	GIS_key  is not null
--	and	TAX_key  is not null
--	and	UMS_key  is not null
--	and	Source = 'GIS'
--	and	Source = 'TAX'
--	and	Source = 'UMS'
	;	

--	=================================================================================
