--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

select	count(address_id)		address, 
  	count(distinct inspector_dist)	code,		count(inspector_dist)	code, 
  	count(distinct cdbg)		cdbg,		count(cdbg)		cdbg, 
  	count(distinct addr_zip)		zip, 		count(addr_zip)		zip, 
	count(distinct council_dist)	council,		count(council_dist)	council,
	count(distinct police_beat)	beat,		count(police_beat)	beat,
	' '	" "
  from garland.CCS_ADDRESS_TEST;

