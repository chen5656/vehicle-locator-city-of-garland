	set echo		off;
	set timing		on;
--	=========================================================================================================
	select '*** build Radial RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
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
		select	c.rowid		rec_rowid

		from		garland.Radial_Side	s,
				garland.trvehRCL		r

		where		s.road_id	= s.road_id

		order by	r.addr_name,
				r.addr_type,
				r.addr_pfx,
				r.addr_sfx,
				r.addr_lo,
				s.junction,
				s.side
	));
		
--	=======================================================
--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;
--	=======================================================

	commit;
	alter rollback segment	rb1		offline;

--	======================================================================

	select count(*) from gis_app_rowid;
	comment on table	gis_app_rowid is 'Corner table';

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
