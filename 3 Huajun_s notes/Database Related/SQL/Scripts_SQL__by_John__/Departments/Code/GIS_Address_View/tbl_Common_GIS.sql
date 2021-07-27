	set echo	off;
--	========================================================================

--	drop   table	garland.Common_GIS;

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
	storage		(initial 100k  next 100k pctincrease 0)
	nologging;

--	========================================================================

	create index	garland.Common_GIS_AID
		on		garland.Common_GIS (address_id)
	tablespace		gisindx
	storage		(initial 100k  next 100k pctincrease 0)
	nologging;

--	========================================================================
/*
	create index	garland.Code_GIS_address
		on		garland.Code_GIS (addr_name, addr_num)
	using index
	tablespace		gisindx
	storage		(initial 100k  next 100k pctincrease 0)
	nologging;
*/
--	========================================================================
	set echo	on;
