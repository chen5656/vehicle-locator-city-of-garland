	set echo	off;
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = ' '		into garland.plan_table	for
--	=================================================================================

--	select count(*)

	select	rpad(g.item01,10)			"account",

			rpad(g.item02,30)			"original", 

			w.verify_code,

--		lpad(nvl(w.addr_num,   0),05)		"num", 
--		rpad(nvl(w.addr_pfx, ' '),02)		"pf", 
--		rpad(nvl(w.addr_name,' '),20)		"name",
--		rpad(nvl(w.addr_type,' '),04)		"type",	 
--		rpad(nvl(w.addr_sfx, ' '),02)		"sf"

		lpad(nvl(a.addr_num,   0),05)		"num", 
		rpad(nvl(a.addr_pfx, ' '),02)		"pf", 
		rpad(nvl(a.addr_name,' '),20)		"name",
		rpad(nvl(a.addr_type,' '),04)		"type",	 
		rpad(nvl(a.addr_sfx, ' '),02)		"sf"



	from	gis_objects			G,
		adrREsult			W,
		cdreladr			A

	where	trunc(to_number(g.item03))	= trunc(a.x_coord)

	and	trunc(to_number(g.item04))	= trunc(a.y_coord)

	and	g.item01				= w.rec_key

	and	w.verify_code < 55

	;

--	=================================================================================
--	insert into garland.plan_table (object_owner, object_name) values ('GARLAND', '');

--	select * from garland.explain_Plan;
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



