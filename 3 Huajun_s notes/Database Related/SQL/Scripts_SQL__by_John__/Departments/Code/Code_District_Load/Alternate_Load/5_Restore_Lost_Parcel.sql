--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================
--	Look at Summary to discover what Parcel IDs are 
--	in the current Code District that are not in new Code District

--	Do you want to retain these lost Parcel IDs ???
--	================================================================

	insert into jdeacutis.Code_District
	select *
	from	garland.Code_District
	where parcel_id in
	(
	select parcel_id from garland.code_district
	minus
	select parcel_id from jdeacutis.code_district    
	);

	ROLLBACK;
