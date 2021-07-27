	set echo off;
    set linesize	2000;
--	===============================================================

	create or replace view	garland.show_ccs_addresses	AS

	select 
		null					x1,
		'Keys      '			x2,
		rpad(address_id,	10)		address_id,	
		rpad(tax_account,	10)		tax_account,
		rpad(ums_id,	10)		ums_key,	
		rpad(record_seq,	10)		record_seq,	
		rpad(parcel_id,	12)		parcel_id,	
		rpad(tax_dcad,	20)		tax_dcad,	
		chr(10)				x3,
		'GIS       '			x4,
		rpad(addr_number,	10)		addr_number,	
		rpad(addr_prefix,	10)		addr_prefix,	
		rpad(addr_name,	20)		addr_name,	
		rpad(addr_type,	10)		addr_type,	
		rpad(addr_suffix,	10)		addr_suffix,	
		'district='				x5,
		rpad(inspector_dist,01)		code_district,	
		chr(10)				x6,
		'TAX       '			x7,
		rpad(tax_owner,	42)		tax_owner,	
		rpad(tax_addr1,	21)		tax_addr1,	
		rpad(tax_addr2,	20)		tax_addr2,	
		rpad(tax_city,	10)		tax_city,	
		chr(10)				x8,
		'UMS       '			x9,
		rpad(ums_last_name, 20)		ums_last_name,	
		rpad(ums_first_name,10)		ums_first_name,	
		chr(10)				x11
	from garland.ccs_addresses;

--	===============================================================

