	set echo		off;
    set linesize	2000;
	set timing		on;
--	===========================================================================
--	Build Basic UMS extract for general use by other routines
--	===========================================================================

	alter session  set nls_date_format = 'yyyymmdd';

--	===========================================================================

	truncate table	garland.GIS_Temp4		reuse storage;

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id = 'ums basic'	into garland.plan_table	for
--	===========================================================================

	insert	--+ append

	into		garland.GIS_Temp4
	(
		item01, item02, item03, item04, 
		item05, 
		item06, item07, item08, item09, item10, item11, 
		item12, item13, item14, item15, item16, item17, item18
	)

	select	
		x.location_no,
		x.account_no,
		x.service_seq,
		p.person_no,

		x.effective_dt,

		ltrim(rtrim	(p.person_lnm)),
		ltrim(rtrim	(p.person_fnm)),
		p.birth_inc_dt,
		ltrim(rtrim	(p.i_drivers_lic_no)),
		rtrim		(p.o_fen),
		rtrim		(p.i_gender),

		rtrim(ltrim	(l.house_no)),
		rtrim		(l.street_pfx_dir),
		rtrim		(l.street_nm),
		rtrim		(l.street_nm_sfx),
		rtrim		(l.street_sfx_dir),
		rtrim		(l.sec_addr_id),
		rtrim(ltrim	(l.sec_addr_range))

	from	sfg.um00250t@umsrep.world		X,	-- crossref
		sfg.um00100m@umsrep.world		L,	-- location
		sfg.um00200m@umsrep.world		A,	-- account
		sfg.sg00100m@umsrep.world		P	-- person

	where	x.location_no = l.location_no
	and	x.account_no  = a.account_no
	and	p.person_no	  = a.person_no

	and	x.effective_dt	in
(
	select max(effective_dt)
	from	sfg.um00250t@umsrep.world
	where	location_no	 = x.location_no
)							

	and	x.service_seq	=
(
	select min(service_seq)
	from	sfg.um00250t@umsrep.world
	where	location_no	 = x.location_no
	and	effective_dt = x.effective_dt
)

	and	x.service_stat	= 'CUTON'
	and	l.location_stat	= 'ACT'
	and	l.city		= 'GARLAND'
	and	l.province_cd	= 'TX'

--	and	l.location_no  between  40000 and 44110		-- T E S T    T E S T    T E S T

--	order by 1
	;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	===========================================================================

	commit;
	alter rollback segment rb1 offline;

--	analyze table	garland.GIS_Temp4		compute statistics;

--	===========================================================================
--	UM00240T
--	and	s.account_no	= a.account_no
--	and	s.is_connect_yn	= 'T'

--	===========================================================================
--	POSSIBLE INFO
--	location	asset
--	account	cycle_cd
--	account	account_stat
--	account	account_stat_start_dt

--	===========================================================================
	set echo		on;
	set timing		off;

