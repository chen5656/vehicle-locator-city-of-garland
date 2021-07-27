	set echo	off;
--	===========================================================================
--	Many GIS addresses do not appear in TAX
--	Many are due to addressed apt & ste
--	Many however are Single Family and Planned Development
--	Below is a query of SF & PD addresses that are not on TAX

--	For SF & PD only
--	===========================================================================

--	PREPARATION		Copy to adrResult_TAX_GDS	into adrResult_Extract;

--	===========================================================================

	truncate table	garland.plan_table	reuse storage;

--	===========================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for
--

--	select count(*)			--  1073  nov 10,2004

--	select landuse, rpad(zoning,2) " ", count(*) "TOTAL"


	select 
		a.addr_num num, a.addr_pfx pf, a.addr_name name, a.addr_type type, a.addr_sfx sf, 
		p.zoning,   rpad(p.landuse,25) landuse  
--		,a.mslink


	from	garland.cdreladr		A,
		garland.cdrelpar		P


	where	a.parcel_id = p.parcel_id (+)

	and (	p.zoning like 'SF%'
	or	p.zoning like 'PD%' )

	and	a.addr_num > 0
	and	a.addr_num not between 9000 and 9999
	and	rtrim(a.unit_type) is null
	and	rtrim(a.unit_num)  is null

	and not exists
(
	select 'x'
	from	 adrResult_Extract	E
--		,ADRRESULT_TAX_GDS	G

	where	segment_id = rtrim(a.mslink)
)


--	GROUP BY	LANDUSE, RPAD(ZONING,2)


	order by
--			p.landuse,   p.zoning,
			a.addr_name, a.addr_type, a.addr_pfx, a.addr_sfx, a.addr_num
	;

--	===========================================================================

	select comments  from user_tab_comments  where table_name = 'ADRRESULT_EXTRACT';

--	===========================================================================
--	insert into garland.plan_table(object_owner, object_name)values('GARLAND', '');
--	insert into garland.plan_table(object_owner, object_name)values('GARLAND', 'GDS_ACCOUNT');
--	insert into garland.plan_table(object_owner, object_name)values('GARLAND', 'ADRRESULT_TAX_GDS');

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

