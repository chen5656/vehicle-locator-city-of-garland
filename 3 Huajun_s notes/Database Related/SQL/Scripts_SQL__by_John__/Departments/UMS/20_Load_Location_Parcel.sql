	set echo	off;
--	===================================================================
--	build table to associate each UMS location with a GIS parcel id
--	use the results from the address_resolve package
--	===================================================================

	truncate table	ums_location_parcel	reuse storage;

	truncate table	plan_table;
	explain plan	set statement_id = 'a'		for

--	=======================================================

	insert into	ums_location_parcel

	select distinct
		rec_key,
		parcel_id
	from	adrResult
	where	parcel_id > '0';

--	=======================================================

	select * from explain_plan;

--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;

--	=======================================================
	set echo	on;


