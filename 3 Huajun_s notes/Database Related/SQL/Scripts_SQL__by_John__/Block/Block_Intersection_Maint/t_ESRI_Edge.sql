	set echo off;
--	====================================================================

--	drop table		garland.ESRI_Edge;

	create table	garland.ESRI_Edge
(
	Road_ID		number(08),
	From_Node		number(08),
	To_Node		numbet(08)
)

	tablespace		gis_data
	storage		(initial 20k  next 20k  pctincrease 0)
	nologging;

--	====================================================================

	create index	garland.ESRI_Edge_Road
		on		garland.ESRI_Edge (Road_ID)

	tablespace		gisindx
	storage		(initial 20k  next 20k  pctincrease 0)
	nologging;

--	====================================================================
	set echo on;

