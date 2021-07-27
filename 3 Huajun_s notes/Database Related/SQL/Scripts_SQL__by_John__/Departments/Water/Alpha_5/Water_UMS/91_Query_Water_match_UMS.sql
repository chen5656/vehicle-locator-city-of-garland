	set echo off;
--	============================================================

	select count(*) "Water" from gis_temp2;		-- alpha5 SQL Loader

	select count(*) "UMS" from gis_objects;		-- UMS water serial extract


	select count(*) "bad name"	from adrResult_Water	where verify_code < 10;

	select count(*) "bad number"	from adrResult_Water	where verify_code between 10 and 49;

	select count(*) "partial"	from adrResult_Water	where verify_code = 54;

	select count(*) "wrong"		from adrResult_Water	where verify_code = 53;

	select count(*) "mixed"		from adrResult_Water	where verify_code = 52;

	select count(*) "poor"		from adrResult_Water	where verify_code = 51;

--	============================================================
--	Match on unimproved Name & Number
--	Water rarely has qualifiers

	select count(*)
	from	adrResult_Water
	where (form_name, addr_num)		in
(
	select form_name, addr_num
	from	adrResult_Water
	where	rtrim(addr_unit1) is null

	intersect

	select form_name, addr_num
	from	adrResult_UMS_Location
	where	rtrim(addr_unit1) is null
);

--	============================================================
--	how many Alpha5 serial numbers match UMS Water serial numbers

/*
	select count(*) from
(
	select lpad(rtrim(item02),8,'0')  from gis_temp2

	intersect

	select lpad(rtrim(item01),8,'0') from gis_objects
);
*/

--	============================================================
--	match UMS & Water		Name & Number

	select count(*) "Name/Num"	from	adrResult_Water
	where (addr_name, addr_num)	in
(
	select addr_name, addr_num	from adrResult_UMS_Location

	intersect

	select addr_name, addr_num	from adrResult_Water
);

--	============================================================
--	match UMS & Water		Address

--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = ' '		into garland.plan_table	for
	
	select count(*) from adrResult_Water

	where (addr_name, addr_num, addr_type, addr_pfx, addr_sfx)	in

(
	select addr_name, addr_num, addr_type, addr_pfx, addr_sfx	from adrResult_UMS_Location

	intersect

	select addr_name, addr_num, addr_type, addr_pfx, addr_sfx	from adrResult_Water
);

--	=================================================================================
--	insert into garland.plan_table (object_owner, object_name) values ('GARLAND', '');

--	select * from garland.explain_Plan;

--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

--	=================================================================================
	set echo on;
