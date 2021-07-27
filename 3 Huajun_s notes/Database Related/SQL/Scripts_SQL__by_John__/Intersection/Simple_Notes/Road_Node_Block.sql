set linesize 2000;
=========================================================================

create table	garland.ROAD_NODE_BLOCK
(
	roadid		number(8),
	xcoord		number(8),
	ycoord		number(8),
	at_block		numbet(6),
	lo_block		number(6),
	hi_block		number(6),
	quadrant		varchar2(4)
)
	tablespace	gis_data;

=========================================================================

create index	garland.ROAD_NODE_BLOCK_ID
	on		garland.ROAD_NODE_BLOCK(RoadID)
	tablespace	gis_index;


create index	garland.ROAD_NODE_BLOCK_X
	on		garland.ROAD_NODE_BLOCK(XCoord)
	tablespace	gis_index;

=========================================================================
