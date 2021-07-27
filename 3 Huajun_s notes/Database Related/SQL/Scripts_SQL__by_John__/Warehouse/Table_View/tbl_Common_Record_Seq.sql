	set echo off;
--	=========================================================

	drop table		garland.Common_Record_Seq;

	create table	garland.Common_Record_Seq
(
		gis_key		number(8,0),
		tax_key		number(8,0),
		ums_key		number(8,0),
		sequence		number(8,0)
)
	tablespace	gis_data
	nologging;

--	=========================================================

	create index	garland.Common_Record_Seq_GIS
		on		garland.Common_Record_Seq(GIS_KEY)

	tablespace		gis_index
	nologging;

--	=========================================================
