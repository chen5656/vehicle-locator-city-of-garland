
--	=========================================================

	create table garland.Water_AVL_Workorder
(
	WorkOrder			integer	not null,
	Latitude			varchar2(8),
	Longitude			varchar2(9),
	RecordDate			date,
	Memo				varchar2(80)
)
	tablespace	gis_data
	nologging;

--	=========================================================

	alter table	garland.Water_AVL_Workorder
	add	constraint	Water_AVL_Workorder_pkey
		primary key(WorkOrder)
	using index
		tablespace	gis_index
		nologging;

--	=========================================================
