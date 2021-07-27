	set echo off;
--	===========================================================================

	select count(*) from cdrelpar where zoning is null;	--  70

--	duplicate nontax:  178 - 74 distinct  			-- 100

--	===========================================================================

	truncate table	garland.plan_table	reuse storage;

--	===========================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

--	how many GIS w/ missing tax info are due to addressed apt & ste

	select count(*)	
	from	 ccs_addresses	C

	where	 tax_addr2 is null			-- 2350
--	where	 tax_addr2 is not null			-- 0

	and	 c.address_id	in
(

	select a.mslink	
--	select count(*)					-- 2350

	from	 cdreladr		A,
		 cdrelpar		P,
		 ccs_addresses	C

	where	c.tax_addr2  is null
	and	c.address_id = a.mslink
	and	p.parcel_id	 = a.parcel_id

	and 	zoning not like 'SF%'
	and	zoning not like 'PD%' 
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

--	===========================================================================
	set echo	on;



