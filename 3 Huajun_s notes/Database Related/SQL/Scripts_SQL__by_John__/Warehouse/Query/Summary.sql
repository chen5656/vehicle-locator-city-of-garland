	set echo	off;
--	================================================================

	select count(*) "CODE"
	from	ccs_addresses;

	select count(distinct address_id) "CODE AID"
	from	ccs_addresses;


	select count(*) 	"GIS ADDR"
	from	garland.cdreladr
	where	addr_num > 0
	and	addr_num not between 9000 and 9999
	and	rtrim(unit_type) is null
	and	rtrim(unit_num)  is null;


	select count(*)	"TAX ADDR"
	from	 garland.GDS_Account;


	select count(*) "INVALID"
	from	 garland.adrResult_TAX_GDS
	where	verify_code < 55;

	select 1901 "VACANT"  from dual;		-- Query_Vacant.sql


	select count(*) "NO TAX"
	from	ccs_addresses
	where tax_id is null;	

	select 2328 "APT STE" from dual;		-- Show_APT_STE.sql


	select count(*) "NO TAX UMS"
	from	ccs_addresses
	where tax_id is null	
	and	ums_id is null;	

	select count(*) "NO UMS"
	from	ccs_addresses
	where ums_id is null;	

--	================================================================
/*

	select rpad(count(count(*)),20) "DISTINCT", rpad(sum(count(*)),20) "DUPLICATE ADDRESS"	-- 3721
	from ccs_addresses	group by address_id	having count(*) > 1;

	select rpad(count(count(*)),20) "DISTINCT", rpad(sum(count(*)),20) "DUPLICATE TAX"  	-- 3719
	from ccs_addresses
	group by address_id	having count(distinct tax_id) > 1;

	select rpad(count(count(*)),20) "DISTINCT", rpad(sum(count(*)),20) "DUPLICATE UMS"  	-- 0
	from ccs_addresses
	group by address_id	having count(distinct ums_id) > 1;

	select rpad(count(count(*)),20) "DISTINCT", rpad(sum(count(*)),20) "DUPLICATE NON TAX"	-- 0
	from ccs_addresses
	where	 rtrim(tax_id) is null
	group by address_id	having count(*) > 1;

	select rpad(count(count(*)),20) "DISTINCT", rpad(sum(count(*)),20) "DUPLICATE NON UMS"  	--  2256
	from ccs_addresses
	where	 rtrim(ums_id) is null
	group by address_id	having count(*) > 1;

*/
--	============================================================================================
	set echo	on;
