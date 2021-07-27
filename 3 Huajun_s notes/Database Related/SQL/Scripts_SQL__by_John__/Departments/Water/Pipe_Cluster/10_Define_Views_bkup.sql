	set echo off;
--	====================================================================
--				I N P U T
--	====================================================================
--	PIPE MASTER
--	Source:	SQL LOADER	\\loader\Water_Cluster_Pipe.ctl

	create or replace view	garland.View_Pipe_Master	AS

	select	item01	Pipe_ID,
			item02	From_Node,
			item03	To_Node,
			item04	Node_Types
	from		garland.gis_TEMP4;

--	====================================================================
--	NODE MASTER
--	Source:	SQL LOADER	\\loader\Water_Cluster_Node.ctl

	create or replace view	garland.View_Node_Master	AS

	select	item01	Node_ID,
			item02	Node_Type,
			item03	Valve_ID,
			item04	Num_Points,
			item05	X_Coord,
			item06	Y_Coord
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
--	Source:	SQL LOADER	\\loader\Water_Cluster_Valve.ctl

	create or replace view	garland.View_Valve_Master		AS

	select	item01	Node_ID,
			item02	Valve_ID
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

