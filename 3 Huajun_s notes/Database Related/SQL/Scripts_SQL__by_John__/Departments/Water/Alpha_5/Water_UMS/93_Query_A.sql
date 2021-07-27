	set echo	off;
--	=================================================================================
--	Obtain UMS addresses to be matched against Water Alpha5 (per adrResult)
--	=================================================================================

--	adrResult_Alpha5		total = 68161
--	adrResult_Alpha5		basic = 66338	(w/out units)

--	adrResult_Alpha5		dupes:  count= 1796   sum = 8545
--	adrResult_Alpha5		dupes:  count= 1524   sum = 6693	(w/out units)

--	=================================================================================
	truncate table	garland.plan_table	reuse storage;
	explain plan set statement_id = ' '		into garland.plan_table	for
--	=================================================================================

--	select count(*)
--	select count(*)				-- 	75266			w/out Unit filters
--	select count(*)				-- 	71288			w/out CUTON & ACT filters
--	select count(*)				-- 	70718			w/out CUTON filter
--	select count(*)				-- 	57849			all filters

--	=================================================================================

--	create or replace	view	garland.adrResult_User		As

	Select
		l.location_no			rec_key,
		null					rec_rowid,

		ltrim(rtrim(house_no))		addr_num,
		rtrim(street_pfx_dir)		addr_pfx,
		rtrim(street_nm)			addr_name,
		rtrim(street_nm_sfx)		addr_type,
		rtrim(street_sfx_dir)		addr_sfx,

		rtrim(sec_addr_id)		addr_code1,
		rtrim(sec_addr_range)		addr_unit1,
		null					addr_code2,
		null					addr_unit2

	from	sfg.um00250t@umsrep.world		X,	-- crossref
		sfg.um00100m@umsrep.world		L,	-- location
		sfg.um00140t@umsrep.world		S	-- install service

	where	x.location_no = l.location_no
	and	x.location_no = s.location_no
	and	x.service_seq = s.serv_seq

	and	x.effective_dt	in
(
	select max(effective_dt)
	from	sfg.um00250t@umsrep.world
	where	location_no	 = x.location_no
)							

	and	ltrim(l.city)	like 'G%'
	and	s.service_tp	= 'WTR'

	and	l.location_stat	= 'ACT'
--	and	x.service_stat	= 'CUTON'

	and	rtrim		(l.sec_addr_id)		is null
	and	rtrim(ltrim	(l.sec_addr_range))	is null
	;

--	=================================================================================
--	insert into garland.plan_table (object_owner, object_name) values ('GARLAND', '');

	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

--	=================================================================================
	set echo	on;

