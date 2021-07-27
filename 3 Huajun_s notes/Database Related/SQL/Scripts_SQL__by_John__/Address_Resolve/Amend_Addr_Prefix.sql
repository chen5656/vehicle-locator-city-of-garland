	set echo	off;
--	====================================================================
--	Address scrubbing bug:
--	Original appl_pfx is not carried over to addr_pfx
--	when prefix is not contained within addr_name

--	Correction
--	Put appl_prefix into addr_pfx
--	====================================================================

--	adrAlias contains '* in addr_

	update garland.adrResult set addr_type = ' ' where addr_type = '*';
	update garland.adrResult set addr_pfx  = ' ' where addr_pfx  = '*';
	update garland.adrResult set addr_sfx  = ' ' where addr_sfx  = '*';
	commit;

--	====================================================================

/*
	select rpad(appl_pfx,5) pfx, rpad(appl_name,20) name, 
		 rpad(addr_pfx,5) pfx, rpad(addr_name,20) name,
		 rec_key
	from	garland.adrResult		r,
		garland.adrItem		i

	where	i.class = 'D'
	and	i.standard = i.possible

	and	rtrim(r.appl_pfx,'. ')  = i.standard
	and	nvl  (r.addr_pfx, ' ') <> i.standard
	and	r.addr_name not like '%' || i.name || '%'

	order by rpad(addr_name,20);
	
*/

--	====================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id = 'xxx'  into garland.plan_table   for

	update garland.adrResult	r
	set	addr_pfx = 
(
	select i.standard
	from	 garland.adrItem		i
	where	i.class = 'D'
	and	i.standard = i.possible
	and	rtrim(r.appl_pfx,'. ')  = i.standard
	and	nvl  (r.addr_pfx, ' ') <> i.standard
	and	r.addr_name not like '%' || i.name || '%'
)
	where exists
(
	select 'x'
	from	 garland.adrItem		i
	where	i.class = 'D'
	and	i.standard = i.possible
	and	rtrim(r.appl_pfx,'. ')  = i.standard
	and	nvl  (r.addr_pfx, ' ') <> i.standard
	and	r.addr_name not like '%' || i.name || '%'
);

--	select * from garland.explain_plan;

--	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;

--	====================================================================
	set echo	on;
