	set echo off;
    set linesize	2000;
--	===================================================================

	select lpad(nvl(address_id, 999999),6,'0')		|| 
		 lpad(nvl(ltrim(tax_id,'0'),999999),6,'0')	|| 
		 lpad(nvl(ums_id,999999),6,'0')			" ",

		 count(*)							" "

	from	garland.ccs_addresses_test

	group by 	lpad(nvl(address_id, 999999),6,'0') 	|| 
			lpad(nvl(ltrim(tax_id,'0'),999999),6,'0')	|| 
			lpad(nvl(ums_id,999999),6,'0')

	having count(*) > 1
	;

--	===================================================================
	set echo on;
