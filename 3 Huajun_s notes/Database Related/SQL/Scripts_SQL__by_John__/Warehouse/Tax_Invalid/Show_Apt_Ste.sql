	set echo	off;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

--	===========================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select count(*) "APT & STE"			--  2306   nov 10,2004

	from  garland.cdreladr		A,
		garland.cdrelpar		P

	where	a.parcel_id = p.parcel_id

	and	addr_num > 0
	and	addr_num not between 9000 and 9999
	and	rtrim(unit_type) is null
	and	rtrim(unit_num)  is null
	and	p.zoning not like 'SF%'
	and	p.zoning not like 'PD%'

	and not exists
(
	select 'x'
	from	 adrResult_TAX_GDS
	where	 segment_id = rtrim(a.mslink)
);

--	===========================================================================
--	insert into garland.plan_table(object_owner, object_name)values('GARLAND', '');

--	select * from garland.explain_plan;

--	execute  explain_more;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_column;
--	select * from garland.explain_dependent;
--	select * from garland.explain_analyze;

--	===========================================================================
	set echo	on;
