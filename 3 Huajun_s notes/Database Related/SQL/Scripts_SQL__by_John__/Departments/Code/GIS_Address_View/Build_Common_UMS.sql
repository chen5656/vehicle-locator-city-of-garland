	set echo		off;
	set timing		OFF;
	set fetchrows;
--	===========================================================================

--	alter session  set nls_date_format = 'yyyy-mm-dd';

--	===========================================================================

	truncate table	garland.Common_UMS	reuse storage;

--	truncate table	garland.GIS_Objects	reuse storage;

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id = 'common ums'	into garland.plan_table	for
--	===========================================================================

	insert	--+ append
	into		garland.Common_UMS

--	insert	--+ append
--	into		garland.GIS_Objects 
--			(item01, item02, item03, item04, item05, item06, item07, item08)

	select	distinct
		r.segment_id,				-- SHOULD BE ADDRESS ID

		x.location_no,
		x.account_no,
		p.person_no,
--		x.service_seq,

		ltrim(rtrim(p.person_lnm)),
		ltrim(rtrim(p.person_fnm)),
		ltrim(rtrim(p.i_drivers_lic_no)),
		p.birth_inc_dt,

		r.segment_id				-- SHOULD BE MSLINK

	from	sfg.um00250t@umsrep.world			X,	-- xref
		sfg.um00100m@umsrep.world			L,	-- location
		sfg.um00200m@umsrep.world			A,	-- account
		sfg.sg00100m@umsrep.world			P,	-- person
		garland.adrResult_UMS_Location	R	-- GIS
--		,sfg.um00240t@umsrep.world		S	-- status

	where	(x.location_no, x.effective_dt) in
(
	select
		location_no,
		max(effective_dt)
	from	sfg.um00250t@umsrep.world
	group by  location_no
)

	and	l.location_no	= x.location_no
	and	a.account_no	= x.account_no
	and	a.person_no		= p.person_no
--	and	a.account_no	= s.account_no

	and	r.rec_key		= rtrim(l.location_no)	

	and	x.service_stat	= 'CUTON'
	and	l.location_stat	= 'ACT'
--	and	s.is_connect_yn	= 'T'

	and	ltrim(rtrim(l.sec_addr_range)) is null		--	ignore address units

	order by	1,2,3,4;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	===========================================================================

	commit;
	alter rollback segment rb1 offline;

	analyze table	garland.Common_UMS		compute statistics;

--	===========================================================================
/*
--	HOW MANY DUPLICATE UMS KEYS

	select counter, count(*)
	from
(
	select count(*) counter
	from GIS_Objects
	group by item01
	having count(*) > 1
)
	group by counter
	having count(*) > 1;
*/
--	===========================================================================
	set echo		on;
	set timing		off;
	set fetchrows;

