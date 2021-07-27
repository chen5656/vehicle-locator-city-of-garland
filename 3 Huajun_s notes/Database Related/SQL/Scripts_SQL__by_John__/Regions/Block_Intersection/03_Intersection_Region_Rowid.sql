	set echo		off;
	set timing		on;
--	=========================================================================================================
--	build Rowid reference table for Intersection Region View

	select '*** Build Intersection RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
--	=========================================================================================================

	truncate table	gis_app_rowid		reuse storage;
--	truncate table	plan_table			reuse storage;

	alter rollback segment	rb1			online;
	commit;
	set transaction	use rollback segment	rb1;

--	explain plan	set statement_id = 'rowid'	for

	insert into	gis_app_rowid
	select	rownum,
			rec_rowid
	from
(	select
			node_id,
			region,
			rowid		rec_rowid
	from		garland.intersection_region_view
	order by	1,2
);

--	=======================================================

	commit;
	alter rollback segment	rb1		offline;

--	======================================================================

	select count(*) from gis_app_rowid;

	select rpad(segment_name,30) segment_name, segment_type, bytes, extents, tablespace_name 
	from user_segments
	where	segment_name in
	(
		select	index_name
		from	ind
		where	table_name = 'GIS_APP_ROWID'
	);

--	======================================================================

	analyze table	gis_app_rowid	compute statistics;

--	======================================================================
	set echo		on;
	set timing		off;
