	set echo 		off;
	set fetchrows;
	set charwidth;
	set stoponerror	on;
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	select * from garland.cdreladr_copy
	where parcel_id in
(
	select parcel_id
	from
(
	select	w.cluster_id, w.parcel_id
		,v.phone
	from	garland.water_ivr_parcel	  W	
		,garland.verizon		  V
	where	w.parcel_id = v.parcel_id (+)
	and	w.cluster_id = 120901				-- 4100093
)
	where phone is null
)
;


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

	set echo		on;
	set fetchrows;
	set charwidth;



--	select cluster_id from garland.water_ivr_parcel where parcel_id = 4100093