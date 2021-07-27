	set echo off;
--	=================================================================================================

	select lpad(count(distinct Cluster_ID)	,14) 	Clusters		from garland.Water_IVR_Pipe;

	select lpad(count(*)				,14)	Cluster_Pipes	from garland.Water_IVR_Pipe;


	select lpad(count(distinct Cluster_ID)	,14) 	Clusters		from garland.Water_IVR_Valve;

	select lpad(count(*)				,14) 	Cluster_Valve	from garland.Water_IVR_Valve;



	select lpad(count(distinct Cluster_ID)	,14) 	Clusters		from garland.Water_IVR_Parcel;

	select lpad(count(distinct Pipe_ID)		,14)	Cluster_Pipe	from garland.Water_IVR_Parcel;

	select lpad(count(*)				,14)	Cluster_Parcel	from garland.Water_IVR_Parcel;

--	=================================================================================================

