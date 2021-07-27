	set echo	off;
--	**********************************************************************
--	build app Rowid reference table (to enhance mass update processing)
--	**********************************************************************

	select '*** build App RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	===================================================================================================

	truncate table	garland.GIS_app_rowid	reuse storage;

	alter rollback segment	rb1			online;
	set transaction	use rollback segment	rb1;

--	explain plan  set statement_id = 'xxx'   for

	insert into	garland.gis_app_rowid

	select	rownum,
			rec_rowid
	from	
(
	select
		macctno,
		rowid			rec_rowid
	from	garland.Tax
	order by 1
);

	commit;
	alter rollback segment	rb1	offline;

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

--	**********************************************************************
