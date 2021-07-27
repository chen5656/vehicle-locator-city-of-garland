--	=====================================================================
set echo		off
set timing		off
set sqlblanklines	on
set serveroutput	on	size 99999
set linesize	2000
set pagesize	9999
-- set pagesize	74
-- set pagesize	57
-- alter session set nls_date_format = 'yyyymmdd hh24miss'  
--	=====================================================================

--      select * from all_tab_columns@rentals.world where table_name = 'ParcelByInspector';

--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
--	=====================================================================
--	explain plan	set statement_id = 'AAA' into jdeacutis.plan_table for
--	=====================================================================

	select count(*) not_rental_error
	from	garland.code_district_new		C,
		ParcelByInspector@rentals.world	P
	where	c.parcel_id = p."Parcel_Id_OLD"
	and	c.is_rental = 0
	;
--	=====================================================================
--	explain plan	set statement_id = 'BBB' into jdeacutis.plan_table for
--	=====================================================================

--	select count(*) is_rental_error	from
	select *	from
(
	select parcel_id_old	from garland.Code_District_New where is_rental > 0
	minus
	select "Parcel_Id_OLD"	from ParcelByInspector@rentals.world
);

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('JDEACUTIS', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

