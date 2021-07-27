	set echo off;
--	====================================================================

--	IOT ????

--	====================================================================

--	drop table		garland.Block_Side_Region;

	create table	garland.Block_Side_Region
(
	Block_ID		number(08),
	Parity		number(02),
	Region_Type		number(04),

	Region_ID		varchar2(20),
	Priority		number(02)
)

	tablespace		gis_data
	storage		(initial 100k  next 100k  pctincrease 0)
	nologging;

--	====================================================================

	alter table		garland.Block_Side_Region;
	add constraint	garland.Block_Side_Region_pkey
	primary key		(Block_ID, Parity, Region_Type)

	using index
	tablespace		gisindx
	storage		(initial 100k  next 100k  pctincrease 0)
	nologging;

--	====================================================================
	set echo on;


