	set echo	off;
--	=======================================================
--	Show GIS addressed Units that are missing from TAX  
--	Show GIS addressed Units that are present in   TAX  

--	Excluding SF & PD
--	=======================================================

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

--	===========================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select count(*) 
	from

--	select 
--		lpad(addr_num, 5) " ", rpad(addr_pfx,2) " ", rpad(addr_name,20) " ", 
--		rpad(addr_type,4) " ", rpad(addr_sfx,2) " "
--	from

(
	select
	addr_name, addr_type, addr_pfx, addr_sfx, addr_num

	from	garland.cdreladr		a,
		garland.cdrelpar		p

	where	a.parcel_id = p.parcel_id (+)
	and	p.zoning > '0'

	and	addr_num > 0
	and	addr_num not between 9000 and 9999
	and	rtrim(unit_type) is null
	and	rtrim(unit_num)  is null

	and 	nvl(p.zoning,' ')	not like 'SF%'
	and	nvl(p.zoning,' ')	not like 'PD%'


	MINUS			--  missing from TAX			-- 2285  nov 10,2004
--	INTERSECT		--  exist in TAX				-- 3512  nov 10,2004


	select
	addr_name, addr_type, addr_pfx, addr_sfx, to_number(addr_num)
	from adrResult_TAX_GDS
)

	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_num;

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
