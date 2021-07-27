	set echo		off;
	set fetchrows	111;
	set charwidth	500;
--	===========================================================================

--	UMS BAD NUMBER HELP

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = 'xxx'	into garland.plan_table	for
--	===========================================================================

	select

		null, c.rec_key, chr(10),
		rpad( c.addr_num,6), rpad(c.addr_pfx,02), rpad(c.addr_name,20), rpad(c.addr_sfx,04), 
		'	CODE ADDRESS',	chr(10),

		rpad(ltrim(g.addr_num),06), g.addr_pfx, g.addr_name, g.addr_sfx,
		'		GIS  ADDRESS',	chr(10),

		rpad(ltrim(p.house_no),06), rpad(p.street_pfx_dir,02), rpad(p.street_nm,20), 
		rpad(p.street_nm_sfx,  04), rpad(p.street_sfx_dir,02),
		'	BILL ADDRESS',	chr(10),

		' ' 	" "
	from	garland.adrResult_UMS_location	c,
		garland.cdrelADR				g

		,sfg.um00100m@umsrep.world	l
		,sfg.um00250t@umsrep.world	x
		,sfg.um00200m@umsrep.world	a
		,sfg.sg00130t@umsrep.world	p

	where	g.addr_name			= c.addr_name
	and	g.addr_num		between c.addr_num - 08	
					and	  c.addr_num + 08

--	and	c.rec_key		= rtrim(l.location_no 	(+))
	and	c.rec_key		= rtrim(l.location_no )


	and	l.location_no	= x.location_no		--	(+)
	and	x.account_no	= a.account_no		--	(+)
	and	a.person_no		= p.person_no		--	(+)

	and	c.verify_code  between '40' and '49'

	and	x.service_stat	= 'CUTON'
	and	l.location_stat	= 'ACT'

	and	g.addr_num		= ltrim(rtrim(p.house_no))
--	and	(g.addr_num)	like	'%' || ltrim(p.house_no) ||'%'

--	and	g.addr_type		= c.addr_type
--	and	g.addr_pfx		= c.addr_pfx
--	and	g.addr_sfx		= c.addr_sfx
	;	

--	===========================================================================
--	select * from garland.explain_plan;
--	===========================================================================

	set echo		on;
	set fetchrows;
	set charwidth;

