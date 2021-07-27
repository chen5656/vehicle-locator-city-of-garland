	set echo off;
--	====================================================================

--	see Pipe_Cluster directory

--	====================================================================
--				I N P U T
--	====================================================================
--	Node Types
--		'V'		Valve 	(Valve Point is at     Pipe Endpoint
--		'VV'		Valve 	(Valve Point is "near" Pipe Endpoint
--		'v'		Dead End	(Pipe Endpoint not attached to anything)
--		'D'		Dangle	(pipe-pipe junction)
--	====================================================================

--	PIPE MASTER
--	source:	gis.Feature_Coordinates		\\departments\water\pipe_cluster\line_coordinates.sql

	create or replace view	garland.View_Pipe_Master	AS
	select	item01	Pipe_ID,
			item02	From_Node,
			item03	To_Node,
			item04	Node_Types
	from		garland.gis_TEMP4;

--	====================================================================
--	NODE MASTER
--	source:	gis.Feature_Coordinates		\\departments\water\pipe_cluster\build_node_master.sql

	create or replace view	garland.View_Node_Master	AS
	select	item01	Node_ID,
			item02	Node_Type,
			item03	Valve_ID,
			item04	Pipe_ID
	from		garland.gis_OBJECTS;

--	====================================================================
--	PARCEL MASTER
--	Source:	SQL LOADER	\\loader\Water_Cluster_Parcel.ctl

	create or replace view	garland.View_Parcel_Master	AS
	select	item01	Pipe_ID,
			item02	Parcel_ID
	from		garland.gis_TEMP1;

--	====================================================================
--	VALVE MASTER
--	source:	gis.Feature_Coordinates		\\departments\water\pipe_cluster\point_coordinates.sql

	create or replace view	garland.View_Valve_Master		AS
	select	item01	Node_ID,
			item02	Valve_ID,
			item03	Valve_Name
	from		garland.gis_TEMP2;

--	====================================================================
--				O U T P U T
--	====================================================================
--	PIPE PAIR
--	Source:	\\departments\water\pipe_cluster\POPULATE_PIPE_PAIR

	create or replace view	garland.View_Pipe_Pair		AS
	select	item01	Pipe1_ID,
			item02	Pipe2_ID
	from		garland.gis_TEMP2;

--	====================================================================
--	PIPE GROUP
--	Source:	\\departments\water\pipe_cluster\INITIAL_PIPE_GROUP
--			\\departments\water\pipe_cluster\POPULATE_PIPE_GROUP

	create or replace view	garland.View_Pipe_Group		AS
	select	item01	Pipe_ID,
			item02	Group_ID
	from		garland.gis_TEMP3;


--	====================================================================
