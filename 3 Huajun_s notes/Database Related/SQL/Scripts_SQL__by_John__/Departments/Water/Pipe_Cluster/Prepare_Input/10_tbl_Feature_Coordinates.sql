
--	===================================================================

--	see	\\sde\tables

--	===================================================================

	drop   table gis.FEATURE_COORDINATES;
	create table gis.FEATURE_COORDINATES
(
	featureclass		varchar2(20),
	featurename			varchar2(20),
	featureid			number(10),
	x1				number(10),
	y1				number(10),
	x2				number(10),
	y2				number(10),
	lengths			number(10)
)
	tablespace	gis_data
	nologging;

--	===================================================================

	create index gis.FEATURE_COORDINATES_ID
		on	 gis.FEATURE_COORDINATES(featureid)
	tablespace	gis_index
	nologging;

--	===================================================================

	create index gis.FEATURE_COORDINATES_X1
		on	 gis.FEATURE_COORDINATES(x1)
	tablespace	gis_index
	nologging;

--	===================================================================

