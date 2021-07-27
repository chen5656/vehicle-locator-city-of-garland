	set echo off;
--	====================================================================

	create table  garland.parcel_convert
(
	old_parcel_id	varchar2(12),
	new_parcel_id	number(10,0)
)
	tablespace		gis_data
	nologging
	pctfree 5;

--	====================================================================

	create index	garland.parcel_convert_old
		on		garland.parcel_convert(old_parcel_id)
	tablespace		gis_index
	nologging
	pctfree 5;

--	====================================================================

	create index	garland.parcel_convert_new
		on		garland.parcel_convert(new_parcel_id)
	tablespace		gis_index
	nologging
	pctfree 5;

--	====================================================================


