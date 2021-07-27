	set echo		off;
--	set fetchrows	111;
	set charwidth	500;
--	===========================================================================

--	UMS BAD NUMBER HELP

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = 'xxx'	into garland.plan_table	for
--	===========================================================================

	select	distinct

		null, u.rec_key, 			u.verify_code,			chr(10),
		rpad( u.addr_num,6), rpad(u.addr_pfx,02), rpad(u.addr_name,20), 
			rpad(u.addr_type,04), rpad(u.addr_sfx,04), 
		'UMS  ADDRESS',	chr(10),

		rpad(ltrim(g.addr_num),06), g.addr_pfx, g.addr_name, g.addr_type, g.addr_sfx,
		'	GIS  ADDRESS',	chr(10),

		rpad(ltrim(b.house_no),06), rpad(b.street_pfx_dir,02), rpad(b.street_nm,20), 
		rpad(b.street_nm_sfx,  04), rpad(b.street_sfx_dir,02),
		'	BILL ADDRESS',	chr(10),

		' ' 	" "
	from	garland.adrResult_UMS_location	u,
		garland.cdrelADR				g

		,sfg.um00100m@umsrep.world	l
		,sfg.um00250t@umsrep.world	x
		,sfg.um00200m@umsrep.world	a
		,sfg.sg00130t@umsrep.world	b

	where	g.addr_name			= u.addr_name
	and	g.addr_num		between u.addr_num - 08	
					and	  u.addr_num + 08

--	and	u.rec_key		= rtrim(l.location_no 		(+))
	and	u.rec_key		= rtrim(l.location_no )

	and	l.location_no	= x.location_no		--	(+)
	and	x.account_no	= a.account_no		--	(+)
	and	a.person_no		= b.person_no		--	(+)

	and	b.street_nm	like 	  g.addr_name || '%'

	and	rtrim(u.addr_num)	<> ltrim(rtrim(b.house_no))
--	and	rtrim(g.addr_num)	 = ltrim(rtrim(b.house_no))

	and	u.verify_code  between '20' and '49'

	and	x.service_stat	= 'CUTON'
	and	l.location_stat	= 'ACT'

	and	u.addr_num <> g.addr_num	--  FUDGE FACTOR
	;	

--	===========================================================================
--	select * from garland.explain_plan;
--	===========================================================================
	set echo		on;
	set fetchrows;
	set charwidth;
