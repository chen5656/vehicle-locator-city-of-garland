	set echo	off;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;			-- insure transaction
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

--	select count(*)

	select --	use_hash(s)  use_hash(t)

		null " ",
		rpad(b.addr_num, 05) " ", rpad(b.addr_pfx,02) " ", rpad(b.addr_name,20) " ", 
		rpad(b.addr_type,04) " ", rpad(b.addr_sfx,02) " ", 
		x.dcad_acct, s.owner_name,  s.owner_addr2,
		chr(10) " ",

	 	rpad(a.addr_num, 05) " ", rpad(a.addr_pfx,02) " ", rpad(a.addr_name,20) " ", 
		rpad(a.addr_type,04) " ", rpad(a.addr_sfx,02) " ", 
		y.dcad_acct, t.owner_name,  t.owner_addr2,
		chr(10) " "

	from	adrResult_TAX_GDS		A,
		adrResult_TAX_GDS		B,
		GDS_Account			S,
		GDS_Account			T,
		GDS_Crossref		X,
		GDS_Crossref		Y,
(
	select addr_name, addr_num
	from	adrResult_TAX_GDS
	group by addr_name, addr_num
	having count(*) > 1
)						D

	where	a.addr_name	= d.addr_name
	and	a.addr_num	= d.addr_num

	and	b.addr_name	= d.addr_name
	and	b.addr_num	= d.addr_num

	and	a.verify_code = 55
	and	b.verify_code = 53

	and	a.rec_key	= rtrim(s.account)
	and	b.rec_key	= rtrim(t.account)

	and	s.account	= x.gds_acct
	and	t.account	= y.gds_acct
	;

--	===========================================================================
--	insert into garland.plan_table(object_owner, object_name)values('GARLAND', '');

--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

	savepoint	xxx;		-- insure rollback
--	ROLLBACK;
	Commit;

	alter rollback segment rb1 offline;
--	===========================================================================
	set echo	on;



--	desc gds_account
