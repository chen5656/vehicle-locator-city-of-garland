	set echo	off;
    set linesize	2000;
--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id =  'xxx'	into garland.plan_table	for
--	===========================================================================

	update  JDEACUTIS.Common_GIS		G
	set	( intersecton1, intersecton2 ) = 		--  SPELLING ERROR
(
	select  
		ltrim(rtrim(x.addr2_pfx ||' '|| x.addr2_name ||' '|| x.addr2_type ||' '|| x.addr2_sfx)),
		ltrim(rtrim(y.addr2_pfx ||' '|| y.addr2_name ||' '|| y.addr2_type ||' '|| y.addr2_sfx))
	from	garland.intersection	X,
		garland.intersection	Y
	where	g.intersect_id1	= x.intersect_id
	and	g.intersect_id2	= y.intersect_id
);

	Commit;

--	===========================================================================
--	select * from garland.explain_Plan;
--	insert into   garland.plan_table (object_owner, object_name) values ('GARLAND', 'INTERSECTION');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	===========================================================================
