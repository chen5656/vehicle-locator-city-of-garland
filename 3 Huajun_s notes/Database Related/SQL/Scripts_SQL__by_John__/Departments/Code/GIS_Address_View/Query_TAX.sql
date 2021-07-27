	set echo		off;
	set fetchrows	111;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = 'xxx'		into garland.plan_table	for
--	===========================================================================

	select
		rtrim (t.macctno)			account,
		rtrim (t.geoacct)			geoacct,

		substr(t.propaddr,21,06)	addr_num,
		substr(t.propaddr,19,02)	addr_pfx,
		rpad  (t.propaddr,18)		addr_name,
		substr(t.propaddr,27,04)	addr_type,
		rtrim (t.street)			addr_unit,

		t.mprptyp				prop_type,
		t.ownrchngdt			owner_chng_date,
				
		n.tax_payer,
		n.addr1,
		n.addr2,
		n.city,
		n.state,

		t.anumber || decode(t.sfx, '    ', null, '-') || t.sfx	zip_code

	from	garland.TAX			t,
		garland.TAX_NAME		n

	where	rtrim(t.owner) = n.acct_owner
	;


--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_analyze;
--	===========================================================================
	set echo	on;
	set fetchrows;
