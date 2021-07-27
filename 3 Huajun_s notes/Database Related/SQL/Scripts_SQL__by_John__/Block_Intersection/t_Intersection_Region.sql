	set echo off;
--	====================================================================

--	IOT ????

--	====================================================================

--	drop table		garland.Intersection_Region;

	create table	garland.Intersection_Region
(
	Intersection_ID	number(08),
	Region_Type		number(04),

	Region_ID		varchar2(20),
	Parity		number(02)
)

	tablespace		gis_data
	storage		(initial 100k  next 100k  pctincrease 0)
	nologging;

--	====================================================================

	alter table		garland.Intersection_Region;
	add constraint	garland.Intersection_Region_pkey
	primary key		(Intersection_ID, Region_Type)

	using index
	tablespace		gisindx
	storage		(initial 100k  next 100k  pctincrease 0)
	nologging;

--	====================================================================
	set echo on;

