	set echo	off;
--	========================================================================

	drop   table	garland.Common_GIS;

	Create table	garland.Common_GIS
(
	mslink		number,
	address_id		number,
	parcel_id		varchar2(11),
	block_id		number,
	street_id		number,
	intersect_id1	varchar2(20),
	intersect_id2	varchar2(20),

	TAX_id		varchar2(40),
	UMS_id		varchar2(40)
)

	tablespace		gis_data
	nologging;


--	========================================================================

	create index	garland.Common_GIS_AID
		on		garland.Common_GIS (address_id)

	tablespace		gis_index
	nologging;

--	========================================================================
/*
	create index	garland.Common_GIS_ADDRESS
		on		garland.Common_GIS (addr_name, addr_num)
	using index
		tablespace		gis_index
		nologging;
*/
--	========================================================================
