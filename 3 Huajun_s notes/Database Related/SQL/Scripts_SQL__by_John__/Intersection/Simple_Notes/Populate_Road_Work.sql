--	================================================================
set echo		off;
set timing		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
--	====================================================================

	truncate table garland.Intersection_Road_Work  reuse storage;	

	insert --+ append
	into	garland.Water_IVR_Pipe_Work

	select
		RoadID		RoadID,
		x1 || y1		NodeID1,
		x2 || y2		NodeID2
	from	gis.Feature_Coordinates
	where	featureclass = 'ROAD'
	;

	COMMIT;

--	====================================================================

	analyze table garland.Intersection_Road_Work	compute statistics;

--	====================================================================

