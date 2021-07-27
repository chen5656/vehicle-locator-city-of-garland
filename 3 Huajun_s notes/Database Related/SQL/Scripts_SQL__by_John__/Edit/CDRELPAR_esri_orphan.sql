	set echo	off;

--	=======================================================
--	which CDRELPAR records are orphans without a graphic
--	tmp_view1 = gis_objects = //loader/esri_region.dat
--	=======================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

--	=======================================================

--	select distinct parcel_id, mslink		--	2309
--	from cdrelpar
--	where	parcel_id	in

(
	select parcel_id					--	1605
	from  cdrelpar
	where mslink in
(
	select ltrim(mslink) from cdrelpar
	minus
	select mslink from  tmp_view1
)
)
;


--	=======================================================

--	select * from explain_plan;

--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;

--	=======================================================
	set echo	on;


