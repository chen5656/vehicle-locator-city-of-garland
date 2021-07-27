--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	====================================================================
--	A Water Pipe has a node at both ends
--	Each Water Pipe is identified by its Feature ID
--	Each Node is identified by the conjunction of its X & Y coordinates
--	Each Node may be an Interior, Valve, or Dead End node Type
--	====================================================================

	drop   table  garland.Water_IVR_Pipe_Work;
	create table  garland.Water_IVR_Pipe_Work
	(
		PipeID		number(10),
		ClusterID		number(10),
		NodeType1		varchar2(04),
		NodeType2		varchar2(04),
		NodeID1		varchar2(40),
		NodeID2		varchar2(40)
	)
		tablespace	gis_data
		nologging;

	create index 	garland.Water_IVR_Pipe_Work_Node
		on		garland.Water_IVR_Pipe_Work(NodeID1)
		tablespace	gis_index
		nologging;

--	========================================================================================
--	Pipe  ID is the Water Pipe  feature ID
--	Valve ID is the Water Valve feature ID
--	Each Pipe has two nodes; thus two Node records per pipe.
--	Each Node ID consists of concantenated X & Y coordinates (integers)
--	ALL Node IDs are Pipe Node IDs
--	If the Pipe Node overlays a Water Valve, then the  Pipe Node ID is a Valve Node Type
--	If a Valve is only near a Pipe Node, then the near Pipe Node ID is a Valve Node Type
--	Not all Nodes are Valves. There are also Interior and Dead End Nodes.
--	========================================================================================

	drop   table garland.Water_IVR_Node_Work;
	create table garland.Water_IVR_Node_Work
	(
		PipeID		number(10)
		ValveID		number(10),
		NodeType		varchar2(04),
		NodeID		varchar2(40),
	)
		tablespace	gis_data
		nologging;

	create index 	garland.Water_IVR_Node_Work_Node
		on		garland.Water_IVR_Node_Work(NodeID)
		tablespace	gis_index
		nologging;

--	====================================================================

