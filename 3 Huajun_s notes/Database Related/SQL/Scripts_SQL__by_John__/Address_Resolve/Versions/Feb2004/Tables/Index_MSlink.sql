
--	==================================================================================================

	create index	garland.gis_verify_addr_MSLINK
		on		garland.gis_verify_addr (segment_id)
	tablespace		gisindx
	storage		(initial 2m  next 1m  pctincrease 0);

--	==================================================================================================

	select SEGMENT_NAME, EXTENTS, BYTES, BLOCKS from user_segments where segment_name = 'GIS_VERIFY_ADDR_MSLINK';

--	==================================================================================================


