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
--		'D'		Dead End		external node
--		'I'		Interior		interior node	(Dangle)
--	====================================================================

	drop   table  garland.Water_IVR_Pipe_Work;
	create table  garland.Water_IVR_Pipe_Work
	(
		PipeID		number(10),
		ClusterID		number(10),
		NodeID1		varchar2(40),
		NodeID2		varchar2(40)
	)
		tablespace	gis_data
		nologging;

	create index 	garland.Water_IVR_Pipe_Work_Node
		on		garland.Water_IVR_Pipe_Work(NodeID1)
		tablespace	gis_index
		nologging;

--	====================================================================

	drop  table	 garland.Water_IVR_Node_Work;
	create table garland.Water_IVR_Node_Work
	(
		NodeID		varchar2(40),
		NodeType		varchar2(05),
		ValveID		number(10),
		X			number(20,10),
		Y			number(20,10)
	)
		tablespace	gis_data
		nologging;

	create index 	garland.Water_IVR_Node_Work_Node
		on		garland.Water_IVR_Node_Work(NodeID1)
		tablespace	gis_index
		nologging;

--	====================================================================

	create or replace view	garland.Temp_View		as
		select	item01	ClusterHI,
				item02	ClusterLO
		from		garland.gis_objects;

--	====================================================================
