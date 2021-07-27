	set echo	off;
	set timing	on;

	truncate table	plan_table;
	explain plan 	set statement_id = 'a'		for
--	===============================================================================================

	select 	distinct  

	a.location_no,
	a.asset_no,
	a.set_dt,
	a.ams_asset_tp,

	jdeacutis.ums_fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SHARE')	share_cont,
	jdeacutis.ums_fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'ROUTE')	route,
	jdeacutis.ums_fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MULT' )	mult,
	jdeacutis.ums_fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MON')	MO,
	jdeacutis.ums_fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'TUE')	TU,
	jdeacutis.ums_fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'WED')	WD,
	jdeacutis.ums_fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'THU')	TH,
	jdeacutis.ums_fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'FRI')	FR,
	jdeacutis.ums_fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SAT')	SA,
	jdeacutis.ums_fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SUN')	SU,

	jdeacutis.ums_attrib_value (c.asset_area, c.asset_type,c.Asset_no,'SIZE' )		sizes,
	jdeacutis.ums_attrib_value (c.asset_area, c.asset_type,c.Asset_no,'CONT#')		Container, 
	jdeacutis.ums_attrib_value (c.asset_area, c.asset_type,c.Asset_no,'OWNER')		Owner,

--	sfg.fa_value@umsp.world ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SHARE')	share_cont,
--	sfg.fa_value@umsp.world ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'ROUTE')	route,
--	sfg.fa_value@umsp.world ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MULT' )	mult,
--	sfg.fa_value@umsp.world ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MON')		MO,
--	sfg.fa_value@umsp.world ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'TUE')		TU,
--	sfg.fa_value@umsp.world ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'WED')		WD,
--	sfg.fa_value@umsp.world ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'THU')		TH,
--	sfg.fa_value@umsp.world ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'FRI')		FR,
--	sfg.fa_value@umsp.world ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SAT')		SA,
--	sfg.fa_value@umsp.world ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SUN')		SU,

--	sfg.attrib_value@umsp.world(c.asset_area, c.asset_type,c.Asset_no,'SIZE' )		sizes,
--	sfg.attrib_value@umsp.world(c.asset_area, c.asset_type,c.Asset_no,'CONT#')		Container, 
--	sfg.attrib_value@umsp.world(c.asset_area, c.asset_type,c.Asset_no,'OWNER')		Owner,

	b.house_no, b.street_pfx_dir, b.street_nm, b.street_nm_sfx, b.city,
	b.sec_addr_id, b.sec_addr_range, 

	f.person_lnm

	from	sfg.UM00155T@umsp.world		a, 
		sfg.um00100m@umsp.world		b, 
		sfg.AM00100m@umsp.world		c, 
		sfg.UM00250T@umsp.world		e, 
		sfg.UM00200M@umsp.world		f

	where 

	a.location_no	= b.location_no	and
	a.location_no	= e.location_no	and
	a.service_seq	= e.service_seq	and
	e.account_no	= f.account_no	and

	a.asset_no		= c.asset_no	and
	a.ams_asset_tp	= c.asset_type	and 

	a.ams_asset_tp	= 'FL'		and
	a.pull_dt		is null
	

	and	a.location_no	between 01	and 100
;

--	===============================================================================================
	select * from explain_plan;

	set echo	on;
	set timing	off;

