	set echo		off;
	set timing		off;

--	build app Rowid reference table (to enhance mass update processing)

	select '*** build App RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	=========================================================================================================

	truncate table	garland.gis_app_rowid	reuse storage;

	alter rollback segment	rb1			online;
	commit;
	set transaction	use rollback segment	rb1;

--	explain plan  set statement_id = 'xxx'   for

	insert into		garland.gis_app_rowid

	select	rownum,
			rec_rowid
	from	
(
	select
		addr_name,
		addr_type,
		addr_pfx,
		addr_sfx,
		addr_num,
		rowid			rec_rowid
	from		garland.adrResult_Local	
	order by	rec_seq,  1,2,3,4,5			-- sep 2003
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

	select 'analyze input' " " from dual;

	analyze table	garland.gis_app_rowid	compute statistics;

--	======================================================================


