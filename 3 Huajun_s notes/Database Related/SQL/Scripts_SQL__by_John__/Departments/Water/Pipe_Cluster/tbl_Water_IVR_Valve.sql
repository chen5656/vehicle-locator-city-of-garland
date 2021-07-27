	set echo	off;
--	========================================================================

--	drop   table	garland.Water_IVR_Valve;

	Create table	garland.Water_IVR_Valve
(
	Cluster_ID		number(10,0),
	Valve_ID		number(10,0)
)

	tablespace		gis_data
	nologging
	pctfree		5;

--	========================================================================

	create index	garland.Water_IVR_Valve_Cluster
		on		garland.Water_IVR_Valve(Cluster_ID)

	tablespace		gis_index
	nologging
	pctfree		5;

--	========================================================================

	create index	garland.Water_IVR_Valve_ID
		on		garland.Water_IVR_Valve(Valve_ID)

	tablespace		gis_index
	nologging
	pctfree		5;

--	========================================================================
	set echo	on;
