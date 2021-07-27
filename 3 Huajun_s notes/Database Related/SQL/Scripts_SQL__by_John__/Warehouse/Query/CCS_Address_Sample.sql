--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	1000;
set pagesize	9999;
--	=====================================================================

--	display CCS_ADDRESS for REVENUE RECOVERY DISCUSSION
--	=====================================================================


--	select count(*) from (

	select null,
	'*** Address                       *** '" ", 
		addr_number,addr_prefix,addr_name,addr_type,addr_suffix,chr(13),
	'*** TAX Acct,DCAD,Owner            *** '" ", 
		rpad(tax_account,12), tax_dcad, rpad(tax_owner,20),chr(13), 
	'*** PropType,Zoning,Exemption,Mail *** '" ", 
		tax_prop_type, tax_zoning_code, rpad(tax_exemption,5),rpad(tax_addr2,30),rpad(tax_addr1,20),rpad(tax_city,10),chr(13),
	'*** Legal Description              *** '" ", 
		rpad(tax_legal_desc,80),chr(13),
		rpad(' ',40) || substr(tax_legal_desc,81,50),chr(13),
	'*** CUS Acct,Tenant,Lic,Dob        *** '" ",
		ums_id,rpad(ums_last_name,20),rpad(ums_first_name,20),ums_drivers_lic,ums_birth_date,chr(13),
		' ' " "
	from garland.ccs_address


	where (addr_number,addr_prefix, addr_name, addr_type, addr_suffix) in
(
	select addr_number,addr_prefix, addr_name, addr_type, addr_suffix
	from  garland.Ccs_address
	group by addr_number,addr_prefix, addr_name, addr_type, addr_suffix
	having count(*) > 10
)

--	and	ums_id is not null
--	and	rownum < 11

	and addr_name = 'CHAHA'
	and addr_number = 4440

--	)
;