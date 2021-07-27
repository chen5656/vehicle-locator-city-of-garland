	set echo	off;
--	=================================================================================
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;		
	set transaction use rollback segment rb1;

--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select count(*)

	from	garland.adrResult		R,
		garland.temp_view1	W

	where	r.rec_key	= ltrim(w.account,'0')
	and	w.location > '0'
--	and	r.verify_code < 55
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

	savepoint	xxx;	
--	Rollback;
	Commit;
	alter rollback segment rb1 offline;

--	Comment on table	garland.	is '' ;

--	=================================================================================
	set echo	on;

