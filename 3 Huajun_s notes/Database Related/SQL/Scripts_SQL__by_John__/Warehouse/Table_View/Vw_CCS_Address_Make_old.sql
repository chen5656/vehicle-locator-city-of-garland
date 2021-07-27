	set echo		off;
	set linesize	2000;
	set pagesize	999;
	set sqlblanklines	on;
--	===========================================================================
--	sept 12 2006
--		parcel id processing correction
--	===========================================================================

--	drop view				garland.CCS_Addresses_MAKE;

	create or replace view		garland.CCS_Addresses_MAKE			AS
	select distinct
		g.address_id,
		trunc(k.addr_num, -2)	addr_block,
		k.addr_num			addr_number,
		k.addr_pfx			addr_prefix,
		k.addr_name			addr_name,
		k.addr_type			addr_type,
		k.addr_sfx			addr_suffix,
		g.addr_bldg			addr_bldg,
		g.addr_unit			addr_unit,
		decode ( rpad(tax_dcad,02), '25', 'COLLIN COUNTY', '88', 'ROCKWALL', 'GARLAND')			addr_city,
		rpad	(nvl(tax_addr_zip, c.zip_code), 05)										addr_zip,
		decode(length(nvl(tax_addr_zip,c.zip_code)), 10,substr(nvl(tax_addr_zip,c.zip_code),7), null) 	addr_ten_code,
		c.Council_ID		council_dist,
		decode(c.is_rental, 1, rental_district, nuisance_district)  inspector_dist,
		c.Police_Beat,						
		lpad(t.tax_account,10,'0')	tax_account,
		t.tax_dcad,
		t.tax_prop_type,
		t.tax_zoning_code,
		decode (t.tax_exempt, 	'AG', 'Agriculture', 'DV', 'Disabled Vet', 'SR', '> 65', 
						'HS', 'Homestead',   'AS', 'Total',	null)	tax_exemption,
		to_char(sysdate, 'yyyy-mm-dd')	tax_deed_chng_date,		
		t.tax_owner ||' '|| t.tax_addr1	tax_owner,
		t.tax_addr1,
		t.tax_addr2,
		t.tax_city,
		t.tax_state,
		rpad	(t.tax_zip,05)								tax_zip,
		decode(length(tax_zip), 10,	substr(tax_zip,7), null) 		tax_ten_code,
		t.occupied										tax_occupied,			
		t.legal_desc									tax_legal_desc,
		u.last_name			ums_last_name,
		u.first_name		ums_first_name,
		u.drivers_license		ums_drivers_lic,
		u.birth_date		ums_birth_date,
		g.intersecton1		intersection1,
		g.intersecton2		intersection2,
   		lpad(g.parcel_id,11,'0') parcel_id,
		null				street_id,
		g.block_id,
		g.road_id,
		g.intersect_id1,
		g.intersect_id2,
		k.tax_key			tax_id,
		k.ums_key			ums_id,
		s.sequence * 100		record_seq,
	      c.parcel_id			parcel_id_new
	from
		garland.Common_Address_Keys	K,
		garland.Common_Record_Seq	S,
		garland.Common_GIS		G,
		garland.Common_TAX		T,	
		garland.Common_UMS		U,	
		garland.Code_District		C
	where	k.gis_key			= g.address_id	(+)
	and	k.tax_key			= t.tax_account	(+)
	and	k.ums_key			= u.location_no	(+)
	and	g.parcel_id			= c.parcel_id	(+) || '.000'
	and	s.gis_key			= nvl(k.gis_key,0)
	and	s.tax_key			= nvl(k.tax_key,0)
	and	s.ums_key			= nvl(k.ums_key,0)
--	and	g.parcel_id			= lpad(c.parcel_id  (+),7,'0') || '.000'
	;

--	=================================================================================

