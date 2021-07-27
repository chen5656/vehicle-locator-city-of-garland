	set echo	off;
--	=================================================================================
--	what serial address do Water & UMS have in common
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;

--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select count(*)  from
(
	select  w.serial, r.segment_id
	from	temp_view1				W,
		adrResult				R
	where	r.rec_key	= ltrim(w.account,'0')

	intersect

	select  u.serial, r.segment_id
	from	temp_view2				U,
		adrResult_UMS_Location		R
	where	r.rec_key	= u.location
)
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

