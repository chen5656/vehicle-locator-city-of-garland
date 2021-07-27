	set echo	off;
--	========================================================================

--	drop   table	garland.Water_IVR_Parcel;

	Create table	garland.Water_IVR_Parcel
(
	Cluster_ID		number(10,0),
	Pipe_ID		number(10,0),
	Parcel_ID		number(10,0)
)

	tablespace		gis_data
	nologging
	pctfree		5;

--	========================================================================

	create index	garland.Water_IVR_Parcel_Cluster
		on		garland.Water_IVR_Parcel(Cluster_ID)

	tablespace		gis_index
	nologging
	pctfree		5;

--	========================================================================

	create index	garland.Water_IVR_Parcel_ID
		on		garland.Water_IVR_Parcel(Parcel_ID)

	tablespace		gis_index
	nologging
	pctfree		5;

--	========================================================================
	set echo	on;
