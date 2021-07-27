	set echo	off;
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;

--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for


	select	t.account,
			t.pidn	dcad,

			lpad(nvl(r.addr_num,0),	  05)		"num", 
			rpad(nvl(r.addr_pfx, ' '),02)		"pf", 
			rpad(r.addr_name,	   	  20)		"name",
			rpad(nvl(r.addr_type,' '),04)		"type",	 
			rpad(nvl(r.addr_sfx, ' '),02)		"sf"

--			,rpad(nvl(r.addr_code1, ' '),10)	"bldg"
--			,rpad(nvl(r.addr_unit1, ' '),10) 	"unit"


	from		adrResult_TAX_GDS		R,
			GDS_Account			T
	

	where		r.rec_key	= t.account

	and		t.acct_use	not like 'C%'
	and		t.acct_use	not like 'D%'

	and		verify_code between 10 and 19
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

