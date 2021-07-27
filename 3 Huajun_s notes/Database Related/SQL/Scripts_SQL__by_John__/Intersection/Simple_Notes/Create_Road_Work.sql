--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	====================================================================
--	A Road has a node at both ends
--	Each Road is identified by its Road ID
--	Each Node is identified by the conjunction of its X & Y coordinates
--	Each Node may be an Interior, Valve, or Dead End node Type
--	====================================================================

	drop   table  garland.Intersection_Road_Work;
	create table  garland.Intersection_Road_Work
	(
		RoadID		number(08),
		NodeID1		varchar2(40),
		NodeID2		varchar2(40),
		StreetID		number(08),
		LoBlock		number(08),
		HiBLock		number(08)
	)
		tablespace	gis_data
		nologging;

	create index 	garland.Intersection_Road_Work
		on		garland.Intersection_Road_Work(RoadID)
		tablespace	gis_index
		nologging;

	create index 	garland.Intersection_Road_Work
		on		garland.Intersection_Road_Work(NodeID1)
		tablespace	gis_index
		nologging;

