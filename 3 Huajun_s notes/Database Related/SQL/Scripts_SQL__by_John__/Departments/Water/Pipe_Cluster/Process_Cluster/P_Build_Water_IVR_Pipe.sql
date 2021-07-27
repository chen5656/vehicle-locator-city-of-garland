--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=================================================================================
--	BUILD WATER IVR PIPE
--	=================================================================================

	Truncate table	garland.WATER_IVR_PIPE		reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	insert --+ append
	into garland.Water_IVR_Pipe
	select 
		ClusterID,
		PipeID
	from	garland.WATER_IVR_PIPE_WORK
	order by ClusterID, PipeID;

	Commit;

--	=================================================================================
--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Column;
--	select * from garland.explain_Analyze;
--	=================================================================================

	select lpad(count(distinct Cluster_ID),13) Clusters	from garland.Water_IVR_Pipe;

	select lpad(count(*),13) Cluster_Pipes			from garland.Water_IVR_Pipe;

	Analyze table	garland.Water_IVR_Pipe		compute statistics;

--	=================================================================================

