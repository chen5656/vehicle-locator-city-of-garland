--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
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
	select distinct
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
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Column;
--	select * from garland.explain_Analyze;
--	=================================================================================

