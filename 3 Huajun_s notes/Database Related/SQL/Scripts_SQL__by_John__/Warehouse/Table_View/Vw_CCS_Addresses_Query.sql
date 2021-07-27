	set echo		off;
--	===========================================================================

--	drop view				garland.CCS_Addresses_Test;

	create or replace view		garland.CCS_Addresses_Test

	as	select * from garland.CCS_Address;


--	=================================================================================
--	=================================================================================
--	=================================================================================
/*

	select 'EXTRACT1' " " from dual;
	select rpad(addr_num, 06) num,  rpad(addr_pfx,02) pfx, rpad(addr_name,20) name, 
		 rpad(addr_type,04) sfx,  rpad(addr_sfx,02) sfx,
		 rpad(gis_key,  06) gis,  rpad(tax_key, 06) tax, rpad(ums_key,  06) ums
	from garland.Extract1_address_KEYS
	where addr_name =	'CITADEL'
	and	addr_num  =	3701;

	select 'COMMON' " " from dual;
	select * from garland.COMMON_address_Keys
	where addr_name   = 'CITADEL'
	and	addr_num	= 3701;

	select 'MAKE' " " from dual;
	select * from garland.ccs_addresses_MAKE
	where addr_name   = 'CITADEL'
	and	addr_number = 3701;

	select 'TABLE' " " from dual;
	select * from garland.ccs_address
	where addr_name = 	'CITADEL'
	and	addr_number =	3701;

	select 'TEST' " " from dual;
	select * from garland.ccs_addresses_TEST
	where addr_name   = 'CITADEL'
	and	addr_number = 3701;

--	---------------------------------------------------------------------------------

	select address_id, tax_account, min(record_seq), max(record_seq)
	from garland.ccs_addresses_test
	group by address_id, tax_account
	having count(*) > 1;

*/
--	=================================================================================
--	select * from garland.explain_Plan;
--	=================================================================================
