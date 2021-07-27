--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================

	truncate table jdeacutis.code_district   reuse storage;

	insert into jdeacutis.code_district 
	(
		PARCEL_ID_OLD,
		PARCEL_ID,
		NUISANCE_DISTRICT,
		NUISANCE_INSPECTOR,
		RENTAL_DISTRICT,
		RENTAL_INSPECTOR
	)
   	select
		PARCEL_ID,			
		PARCEL_ID_NEW,
		NUISANCE_DIST,
		NUISANCE_INSP,
		RENTAL_DIST,		
		RENTAL_INSP		
	from	jdeacutis.code_district_external
	order by parcel_id;
