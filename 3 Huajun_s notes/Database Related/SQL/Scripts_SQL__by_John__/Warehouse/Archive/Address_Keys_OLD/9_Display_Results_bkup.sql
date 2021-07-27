	set echo off;
--	=================================================================================
--	Show Totals & Percentages of each App Key
--	Show Sample of each App Key
--	=================================================================================

--	drop   synonym	temp_syn;
--	create synonym	temp_syn		for garland.Common_Address_KEYS;

	drop   synonym	temp_syn;
	create synonym	temp_syn		for garland.Common_Address_IDS;

--	=================================================================================
--	Show Totals & Percents

	select lpad(a.counter,10) "     TOTAL", 
		 lpad(g.counter,10) "       GIS", 	lpad(g.counter*100/a.counter,05) "%GIS",
		 lpad(t.counter,10) "       TAX",	lpad(t.counter*100/a.counter,05) "%TAX",
		 lpad(u.counter,10) "       UMS",	lpad(u.counter*100/a.counter,05) "%UMS",
		 lpad(c.counter,10) "      CODE",	lpad(c.counter*100/a.counter,05) "%CODE",
		 lpad(r.counter,10) "       REF",	lpad(r.counter*100/a.counter,05) "%REF"
	from

	(select count(*) counter from garland.Temp_Syn)	A,

	(select count(*) counter from garland.Temp_Syn	
		where Source = 'GIS')				G,

	(select count(*) counter from garland.Temp_Syn	
		where Source = 'TAX')				T,

	(select count(*) counter from garland.Temp_Syn	
		where Source = 'UMS')				U,

	(select count(*) counter from garland.Temp_Syn	
		where Source = 'CODE')				C,

	(select count(REF_key) counter from garland.Temp_Syn)		R;

--	=================================================================================
--	Show Sample

	select
		lpad(nvl(addr_num,     0),05)		"num", 
		rpad(nvl(addr_pfx,   ' '),02)		"pf", 
		rpad(nvl(addr_name,  ' '),20)		"name",
		rpad(nvl(addr_type,  ' '),04)		"type",	 
		rpad(nvl(addr_sfx,   ' '),02)		"sf"
		,rpad(nvl(addr_bldg, ' '),05)		"bldg"
		,rpad(nvl(addr_unit, ' '),05)		"unit"

		,rpad(GIS_key, 12)			"GIS"
		,rpad(TAX_key, 12)			"TAX"
		,rpad(UMS_key, 12)			"UMS"

		,rpad(REF_key, 12)			"REF"
		,rpad(Source,  06)			"Source"

	from	garland.Temp_Syn

	where	rownum < 11

	and	GIS_key  is not null
	and	TAX_key  is not null
	and	UMS_key  is not null

--	and	Source = 'GIS'
--	and	Source = 'TAX'
--	and	Source = 'UMS'
--	and	Source = 'CODE'
	;	

--	=================================================================================
	select lpad(count (distinct addr_name || addr_num || addr_type || addr_pfx || addr_sfx ),15) 
			"Empty REF Keys"
	from 	temp_syn
	where ref_key is null;

	select lpad(count (addr_name || addr_num || addr_type || addr_pfx || addr_sfx ),15)
			"Empty REF Recs"
	from 	temp_syn
	where ref_key is null;

--	=================================================================================
	set echo	on;


