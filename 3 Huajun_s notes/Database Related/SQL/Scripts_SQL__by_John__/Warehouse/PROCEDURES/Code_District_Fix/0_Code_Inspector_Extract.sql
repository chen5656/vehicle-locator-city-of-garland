--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- alter session	set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	=====================================================================

	create table garland.code_inspector_extract 
	tablespace gis_data 
	AS
(
	select	rental_district		inspector_district, 
			rental_inspector		inspector_name, 
			rental_phone		inspector_phone
	from garland.code_district 
	where rental_phone is not null
	
	union
	
	select	nuisance_district, 
			nuisance_inspector, 
			nuisance_phone 
	from garland.code_district
);
