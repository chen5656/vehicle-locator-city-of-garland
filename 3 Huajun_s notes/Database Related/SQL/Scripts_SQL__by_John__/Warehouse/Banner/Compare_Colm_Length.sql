--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	800;
set pagesize	9999;
--	=====================================================================

	select 
		'Result' " ",
		max(length(addr_name)) nam,
		max(length(addr_type)) typ,
		max(length(addr_pfx))  pfx
	from	garland.adrResult_UMS_Location;

	select 
		'UCBPrem' " ",
		max(length(ucbprem_street_name))	nam,
		max(length(ucbprem_ssfx_code))	typ,
		max(length(ucbprem_pdir_code_pre))	pfx
	from	ucbprem@banbprd;


--	=====================================================================

	select 
		'Person' " ",
		max(length(person_lnm))			last,
		max(length(person_fnm))			first,
		max(length(i_drivers_lic_no))		drivlic
	from	sfg.sg00100m@umsrep.world;

	select
		'UCBCust' " ",
		max(length(ucbcust_last_name))			last,
		max(length(ucbcust_first_name))			first,
		max(length(ucbcust_drivers_license))		drivlic
	from	ucbcust@banbprd;

--	=====================================================================

	select distinct(ucbprem_street_name)  
	from ucbprem@banbprd  
	where length(ucbprem_street_name) > 20;

--	=====================================================================
