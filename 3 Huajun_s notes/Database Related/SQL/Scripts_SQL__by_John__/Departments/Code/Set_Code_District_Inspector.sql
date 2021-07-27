--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- alter session	set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	=====================================================================

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================

	update garland.code_district			C
	set	(NUISANCE_inspector, NUISANCE_phone) = 
(
	select inspector, phone
--	from	gis.code_NUISANCE_districts		D
	from	SDE.code_NUISANCE_districts_SDE	D
	where	d.district_number = c.NUISANCE_district||''
)
--	where rownum < 11
	;

	select distinct NUISANCE_DISTRICT, NUISANCE_inspector, NUISANCE_phone
	from	garland.code_district
--	where rownum < 11
	;

--	select * from gis.code_NUISANCE_districts;
	select * from SDE.code_NUISANCE_districts_SDE;

	COMMIT;

--	=====================================================================

	update garland.code_district			C
	set	(RENTAL_inspector, RENTAL_phone) = 
(
	select inspector, phone
--	from	gis.code_RENTAL_districts		D
	from	SDE.code_RENTAL_districts_SDE		D
	where	d.district_number = c.RENTAL_district
)
--	where rownum < 11
	;

	select distinct RENTAL_district, RENTAL_inspector, RENTAL_phone
	from	garland.code_district
--	where rownum < 11
	;

--	select * from gis.code_RENTAL_districts;
	select * from SDE.code_RENTAL_districts_SDE;

	COMMIT;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('GIS', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================
