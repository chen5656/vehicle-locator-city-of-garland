--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================

	select count(*) total from garland.code_district;

	select count(*) total from jdeacutis.code_district;

--   ====================================================================
	
	select 'rental' " ", is_rental, count(*) counter
	from   garland.code_district
	group by is_rental; 
	
	select 'rental' " ", is_rental, count(*) counter
	from   jdeacutis.code_district 
	group by is_rental; 
	
--   ====================================================================
	
	select 'nuisance' " ", nuisance_district, count(*) counter
	from   garland.code_district
	group by nuisance_district; 
	
	select 'nuisance' " ",  nuisance_district, count(*) counter
	from   jdeacutis.code_district 
	group by nuisance_district; 

--   ====================================================================
	
	select 'rental' " ", rental_district, count(*) counter
	from   garland.code_district
	group by rental_district; 
	
	select 'rental' " ",  rental_district, count(*) counter
	from   jdeacutis.code_district 
	group by rental_district; 

--   ====================================================================

	select distinct nuisance_district, nuisance_inspector, nuisance_phone from garland.code_district;
	select distinct nuisance_district, nuisance_inspector, nuisance_phone from jdeacutis.code_district;

	select distinct rental_district,   rental_inspector, rental_phone  from garland.code_district;
	select distinct rental_district,   rental_inspector, rental_phone  from jdeacutis.code_district;

--   ====================================================================
/*	LOST PARCEL IDS-

--	what parcels are in current Code District but not in the new Code District extract 		count = 192

	select 'LOST' " ", parcel_id, nuisance_district, rental_district, is_rental, council_id, police_beat, zip_code
	from	garland.code_district	C
	where parcel_id in
	(
	select parcel_id from garland.code_district
	minus
	select parcel_id from jdeacutis.code_district    
	)
	order by nuisance_district, parcel_id;


--	which of the above are in PARCEL_POINTS 									count = 0

	select count(*) from
(
	select parcel_id from gis.parcel_points
	intersect
	(
	select parcel_id_old from garland.code_district
	minus
	select parcel_id_old from jdeacutis.code_district
	)
);

--	which of the above are in PARCELS										count = 2

	select count(*) from								
(
	select parcel_id from gis.parcels
	intersect
	(
	select parcel_id_old from garland.code_district
	minus
	select parcel_id_old from jdeacutis.code_district
	)
);

--	which of the above are in CDRELPAR										count = 96

	select count(*) from								
(
	select parcel_id from garland.cdrelpar
	intersect
	(
	select parcel_id_old from garland.code_district
	minus
	select parcel_id_old from jdeacutis.code_district
	)
);


*/
--   ====================================================================
	
--	select * from jdeacutis.code_district  where is_rental = 0  and rownum < 11;
--	select * from jdeacutis.code_district  where is_rental = 1  and rownum < 11;
		     
--   ====================================================================
