	set echo		off;
	set timing		on;
	set fetchrows;
--	=========================================================================================================
--	build app Rowid reference table (to enhance mass update processing)

	select '*** build RowID table ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
--	=========================================================================================================

	truncate table	gis_app_rowid	reuse storage;

	alter rollback segment	rb1		online;
	commit;
	set transaction	use rollback segment	rb1;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	insert into		gis_app_rowid
	(
		select	rownum,		--	row_seq
				rec_rowid		--	row_id
		from
	(
		select
				MSLINK
				,rowid		rec_rowid

		from		SYN_FROM_TABLE
		order by	MSLINK
	));
		
--	=======================================================
--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_analyze;
--	=======================================================

	commit;
	alter rollback segment	rb1			offline;

--	======================================================================

	select count(*) from gis_app_rowid;

	select rpad(segment_name,30) segment_name, segment_type, bytes, extents, tablespace_name 
	from user_segments
	where	segment_name in
	(
		select	index_name
		from		ind
		where		table_name = 'GIS_APP_ROWID'
	);

--	======================================================================

	analyze table	gis_app_rowid	compute statistics;

--	======================================================================
