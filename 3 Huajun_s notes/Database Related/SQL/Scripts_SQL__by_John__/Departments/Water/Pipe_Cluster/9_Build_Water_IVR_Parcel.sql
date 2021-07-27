	set echo 		on;
	set fetchrows;
--	=================================================================================
--	BUILD WATER IVR VALVE
--	=================================================================================

	Truncate table	garland.WATER_IVR_PARCEL		reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	insert --+ append
	into garland.Water_IVR_Parcel

	select distinct

		w.Cluster_ID, 

		w.Pipe_ID,

		garland.convert_old_parcelid(p.Parcel_ID)

	from	 garland.Water_IVR_Pipe		W,
		 garland.View_Pipe_Parcel	P

	where	 w.Pipe_ID	= p.Pipe_ID
	and	 p.parcel_id > 0
	;

--	=================================================================================

	Commit;


	select lpad(count(distinct Cluster_ID),14) Clusters		from garland.Water_IVR_Parcel;

	select lpad(count(distinct Pipe_ID),14)	Cluster_Pipe	from garland.Water_IVR_Parcel;

	select lpad(count(*),14)			Cluster_Parcel	from garland.Water_IVR_Parcel;


	Analyze table	garland.Water_IVR_Parcel	compute statistics;

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert into garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================
	set fetchrows;

