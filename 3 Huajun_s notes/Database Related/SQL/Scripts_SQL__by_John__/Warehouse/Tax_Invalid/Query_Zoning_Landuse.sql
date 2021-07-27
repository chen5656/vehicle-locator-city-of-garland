	set echo	off;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;		
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select distinct p.zoning, p.landuse

	from	garland.cdrelpar		p,
		garland.cdreladr		a

	where	p.parcel_id = a.parcel_id

	and (	p.zoning like 'SF%'
	or	p.zoning like 'PD%' )

	and not exists
(
	select 'x'
	from	garland.adrResult_Extract
	where	segment_id = rtrim(a.mslink)
);

--	===========================================================================
--	insert into garland.plan_table(object_owner, object_name)values('GARLAND', '');

--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_index;
--	select * from garland.explain_table;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

	savepoint	xxx;	
--	ROLLBACK;
	Commit;
	alter rollback segment rb1 offline;

--	===========================================================================
	set echo	on;

