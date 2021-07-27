--	=======================================================================
/*
	select 
		translate(ucbprem_code,'/ ','/')		premise_num,
		rtrim(ucbprem_street_number)			streetnum,
		rtrim(ucbprem_pdir_code_pre)			streetprefix,
		rtrim(ucbprem_street_name)			streetname,
		rtrim(ucbprem_ssfx_code)			streettype,
		rtrim(ucbprem_pdir_code_post)			streetsuffix,
		rtrim(ucbprem_utyp_code)			unit_type,
		rtrim(ucbprem_unit)				unit_num
	from  ucbprem@bprd.world 
	where	translate(ucbprem_code, '/ 1234567890','/') is null
	and rownum < 111;
*/
--	=======================================================================
