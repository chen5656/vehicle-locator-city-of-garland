
--	===================================================================

--	see	\\sde\tables

--	===================================================================

	drop   table gis.FEATURE_COORDINATES;
	create table gis.FEATURE_COORDINATES
(
	FeatureClass		varchar2(20),
	FeatureName			varchar2(20),
	FeatureID			number(10),
	X1				number(10),
	Y1				number(10),
	X2				number(10),
	Y2				number(10),
	Lengths			number(10)
)
	tablespace	gis_data
	nologging;

--	===================================================================

	create index gis.FEATURE_COORDINATES_ID
		on	 gis.FEATURE_COORDINATES(FeatureID)
	tablespace	gis_index
	nologging;

--	===================================================================

	create index gis.FEATURE_COORDINATES_X1
		on	 gis.FEATURE_COORDINATES(X1)
	tablespace	gis_index
	nologging;

--	===================================================================

