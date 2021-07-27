	set echo off;
--	======================================================================
--	truncate table	garland.plan_table	reuse storage;

	alter rollback segment	rb1			online;
	commit;
	set transaction use	rollback segment	rb1;

--	explain plan set statement_id =	'attach pid'	into garland.plan_table	for

	update garland.ums_keys	k
	set	parcel_id =
(
	select	--+ index (l)
		 parcel_id
	from	 garland.adrResult_UMS_Location	l
	where	 l.rec_key = rtrim(k.location_no)
);

	commit;
	alter rollback segment	rb1			offline;

--	======================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_remote;

--	select * from garland.explain_analyze;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;

--	select * from garland.explains_analyze;
--	select * from garland.explains_indexed;
--	select * from garland.explains_constraint;
--	select * from garland.explains_table;
--	select * from garland.explains_index;
--	======================================================================
	set echo on;
