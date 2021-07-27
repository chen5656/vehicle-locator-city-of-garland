	set echo off;
--	====================================================================

--	drop table		garland.ESRI_Node;

	create table	garland.ESRI_Node
(
	Node_Num		number(08),
	X_Coord		number(08),
	Y_Coord		numbet(08)
)

	tablespace		gis_data
	storage		(initial 20k  next 20k  pctincrease 0)
	nologging;

--	====================================================================

	create index	garland.ESRI_Node_Num
		on		garland.ESRI_Node (Node_Num)

	tablespace		gisindx
	storage		(initial 20k  next 20k  pctincrease 0)
	nologging;

--	====================================================================
	set echo on;


