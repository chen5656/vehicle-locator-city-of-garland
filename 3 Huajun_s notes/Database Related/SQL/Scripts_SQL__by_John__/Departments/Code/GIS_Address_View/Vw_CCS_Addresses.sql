	set echo		off;
	set fetchrows	111;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = 'xxx'	into garland.plan_table	for
--	===========================================================================

	drop view			garland.CCS_Addresses;

	create or replace view	garland.CCS_Addresses		as

	select	--+ first_rows

		g.address_id,

		trunc(a.addr_num, -2)	addr_block,

		a.addr_num			addr_number,
		a.addr_pfx			addr_prefix,
		a.addr_name			addr_name,
		a.addr_type			addr_type,
		a.addr_sfx			addr_suffix,

		decode (instr(rtrim(street),'  '), 
				0, null,
				1,null,
				rtrim(rpad(street,3))	)					ADDR_BLDG,

		decode (instr(rtrim(street),'  '), 
				0, rtrim(street), 
				1, ltrim(street),  
				ltrim(substr(street, instr(rtrim(street),'  '))))	ADDR_UNIT,

		p.Council_ID		council_dist,
		p.Code_Inspect_Area	inspector_dist,

		t.tax_account,
		t.tax_dcad,
		t.tax_prop_type,
		t.tax_zoning_code,
		t.tax_exempt					tax_exemption,

		to_char(t.tax_deed_chng_date,'yyyymmdd')	tax_deed_chng_date,
		'1'							tax_occupied,		-- TEMP

		t.tax_owner,
		t.tax_addr1,
		t.tax_addr2,
		t.tax_city,
		t.tax_state,

--		t.tax_zip,
		rtrim(tt.anumber)					tax_zip,			-- TEMP
		rtrim(tt.sfx)					tax_ten_code,		-- TEMP

		rtrim(tt.desc1) ||' '||  rtrim(tt.desc2) ||' '||  rtrim(tt.desc3) ||' '||  rtrim(tt.desc4) ||' '||  
		rtrim(tt.desc5) ||' '||  rtrim(tt.desc6) ||' '||  rtrim(tt.desc7)		 	tax_legal_desc,

		u.location_no				ums_id,
		u.last_name					ums_last_name,
		u.first_name				ums_first_name,
		u.drivers_license				ums_drivers_lic,
		to_char(u.birth_date,'yyyymmdd')	ums_birth_date,

		ltrim(rtrim(x.addr2_pfx ||' '|| addr2_name ||' '|| addr2_type ||' '|| addr2_sfx))	intersect1,
		null														intersect2,	

		g.parcel_id,
		g.block_id,
		g.street_id,
		g.intersect_id1		intersect1_id,
		null				intersect2_id			-- TEMP

	from
		garland.Common_GIS	g,
		garland.cdrelADR		a,
		garland.cdrelPAR		p,
		garland.Common_TAX	t,
		garland.Common_UMS	u,
		garland.Intersection	x

		,garland.TAX		tt	


	where	g.address_id	= a.addr_id

	and	p.parcel_id		= a.parcel_id

	and	g.address_id	= t.tax_address_id	--  ADDRESS ID = MSLINK	(temporary)	
	and	g.address_id	= u.address_id		--  ADDRESS ID = MSLINK	(temporary)

	and	g.Intersect_id1	= x.intersect_id
		
	and	t.tax_address_id	= u.address_id

	and	tt.macctno		= lpad(t.tax_account,25)		-- TEMP
	;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	===========================================================================
	set echo	on;
	set fetchrows;




