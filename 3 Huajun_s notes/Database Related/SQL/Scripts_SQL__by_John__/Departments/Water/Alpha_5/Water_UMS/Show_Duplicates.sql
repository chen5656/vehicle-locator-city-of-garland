	set echo	off;
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;

--	=================================================================================
--	Serial numbers that have duplicate addresses according to Water
--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select --	distinct

		rpad(item01,10) 		serial,
		rpad(item02,10) 		account,

		lpad(nvl(addr_num,   0),05)		"num", 
		rpad(nvl(addr_pfx, ' '),02)		"pf", 
		rpad(nvl(addr_name,' '),20)		"name",
		rpad(nvl(addr_type,' '),04)		"type",	 
		rpad(nvl(addr_sfx, ' '),02)		"sf"

	from	garland.gis_temp2		T,
		garland.adrResult		R

	where	r.rec_key = ltrim(t.item02,'0')
	and	item01 	in
(
	select item01
	from	gis_temp2
	group by item01
	having count(distinct item02) > 1
)
	order by 1,2;


--	=================================================================================
--	Serial numbers that have duplicate addresses according to UMS
--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select 
		rpad(serial,  10) 		serial,
		rpad(location,10) 		account,

		lpad(nvl(r.addr_num,   0),05)		"num", 
		rpad(nvl(r.addr_pfx, ' '),02)		"pf", 
		rpad(nvl(r.addr_name,' '),20)		"name",
		rpad(nvl(r.addr_type,' '),04)		"type",	 
		rpad(nvl(r.addr_sfx, ' '),02)		"sf"

	from	garland.temp_view1			T,	--  UMS crossref
		garland.adrResult_UMS_Location	R	--  UMS address

	where	r.rec_key = ltrim(t.location,'0')
	and	serial	in
(
	select serial
	from	temp_view1
	group by serial
	having count(distinct location) > 1
)
	order by 1,2;

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
