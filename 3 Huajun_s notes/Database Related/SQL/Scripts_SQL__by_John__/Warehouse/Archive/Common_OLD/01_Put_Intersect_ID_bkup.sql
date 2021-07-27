	set echo	off;
    set linesize	2000;
--	===========================================================================
--	Assign Intersect ID's to each address in Common GIS
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id =  'xxx'	into garland.plan_table	for
--	===========================================================================

	update	JDEACUTIS.Common_GIS		G

	set	  (	intersect_id1, intersect_id2  ) =
(
	select	min(item02), max(item03)
	from		garland.GIS_Objects		T

	where		item01 = rtrim(G.address_id)
);

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

	commit;
	alter rollback segment rb1 offline;
--	===========================================================================
	set echo	on;

