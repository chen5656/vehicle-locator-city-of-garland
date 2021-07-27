--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	=====================================================================
--	The following table must be modified when CCS_ADDRESS_MAKE is modified
--		garland.CCS_ADDRESS	
--		garland.CCS_ADDRESS_COPY
--	=====================================================================
--	Mar 2007	rtrim: legal, owner, tenant
--			ums_id = account_no
--	=====================================================================

--	select count(*) from garland.CCS_Address_MAKE;

--	=====================================================================

--	drop view				garland.CCS_Address_MAKE;

	create or replace view		garland.CCS_Address_MAKE		AS

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
		decode(c.is_rental, 1, rental_district, nuisance_district)  	inspector_dist,
		c.Police_Beat,						
		lpad(t.tax_account,10,'0')							tax_account,
		t.tax_dcad,
		t.tax_prop_type,
		t.tax_zoning_code,
		decode (t.tax_exempt, 'AG','Agriculture',  'DV','Disabled Vet', 'SR','> 65', 
			 'HS','Homestead', 'HM','Homestead', 'AS','Total', null)	tax_exemption,
		to_char(sysdate, 'yyyy-mm-dd')	tax_deed_chng_date,		

		rtrim(rtrim(t.tax_owner) ||' '|| t.tax_addr1)				tax_owner,
		t.tax_addr1,
		t.tax_addr2,
		t.tax_city,
		t.tax_state,
		rpad	(t.tax_zip,05)								tax_zip,
		decode(length(tax_zip), 10,	substr(tax_zip,7), null) 		tax_ten_code,
		t.occupied										tax_occupied,			

		rtrim(t.legal_desc)								tax_legal_desc,
		rtrim(u.last_name)	ums_last_name,
		rtrim(u.first_name)	ums_first_name,

		u.drivers_license		ums_drivers_lic,
		u.birth_date		ums_birth_date,
		g.intersection1		intersection1,
		g.intersection2		intersection2,
   		lpad(g.parcel_id,11,'0') parcel_id,
		g.street_id			street_id,
		g.block_id,
		g.road_id			road_id,
		g.intersect_id1,
		g.intersect_id2,
		k.tax_key			tax_id,
		u.account_no		ums_id,
--		k.ums_key			ums_id,
		0				record_seq,
--		s.sequence * 100		record_seq,
	      c.parcel_id			parcel_id_new,
		c.cdbg			cdbg
	from
		garland.Common_Address_Keys	K,
		garland.Common_GIS		G,
		garland.Common_TAX		T,	
		garland.Common_UMS		U	
		,garland.Code_District		C
	where	k.gis_key			= g.address_id	(+)
	and	k.tax_key			= t.tax_account	(+)
	and	k.ums_key			= u.account_no	(+)
--	and	k.ums_key			= u.location_no	(+)
	and	c.parcel_id (+)		= trunc(g.parcel_id + 0)
	;


--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================
--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================
