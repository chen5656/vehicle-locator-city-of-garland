--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	====================================================================
--				I N P U T
--	====================================================================
--	Node Types
--		'V'		Valve
--		'v'		Dead End
--		'D'		Dangle
--	====================================================================

	create table  garland.Water_IVR_Pipe_Work
	(
		PipeID		number(10),
		ClusterID		number(10),
		NodeID1		number(20,0),
		NodeID2		number(20,0)
	)
		tablespace	gis_data
		nologging;


	create index 	garland.Water_IVR_Pipe_Work_Node
		on		garland.Water_IVR_Pipe_Work(NodeID1)
		tablespace	gis_index
		nologging;

--	====================================================================

	create or replace view	garland.Temp_View		as
		select	item01	clusterID1,
				item02	clusterID2
		from		garland.gis_objects;

--	====================================================================
