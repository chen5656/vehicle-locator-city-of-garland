--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	========================================================================================
--	Prepare spreadsheet that contains GIS Address, DCAD number, and UMS Tenant
--	Source = CCS_ADDRESSES giving GIS or TAX Address
--	If UMS Tenant does not exist, then provide TAX owner
--	========================================================================================

	spool c:\deacutis\extract\CODE_Laura_DCAD_Occup.txt

	select 'Parcel;Num;Pre;Name;Type;Suf;DCAD;Tenant;GIS;TAX;CUS'	" " from dual
	union all

	select 
		parcel_id	||';'||
		addr_number ||';'|| addr_prefix ||';'|| addr_name ||';'|| addr_type ||';'|| addr_suffix	||';'||
--		addr_zip	||';'||
		tax_dcad	||';'||		
		tenant	||';'||
		nvl(address_id,0)			||';'||
		to_number(nvl(tax_id,0))	||';'||
		nvl(ums_id,0)			||';'			

	" "
	from
(
	select 
		min(parcel_id) parcel_id,
		addr_number, addr_prefix, addr_name, addr_type, addr_suffix,
		min(tax_dcad) tax_dcad,
		min(decode(nvl(ums_id,0), 0, tax_owner, ltrim(ums_first_name ||' '|| ums_last_Name))) tenant,
		min(nvl(address_id,0)) address_id,
		min(to_number(nvl(tax_id,0))) tax_id,
		min(nvl(ums_id,0)) ums_id			
	from garland.ccs_addresses
	where	tax_id || ums_id > 000000
	group by addr_number, addr_prefix, addr_name, addr_type, addr_suffix
 );


--	decode(nvl(ums_id,0), 0, tax_owner, ltrim(ums_first_name ||' '|| ums_last_Name))		||';'||
--	from garland.ccs_addresses
--	where	tax_id || ums_id > 000000

	spool off;

--	========================================================================================

