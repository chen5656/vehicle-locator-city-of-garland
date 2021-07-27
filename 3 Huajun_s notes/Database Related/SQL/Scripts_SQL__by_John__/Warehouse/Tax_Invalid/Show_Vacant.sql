	set echo	off;
--	=======================================================================================
--	Show all "bad number" tax addresses for 
--	=======================================================================================

	truncate table	garland.plan_table	reuse storage;

--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select count(*)		-- 1842

/*
	select 
		rpad(r.rec_key,  12) " ", rpad(a. acct_use,10) " ", 
		rpad(r.addr_num, 05) " ", rpad(r.addr_pfx, 02) " ",
		rpad(r.addr_name,20) " ", rpad(r.addr_type,04) " ", rpad(r.addr_sfx,02) " "
--		,a.owner_name
*/


--	select a.PIDN	 ||';'|| r.rec_key   ||';'|| r.addr_num ||';'||  r.addr_pfx ||';'||  
--		 r.addr_name ||';'|| r.addr_type ||';'||  r.addr_sfx		" "


	from	garland.adrResult_TAX_GDS	r,
		garland.GDS_Account		a

	where	r.rec_key = a.account

	and (	nvl(acct_use,' ') like 'C%'
	or	nvl(acct_use,' ') like 'D%' ) 

	and r.verify_code < 55
--	and r.verify_code between 20 and 49

--	and	rownum < 111
	;

--	=================================================================================
--	insert into garland.plan_table (object_owner, object_name) values('GARLAND', '');

--	select * from garland.explain_Plan;

--	execute  explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

--	=================================================================================
	set echo	on;

