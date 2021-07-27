	set echo	off;
    set linesize	2000;
--	===========================================================================
--	Remove duplicate Common GIS due to multiple Road ID's for an address
--	===========================================================================

--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = ' '		into garland.plan_table	for
--	===========================================================================

--	select count(*)

	Delete from	JDEACUTIS.Common_GIS
	where	(address_id, road_id)	in
(
	select g.address_id, g.road_id
	from	JDEACUTIS.Common_GIS	G,
(
	select address_id, max(road_id) road_id
	from	JDEACUTIS.Common_GIS
	group by address_id
	having count(distinct road_id) > 01
)						M
	where	g.address_id = m.address_id
	and	g.road_id	 < m.road_id
);

--	===========================================================================

	select count(*)	from JDEACUTIS.Common_GIS;

--	===========================================================================
--	insert into garland.plan_table(object_owner, object_name)values('GARLAND', '');
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_index;
--	select * from garland.explain_table;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

--	ROLLBACK;
	Commit;

--	===========================================================================
