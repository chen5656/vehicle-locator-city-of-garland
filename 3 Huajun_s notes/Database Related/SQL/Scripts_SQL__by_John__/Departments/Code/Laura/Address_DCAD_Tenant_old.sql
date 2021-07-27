	set echo 		off;
	set charwidth	200;
	set termout		off;
--	========================================================================================
--	Prepare spreadsheet that contains GIS Address, DCAD number, and UMS Tenant
--	Source = CCS_ADDRESSES giving GIS or TAX Address
--	If UMS Tenant does not exist, then provide TAX owner
--	========================================================================================

	spool c:\deacutis\extract\CODE_Laura_Adr_DCAD_Occup.txt


	select 'Parcel;Num;Pre;Name;Type;Suf;DCAD;Tenant;GIS;TAX;CUS'	" " from dual
	union all

	select 
		parcel_id	||';'||
		addr_number ||';'|| addr_prefix ||';'|| addr_name ||';'|| addr_type ||';'|| addr_suffix	||';'||
		tax_dcad	||';'||		

		decode(nvl(ums_id,0), 0, tax_owner, ltrim(ums_first_name ||' '|| ums_last_Name))		||';'||

		nvl(address_id,0)			||';'||
		to_number(nvl(tax_id,0))	||';'||
		nvl(ums_id,0)			||';'			

	" "
	from garland.ccs_addresses
	where	tax_id || ums_id > 000000

--	and	rownum < 11
	;

	spool off;

--	========================================================================================
	set echo 	on;
	set charwidth;
	set termout	on;

