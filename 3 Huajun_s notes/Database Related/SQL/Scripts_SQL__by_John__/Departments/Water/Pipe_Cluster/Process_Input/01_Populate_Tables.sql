--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	====================================================================
--				I N P U T
--	====================================================================
--	Node Types
--		'V'		Valve			external node
--		'v'		Dead End		external node
--		'D'		Dangle		interior node
--	====================================================================

	truncate table garland.Water_IVR_Pipe_Work  reuse storage;	

	insert --+ append
	into	garland.Water_IVR_Pipe_Work
	select
		featureid		PipeID,
		null			ClusterID,
		x1 || y1		NodeID1,
		x2 || y2		NodeID2
	from	gis.Feature_Coordinates
	where	featureclass = 'WTPI'
	order by featureid;

	COMMIT;

--	====================================================================

	truncate table garland.Water_IVR_Node_Work  reuse storage;	

	insert --+ append
	into	garland.Water_IVR_Node_Work
	select distinct
		Node_ID,
		Node_Type,
		Valve_ID + 0,
		X_Coord  + 0,
		Y_Coord  + 0
	from	garland.view_Node_Master;

	COMMIT;

--	====================================================================
