	set echo	off;
	set timing	on;
	set fetchrows	999;
--	================================================================
--	bad number error is really a wrong name error  (in adrResult)
--	================================================================

	truncate table	garland.gis_temp4		reuse storage;

--	truncate table 	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id = 'xxx'   for

--	================================================================

--	select count(*)  from

	insert into	garland.gis_temp4   (item01, item02, item03)
(
	select distinct
		b.addr_name		good_name,
	 	a.addr_num		bad_num, 
		a.addr_name		better_name

	from	garland.cdreladr		a,
		garland.cdreladr		b,
		garland.adrStreets	s,
		garland.adrStreets	t

	where	a.addr_name	 = s.addr_name
	and	b.addr_name	 = t.addr_name

	and	s.addr_name	like rpad(t.addr_name,1) ||'%'
	and 	s.addr_name <> t.addr_name

	and (	s.addr_begin   = t.addr_begin	
	or 	s.addr_compact = t.addr_compact

	or 	s.addr_name like t.addr_name ||'%'		-- DANGEROUS
	or 	t.addr_name like s.addr_name ||'%'
	    )

	and not exists
(
	select 'x'
	from	garland.cdreladr		c
	where	c.addr_name	= t.addr_name
	and	c.addr_num	= a.addr_num
)
);

--	================================================================

--	select * from explain_plan;

	commit;
	alter rollback segment rb1 offline;

--	================================================================
	set echo	on;
	set timing	off;
	set fetchrows;




