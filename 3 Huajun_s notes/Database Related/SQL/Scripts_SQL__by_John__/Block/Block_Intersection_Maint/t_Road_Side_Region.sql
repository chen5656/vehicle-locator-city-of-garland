	set echo off;
--	====================================================================

--	drop table		garland.Road_Side_Region;

	create table	garland.Road_Side_Region
(
	Road_ID		number(08),
	Side			char,
	Region_Type		number(04),

	Region_ID		varchar2(20),

	Parity		number(02),
	Priority		numbet(02),
	Parcel_Count	numbet(02)
)

	tablespace		gis_data
	storage		(initial 100k  next 100k  pctincrease 0)
	nologging;

--	====================================================================

	alter table		garland.Road_Side_Region;
	add constraint	garland.Road_Side_Region_pkey
	primary key		(Road_ID, Side, Region_Type)

	using index
	tablespace		gisindx
	storage		(initial 100k  next 100k  pctincrease 0)
	nologging;

--	====================================================================
	set echo on;
