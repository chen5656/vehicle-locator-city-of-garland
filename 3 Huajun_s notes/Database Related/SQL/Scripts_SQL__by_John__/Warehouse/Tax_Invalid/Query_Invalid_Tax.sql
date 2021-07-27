	set echo	off;
--	===========================================================================
--	How many non_Vacant Tax have invalid addresses
--	Filter according to verify code
--	===========================================================================

	truncate table	garland.plan_table	reuse storage;

--	===========================================================================
--	explain plan set statement_id = 'aaa '		into garland.plan_table	for

--	select count(*)			

	select
		account					"account",
		pidn						"dcad",
		rpad(acct_use,10)				"use",

		lpad(nvl(r.addr_num,0),	05)		"num", 
		rpad(nvl(r.addr_pfx, ' '),02)		"pf", 
		rpad(nvl(r.addr_name,' '),20)		"name",
		rpad(nvl(r.addr_type,' '),04)		"type",	 
		rpad(nvl(r.addr_sfx, ' '),02)		"sf"

		,rpad(nvl(r.addr_code1, ' '),10)	"bldg"
		,rpad(nvl(r.addr_unit1, ' '),10)	"unit"

	from	 garland.adrResult_TAX_GDS	R,
		 garland.GDS_Account		A

	where	 r.rec_key = rtrim(a.account)

	and	 nvl(a.acct_use,' ') not like 'C%'
	and	 nvl(a.acct_use,' ') not like 'D%'

	and	r.addr_num > '0'


	and	verify_code < 55						-- 307  (w/ addr_num)

--	and	 verify_code between 50 and 54 

--	and 	 verify_code < 20				

--	and	verify_code between 20 and 49	


	order by 	r.addr_name, r.addr_type, r.addr_pfx, r.addr_sfx, r.addr_num
	;

--	===========================================================================
--	insert into garland.plan_table(object_owner, object_name) values('GARLAND', '');

--	select * from garland.explain_plan;

--	execute  explain_more;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_column;
--	select * from garland.explain_dependent;
--	select * from garland.explain_analyze;

--	===========================================================================
	set echo	on;
