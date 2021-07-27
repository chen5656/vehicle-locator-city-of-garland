--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;

--	================================================================
--	JDEACUTIS.CODE_DISTRICT_EXTERNAL

--	"Parcelid","Streetnum","Streetname","Streettype",
--	"Nuisance_Dist","Nuisance_Insp",
--	"Rental_dis","Rental_Insp",
--	"Council_Dist","Councilman"
--	================================================================

--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
	explain plan	set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================

	insert into garland.Code_District		C
(
	parcel_id,
	nuisance_district,
	nuisance_inspector,
	rental_district,
	rental_inspector,
	council_id
)
	select
	PARCEL_ID,		
	NUISANCE_DIST,	
	NUISANCE_INSP,	
	RENTAL_DIST,		
	RENTAL_INSP,		
	COUNCIL_DIST
	from	jdeacutis.code_district_external	E
	where not exists
(
	select 'x'
	from	garland.code_district			F
	where	f.parcel_id = e.parcel_id + 0
);

	COMMIT;	

--	=====================================================================
	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;


/*
--	=====================================================================

	select count(*) from jdeacutis.code_district_external;

	select count(*) from (     
	select parcel_id + 0 from jdeacutis.code_district_external
	minus
	select parcel_id from garland.code_district
	);

--	=====================================================================

	select distinct active from garland.rental_properties;

	select count(*) from (     
	select parcel_id + 0 from jdeacutis.code_district_external
	intersect
	select parcel_id from garland.rental_properties    where active = 'Y'
	);

--	=====================================================================

  	select count(*) from (
	select nuisance_district+0 from garland.code_district where nuisance_inspector is null
	intersect
	select district_number+0 from gis.code_nuisance_districts where inspector is not null
	);

--	=====================================================================
*/