	set echo		off;
	set fetchrows	111;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = 'xxx'	into garland.plan_table	for
--	===========================================================================

	drop view	garland.CCS_Addresses;

	create or replace view	garland.CCS_Addresses		as

	select	--+ first_rows

		g.address_id,

		trunc(a.addr_num, -2)	str_block,

		a.addr_num			str_number,
		a.addr_pfx			str_prefix,
		a.addr_name			str_name,
		a.addr_type			str_type,
		a.addr_sfx			str_suffix,

		p.Council_ID		council_dist,
		p.Code_Inspect_Area	inspector_dist,

		t.tax_account,
		t.tax_dcad,
		t.tax_prop_type,
		t.tax_zoning_code,
		t.tax_exempt		tax_exemption,
		t.tax_deed_chng_date,
		t.tax_owner,
		t.tax_addr1,
		t.tax_addr2,
		t.tax_city,
		t.tax_state,
		t.tax_zip,

		u.last_name			ums_last_name,
		u.first_name		ums_first_name,
		u.drivers_license		ums_drivers_lic,
		u.birth_date		ums_birth_date,

		ltrim(rtrim(x.addr2_pfx ||' '|| addr2_name ||' '|| addr2_type ||' '|| addr2_sfx))	intersection1,

		g.parcel_id,
		g.block_id,
		g.street_id,
		g.intersect_id1

	from
		garland.Common_GIS	g,
		garland.cdrelADR		a,
		garland.cdrelPAR		p,
		garland.Common_TAX	t,
		garland.Common_UMS	u,
		garland.Intersection	x


	where	g.address_id	= a.addr_id

	and	p.parcel_id		= a.parcel_id

	and	g.address_id	= t.tax_address_id	--  ADDRESS ID = MSLINK	(temporary)	
	and	g.address_id	= u.address_id		--  ADDRESS ID = MSLINK	(temporary)

	and	g.Intersect_id1	= x.intersect_id
		
	and	t.tax_address_id	= u.address_id



--	and	g.address_id = 1234
	;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	===========================================================================
	set echo	on;
	set fetchrows;


