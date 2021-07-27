	set echo 		off;
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	update garland.code_district_new	C
	set	(nuisance_inspector, nuisance_phone) =
(
	select item02, item03
	from garland.gis_objects
	where	item01 = rtrim(c.nuisance_district)
)
	where exists
(
	select 'x'
	from garland.gis_objects
	where	item01 = rtrim(c.nuisance_district)
);

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert into   garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================

--	select * from garland.code_district_new	where rownum < 111  and nuisance_district = 10;

	rollback;
	commit;

--	=================================================================================
--	desc garland.code_district_new;
