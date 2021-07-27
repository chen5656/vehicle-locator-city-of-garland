
--	=========================================================

	create table garland.Water_AVL_Tracking
(
	Tracking_ID			integer	not null,
	Vehicle			char(4),
	Speed				integer,
	Latitude			varchar2(8),
	Longitude			varchar2(9),
	Heading			varchar2(3),
	RecordDate			date		not null,
	Memo				varchar2(80)
)
	tablespace	GIS_DATA
	nologging;

--	=========================================================

	alter table	garland.Water_AVL_Tracking
	add	constraint	Water_AVL_Tracking_pkey
		primary key(Tracking_ID)
	using index
		tablespace	GIS_INDEX
		nologging;

--	=========================================================

