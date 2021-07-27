	set echo off;
--	====================================================================

--	drop table		garland.Radial_Side;

	create table	garland.Radial_Side
(
	Road_ID		number(08),
	Side			char,
	Junction		char,

	Parity		number(08),

	ESRI_Node		numbet(08),
	X_Vector		numbet(08),
	Y_Vector		numbet(08),

	Corner_Compass	varchar2(02),
	Twin_Compass	varchar2(01),

	Region_Type		number(04),
	Region_ID		varchar2(20)
)

	tablespace		gis_data
	storage		(initial 20k  next 20k  pctincrease 0)
	nologging;

--	====================================================================

	alter table		garland.Radial_Side
	add constraint	garland.Radial_Side_pkey
	primary key		(Road_ID, Side, Junction)

	using index
	tablespace		gisindx
	storage		(initial 20k  next 20k  pctincrease 0)
	nologging;

--	====================================================================
	set echo on;


