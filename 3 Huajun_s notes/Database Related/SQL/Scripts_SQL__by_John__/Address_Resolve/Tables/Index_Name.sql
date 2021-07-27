
--	==================================================================================================

	create index	garland.gis_verify_addr_NAME
		on		garland.gis_verify_addr (addr_name)
	tablespace		gisindx
	storage		(initial 2m  next 1m  pctincrease 0);

--	==================================================================================================

	select SEGMENT_NAME, EXTENTS, BYTES, BLOCKS from user_segments where segment_name = 'GIS_VERIFY_ADDR_NAME';

--	==================================================================================================


