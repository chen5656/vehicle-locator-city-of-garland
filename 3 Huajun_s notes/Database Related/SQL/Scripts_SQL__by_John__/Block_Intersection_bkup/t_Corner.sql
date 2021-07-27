	set echo off;
--	====================================================================

--	drop table		garland.Corner;

	create table	garland.Corner
(
	Road1_ID		number(08),
	Road1_ID		number(08),
	Intersection_ID	number(08),

	Side1			char,
	Side2			char,
	Junction1		char,
	Junction2		char,

	Parity		number(02),

	Street1_Num		numbet(06),
	Street2_Num		numbet(06),

	ESRI_Node		numbet(08),

	Region_Type		number(04),
	Region_ID		varchar2(20)
)

	tablespace		gis_data
	storage		(initial 100k  next 100k  pctincrease 0)
	nologging;

--	====================================================================

	create index	garland.Corner_Intersection
	on			garland.Corner (Intersection_ID)
	tablespace		gisindx
	storage		(initial 100k  next 100k  pctincrease 0)
	nologging;

--	====================================================================

	create index	garland.Corner_Road1
	on			garland.Corner (Road1_ID)
	tablespace		gisindx
	storage		(initial 100k  next 100k  pctincrease 0)
	nologging;

--	====================================================================

	create index	garland.Corner_Road2
	on			garland.Corner (Road2_ID)
	tablespace		gisindx
	storage		(initial 100k  next 100k  pctincrease 0)
	nologging;

--	====================================================================
	set echo on;




