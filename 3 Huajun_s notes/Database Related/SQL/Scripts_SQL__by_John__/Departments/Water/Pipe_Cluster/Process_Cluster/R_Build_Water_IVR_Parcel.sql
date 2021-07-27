--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	=================================================================================
--	BUILD WATER IVR VALVE  FROM FEATURE LOADED FROM SHAPE FILE EXTRACT (SEAN)
--	=================================================================================

	Truncate table	garland.WATER_IVR_PARCEL		reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

--	select count(*) from   (

	insert --+ append 
	into	garland.Water_IVR_Parcel
	select distinct
			w.Cluster_ID, 
			w.Pipe_ID,
			garland.convert_old_parcelid(p.Parcel_ID)
	from	garland.Water_IVR_Pipe		W,
		gis.PIPE_PARCEL			P
	where	w.Pipe_ID	= p.PIPEID
	and	p.parcel_id > '0'
    ;

	Commit;

--	=================================================================================

--	select lpad(count(distinct Cluster_ID),14) Clusters		from garland.Water_IVR_Parcel;

	select lpad(count(distinct Pipe_ID),14)	Cluster_Pipe	from garland.Water_IVR_Parcel;

	select lpad(count(*),14)			Cluster_Parcel	from garland.Water_IVR_Parcel;


	Analyze table	garland.Water_IVR_Parcel	compute statistics;

--	=================================================================================
--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Column;
--	select * from garland.explain_Analyze;
--	=================================================================================

