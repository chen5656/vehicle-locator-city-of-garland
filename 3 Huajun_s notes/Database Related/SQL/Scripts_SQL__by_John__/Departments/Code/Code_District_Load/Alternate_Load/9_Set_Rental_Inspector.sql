--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;

--	=====================================================================

--	USE ONLY IN AN EMERGENCY

--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
	explain plan	set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================

	update garland.Code_District		C
	set   ( rental_inspector, rental_district )  = 
(
	select distinct rent_insp, rent_dist
	from	garland.Rental_Properties	R	
	where	r.parcel_id	= c.parcel_id
)
	and exists
(
	select 'x'
	from	garland.Rental_Properties	R	
	where	r.parcel_id	= c.parcel_id
);

--	=====================================================================
	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

/*
	select count(*) dist  from garland.code_district  where ltrim(rental_district) is null;
	select count(*) insp  from garland.code_district  where ltrim(rental_inspector) is null;
	select count(*) phone from garland.code_district  where ltrim(rental_phone) is null;
	select count(*) from garland.code_district  where is_rental > 0;

	select count(*) from
	(
	select parcel_id from garland.code_district
	intersect
	select parcel_id from garland.rental_properties   
	);
*/
   
--	=====================================================================
