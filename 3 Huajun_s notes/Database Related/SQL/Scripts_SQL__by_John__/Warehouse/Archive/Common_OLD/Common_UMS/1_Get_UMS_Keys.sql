--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
-- set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	===========================================================================
--	Extract basic UMS Keys
--	===========================================================================

	alter session	set nls_date_format = 'yyyymmdd';

	Truncate table	garland.gis_Temp4		reuse storage;

--	===========================================================================
	create or replace view	garland.Temp_View4	as
	select
		item01		location_no,
		item02		account_no,
		item03		service_seq,
		item04		person_no,
		item05		effective_dt
	from	garland.gis_TEMP4;

--	===========================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan set statement_id = 'basic key1'	into garland.plan_table	for
--	===========================================================================

--	TOTAL RECORDS = 608337
--	RUN TIME	  = 920 secs = 15.33 min

--	===========================================================================

	insert --+ append
	into garland.Temp_View4
	
	select 
		l.location_no, a.account_no, x.service_seq, p.person_no, x.effective_dt 

	from	sfg.um00250t@umsrep.world		X,	-- crossref
		sfg.um00100m@umsrep.world		L,	-- location
		sfg.um00200m@umsrep.world		A,	-- account
		sfg.sg00100m@umsrep.world		P	-- person

	where	x.location_no = l.location_no
	and	x.account_no  = a.account_no
	and	p.person_no	  = a.person_no

	and	rtrim(x.service_stat)	  	   =  'CUTON'
	and	nvl(rtrim(l.location_stat),' ') in ('ACT')
	and	nvl(rtrim(p.person_stat),  ' ') in ('ACT', ' ')
	and	ltrim(l.city) 			like  'G%'
	and	rtrim		(l.sec_addr_id)	  is null
	and	rtrim(ltrim	(l.sec_addr_range)) is null
	;

	Commit;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	===========================================================================

	select count(*) from garland.Temp_View4;

	analyze table	garland.gis_Temp4		compute statistics;

--	===========================================================================
