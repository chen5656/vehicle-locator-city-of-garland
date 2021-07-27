--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
-- set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	===========================================================================
--	Build Basic UMS extract for general use by other routines
--	===========================================================================

	alter session	set nls_date_format = 'yyyy-mm-dd';

--	===========================================================================

	Truncate table	garland.Basic_UMS		reuse storage;

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = 'ums basic'	into garland.plan_table	for
--	===========================================================================

	insert	--+ append
	into		garland.Basic_UMS
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
	select max(service_seq)				-- Nov 2005
--	select min(service_seq)
	from	sfg.um00250t@umsrep.world
	where	location_no	 = x.location_no
	and	effective_dt = x.effective_dt
)
	and	ltrim(l.city)	like 'G%'
	and	x.service_stat	= 'CUTON'
	and	l.location_stat	= 'ACT'
	and	rtrim		(l.sec_addr_id)		is null
	and	rtrim(ltrim	(l.sec_addr_range))	is null
	;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	===========================================================================

	commit;

	analyze table	garland.Basic_UMS		compute statistics;

--	===========================================================================
--	UM00240T
--	and	s.account_no	= a.account_no
--	and	s.is_connect_yn	= 'T'

--	===========================================================================
/*

	select count(*)	"Units"			-- 14849
	from	 garland.Basic_UMS
	where	rtrim(addr_bldg) is not null
	or	rtrim(addr_unit) is not null;

	select sum(count(*))	"dupe locn"		-- 0
	from	sfg.um00100m@umsrep.world
	group by	location_no
	having	count(*) > 1;

	select sum(count(*))	"dupe acct"		-- 0
	from	 garland.Basic_UMS
	group by	location_no, account_no
	having	count(*) > 1;

	select sum(count(*))	"dupe pers"		-- 0
	from	 garland.Basic_UMS
	group by	location_no, person_no
	having	count(*) > 1;

	select distinct city,province_cd	
	from sfg.um00100m@umsrep.world;

*/
--	===========================================================================
	set echo		on;
	set timing		off;
