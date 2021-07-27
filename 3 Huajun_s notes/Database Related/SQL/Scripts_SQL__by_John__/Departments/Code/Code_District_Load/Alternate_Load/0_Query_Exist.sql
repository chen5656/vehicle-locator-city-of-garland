--	================================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================================
--	IS RENTAL

	select count(*) source_swt from garland.rental_properties where active = 'Y';
	select count(*) target_swt from garland.code_district where is_rental > 0;
    
	select count(*) possible from
	(
	select parcel_id from garland.rental_properties where active = 'Y'
	intersect
	select parcel_id from garland.code_district
	);
    
--	================================================================================
    