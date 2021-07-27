--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	800;
set pagesize	9999;
--	=====================================================================

	Select 
		ucbprem_code			rec_key, 
		0					rec_seq, 
		ucbprem_street_number		addr_num,
		ucbprem_pdir_code_pre		addr_pfx,
		ucbprem_street_name		addr_name,
		ucbprem_ssfx_code			addr_type,
		ucbprem_pdir_code_post		addr_sfx,
		ucbprem_utyp_code			addr_code1,
		ucbprem_unit			addr_unit1,
		null					addr_code2, 
		null					addr_unit2
	from	ucbprem@banbprd

	where	ucbprem_street_name not like 'FLOATING%' 
	and	ucbprem_street_name not like 'FIRE HYDRANT%' 
	and	translate (ucbprem_street_number, '/1234567890 ', '/') is null

	and rownum < 11;