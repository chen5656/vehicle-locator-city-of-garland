	set echo	off;
--	=================================================================================
--	what serial address do Water & UMS have in common
--	=================================================================================

	truncate table	garland.plan_table	reuse storage;
--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select count(distinct serial)  "Serial#"	
	from
(
	select serial

	from	adrResult		R,
		temp_view1		V

	where	 ltrim(v.account,'0')	= r.rec_key

	and	(serial, form_name, addr_num)		in
(
	select  w.serial, r.form_name, r.addr_num
	from	temp_view1				W,
		adrResult				R
	where	r.rec_key	= ltrim(w.account,'0')

	intersect

	select  u.serial, r.form_name, r.addr_num
	from	temp_view2				U,
		adrResult_UMS_Location		R
	where	r.rec_key	= u.location
)


	UNION

(
	select  v.serial

	from	adrResult			W,
		adrResult_UMS_Location	U,
		temp_view1			V

	where	ltrim(v.account,'0')	= w.rec_key
	and	u.segment_id		= w.segment_id
)	


);


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

	select count(distinct(serial)) "Serial#"	from temp_view1;

--	=================================================================================
	set echo	on;


