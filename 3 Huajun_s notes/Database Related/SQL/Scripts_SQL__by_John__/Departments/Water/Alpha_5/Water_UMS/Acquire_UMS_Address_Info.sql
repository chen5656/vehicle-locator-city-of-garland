	set echo off;
--	=================================================================================
--	Acquire UMS Address Info for David Jacobs and David consultant
--	=================================================================================
/*

	create or replace view	garland.Temp_View2	AS
(
	select
		item02	serial_no,			-- july 2005
		item01	location_no,

		item03	addr_num,
		item04	addr_pfx,
		item05	addr_name,
		item06	addr_type,
		item07	addr_sfx,
		item08	addr_bldg,
		item09	addr_unit
	
	from	garland.GIS_Temp2
);
*/

--	=================================================================================
	truncate table	garland.plan_table	reuse storage;
	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	update garland.Temp_View2		T
	set	location_no
	=
(
	select location_no
	from	sfg.um00100m@umsrep.world
	where	location_no	= t.location_no
);


--	=================================================================================
--	insert into garland.plan_table (object_owner, object_name) values ('GARLAND', '');

	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

	savepoint	xxx;	
	Rollback;
	Commit;

--	Comment on table	garland.	is '' ;

--	=================================================================================
	set echo on;

