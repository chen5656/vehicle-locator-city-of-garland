--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- alter session	set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	=====================================================================
/*
	create table garland.Rental_Properties_Extract
		tablespace gis_data
	as	select * from garland.Rental_Properties;

	create index garland.Rental_Properties_Extract_PID
		on	 garland.Rental_Properties_Extract(Parcel_ID)
	nologging
	tablespace gis_index;

*/
--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================

	update	Garland.Rental_Properties_Extract	R
	set	( rent_dist, rent_insp )	=
(
	select	code_rental, c.inspector_name
	From	gis.Parcel_Point				P,
		garland.Code_Inspector_Extract	C
	where	p.parcelid 		= r.parcel_id
	and	p.code_rental	= c.inspector_district
);


	Select * from Garland.Rental_Properties_Extract where rownum < 22;

--	ROLLBACK;
--	COMMIT;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('GIS', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

