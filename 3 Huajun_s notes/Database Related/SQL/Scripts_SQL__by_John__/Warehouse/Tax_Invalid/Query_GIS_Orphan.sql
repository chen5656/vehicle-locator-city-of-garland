	set echo	off;
--	===========================================================================
--	What GIS addresses are not in TAX (excluding vacant, common, & parking)
--	===========================================================================

	truncate table	garland.plan_table	reuse storage;

--	===========================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select count(*)					--  3224  nov 10,2004
	from	garland.cdreladr		A

	where	(addr_name, addr_num)	in
(
	select	addr_name, addr_num
	from		garland.common_gis

	minus

(
	select	r.addr_name, to_number(r.addr_num)
	from		garland.adrResult_TAX_GDS	R

	minus

	select	r.addr_name, to_number(r.addr_num)
	from		garland.adrResult_TAX_GDS	R,
			garland.GDS_Account		A
	where		r.rec_key = rtrim(a.account)
	and		a.acct_use like 'C%'
	and		a.acct_use like 'D%'
)
);

--	===========================================================================
--	insert into garland.plan_table(object_owner, object_name) values('GARLAND', '');

--	select * from garland.explain_plan;

--	execute  explain_more;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_index;
--	select * from garland.explain_table;
--	select * from garland.explain_dependent;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

--	===========================================================================
	set echo	on;
