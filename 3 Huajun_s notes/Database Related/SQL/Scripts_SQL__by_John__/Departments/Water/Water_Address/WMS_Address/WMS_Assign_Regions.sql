	set echo 		off;
	set fetchrows;
	set charwidth;
	set stoponerror	on;
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	update garland.wms_address	W
	set FIRE_district = 
(
	select distinct(FIRE_district)
	from garland.cdrelpar		P
	where p.parcel_id_new = w.parcel_id
);

	commit;

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert   into garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	delete   from jdeacutis.plan_table where object_name like 'SDE%' or object_name like 'GDB%';

--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Analyze;
--	select * from garland.explain_Table;
--	select * from garland.explain_Column;

--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Dependent;
--	=================================================================================

/*
	select count(*) from
(
	select parcel_id_new
	from garland.cdrelpar
	group by parcel_id_new
	having count(distinct fire_district) > 1
);
*/
--	=================================================================================
	set fetchrows;
	set charwidth;
