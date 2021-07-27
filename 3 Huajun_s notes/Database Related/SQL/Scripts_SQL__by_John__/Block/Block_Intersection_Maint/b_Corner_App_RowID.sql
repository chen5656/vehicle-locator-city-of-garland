	set echo		off;
	set timing		off;

--	build app Rowid reference table (to enhance mass update processing)

	select '*** build App RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	=========================================================================================================

	Truncate table	garland.GIS_App_RowID	reuse storage;

	alter rollback segment	rb1			online;
	set transaction	use rollback segment	rb1;

--	explain plan  set statement_id = 'xxx'   for

	insert into		garland.GIS_App_RowID

	select	rownum,
			rec_rowid
	from	
(
	select	c.esri_node,

			c.street1_num	
			r1.addr_pfx				addr1_pfx,
			r1.addr_name			addr1_name,
			r1.addr_type			addr1_type,
			r1.addr_sfx				addr1_sfx,

			c.street2_num	
			r2.addr_pfx				addr2_pfx,
			r2.addr_name			addr2_name,
			r2.addr_type			addr2_type,
			r2.addr_sfx				addr2_sfx,

			c.rowid				rec_rowid

	from		garland.Corner		c,
			garland.trvehRCL		r1,
			garland.trvehRCL		r2,

	where		c.road1_id	= r1.mslink
	and		c.road2_id	= r2.mslink

	order by	esri_node,	
			r1.addr_name, r1.addr_type,	
			r2.addr_name, r2.addr_type, 
			r1.addr_pfx,  r1.addr_sfx,	c.street1_num,  		
			r2.addr_pfx,  r2.addr_sfx,	c.street2_num
);

	commit;
	alter rollback segment	rb1			offline;

--	======================================================================

	select count(*) from garland.gis_app_rowid;

	select rpad(segment_name,30) segment_name, segment_type, bytes, extents, tablespace_name 
	from dba_segments
	where	segment_name in
	(
		select	index_name
		from		all_indexes
		where		table_name = 'GIS_APP_ROWID'
	);

--	======================================================================

	select 'analyze GIS_App_RowID table' " " from dual;

	analyze table	garland.gis_app_rowid	compute statistics;

--	======================================================================
