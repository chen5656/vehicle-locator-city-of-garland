	set echo 		off;
	set fetchrows;
--	=================================================================================
--	BUILD WATER IVR VALVE
--	=================================================================================

	Truncate table	garland.WATER_IVR_VALVE		reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	insert --+ append
	into garland.Water_IVR_Valve
	select
		n.ClusterID,
		n.ValveID,
		v.ValveID	ValveName
	from	garland.Water_IVR_Node_Work	N,
		sde.Water_Valve_SDE		V
	where	n.ValveID = v.FeatureID
	order by n.ClusterID, n.ValveID;

	Commit;

--	=================================================================================

	select lpad(count(distinct Cluster_ID),13) Clusters	from garland.Water_IVR_Valve;

	select lpad(count(*),13) Cluster_Valve			from garland.Water_IVR_Valve;

	Analyze table	garland.Water_IVR_Valve		compute statistics;

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert into garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Column;
--	select * from garland.explain_Analyze;
--	=================================================================================
	set fetchrows;

