	set echo off;
    set linesize	2000;
--	============================================================================================

--	Summary Totals of CCS_Addresses

--	============================================================================================

	select rpad(count(*),20) "TOTAL CCS"	from ccs_addresses;
	select rpad(count(*),20) "ADR TOTAL"	from garland.CDRELADR where rtrim(unit_num) is null;

	select rpad(count(*),20) "GDS" 
	from  garland.GDS_account;

	select rpad(count(*),20) "GDS DEV" 
	from  garland.GDS_Account 
	where acct_use not like 'C%'
	and	acct_use not like 'D%';

	select rpad(count(*),20) "GIS TOTAL"	from garland.Common_GIS;
	select rpad(count(*),20) "TAX TOTAL"	from garland.Common_TAX;
	select rpad(count(*),20) "UMS TOTAL"	from jdeacutis.Common_UMS;

	select rpad(count(distinct tax_address_id),20) "TAX AID"	from garland.Common_TAX;

--	------------------------------------------------------------------------------------------------------
--	Bad Name or Bad Address / Excluding Vacant

--	select rpad(count(*),20) "BAD NAME/ADDR" 		-- 214

	select count(*)

	from  garland.adrResult_TAX_GDS	R,
		garland.GDS_Account		A

	where	r.rec_key	= rtrim(a.account)

	and (	verify_code < 20
	or	verify_code between 50 and 54 )

	and	nvl(a.acct_use,' ') not like 'C%'
	and	nvl(a.acct_use,' ') not like 'D%'
	;

--	------------------------------------------------------------------------------------------------------
--	Bad Number / Excluding Vacant			

--	select rpad(count(*),20) "BAD NUMBER"		-- 399

	select count(*)

	from	garland.adrResult_TAX_GDS		R,
		garland.GDS_Account			A

	where	r.rec_key = rtrim(a.account)
	and r.verify_code between 20 and 49

	and 	nvl(acct_use,' ') not like 'C%'
	and	nvl(acct_use,' ') not like 'D%' 
	;

--	------------------------------------------------------------------------------------------------------
--	GIS Addresses not in TAX	3680
--	Invalid TAX addresses		 610
--	GIS Addressed Apt & Ste		233 0		(Query Develop)

--	CDRELADR				67000
--	Tax AID				63300


	select count(*)
	from	garland.cdrelADR		A
	where rtrim(unit_num) is null

	and	not exists
(
	select 'x'
	from	garland.adrResult_TAX_GDS
	where	segment_id = rtrim(a.mslink)
);

--	------------------------------------------------------------------------------------------------------

 	select rpad(count(*),20) "NO TAX ACCOUNT"	 from ccs_addresses	where rtrim(tax_id)	is null;

	select rpad(count(*),20) "NO UMS ACCOUNT"  from ccs_addresses	where rtrim(ums_id)	is null;

	select rpad(count(*),20) "NO TAX OR UMS"	 from ccs_addresses	where rtrim(tax_id)	is null
												and	rtrim(ums_id)	is null;
--	------------------------------------------------------------------------------------------------------

	select rpad(count(count(*)),20) "DISTINCT", rpad(sum(count(*)),20) "DUPLICATE ADDRESS"
	from ccs_addresses	group by address_id	having count(*) > 1;

	select rpad(count(count(*)),20) "DISTINCT", rpad(sum(count(*)),20) "DUPLICATE TAX"  
	from ccs_addresses
	group by address_id	having count(distinct tax_id) > 1;

	select rpad(count(count(*)),20) "DISTINCT", rpad(sum(count(*)),20) "DUPLICATE UMS"  
	from ccs_addresses
	group by address_id	having count(distinct ums_id) > 1;

	select rpad(count(count(*)),20) "DISTINCT", rpad(sum(count(*)),20) "DUPLICATE NON TAX"  
	from ccs_addresses
	where	 rtrim(tax_id) is null
	group by address_id	having count(*) > 1;

	select rpad(count(count(*)),20) "DISTINCT", rpad(sum(count(*)),20) "DUPLICATE NON UMS"  
	from ccs_addresses
	where	 rtrim(ums_id) is null
	group by address_id	having count(*) > 1;

--	============================================================================================
/*	QUALITY CONTROL CHECKS

	select rpad(count(*),20) "NO TAX ACCOUNT"	 from ccs_addresses	
	where rtrim(tax_id)	is not null
	and	rtrim(tax_addr2)  is null

	Select rpad(count(*),20) "NO UMS ACCOUNT"  from ccs_addresses	
	where rtrim(ums_id)	is null
	and	rtrim(ums_last_name) is not null;

*/
--	============================================================================================
	set echo on;
