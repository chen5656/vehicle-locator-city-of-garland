	set echo	off;
--	========================================================================

--	drop   table	garland.Water_IVR_Pipe;

	Create table	garland.Water_IVR_Pipe
(
	Cluster_ID		number(10,0),
	Pipe_ID		number(10,0)
)

	tablespace		gis_data
	nologging
	pctfree		5;

--	========================================================================

	create index	garland.Water_IVR_Pipe_Cluster
		on		garland.Water_IVR_Pipe(Cluster_ID)

	tablespace		gis_index
	nologging
	pctfree		5;

--	========================================================================

	create index	garland.Water_IVR_Pipe_ID
		on		garland.Water_IVR_Pipe(Pipe_ID)

	tablespace		gis_index
	nologging
	pctfree		5;

--	========================================================================
	set echo	on;