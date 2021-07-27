	set echo		off;
	set timing		on;
--	=========================================================================================================
	select '*** build Corner RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
--	=========================================================================================================

	truncate table	GIS_app_rowid	reuse storage;

	alter rollback segment	rb1		online;
	commit;
	set transaction	use rollback segment	rb1;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	insert into		garland.gis_app_rowid
	(
		select	rownum,		--	row_seq
				rec_rowid		--	row_id
		from
	(
		select	c.rowid		rec_rowid

		from		garland.Corner		c,
				garland.trvehRCL		r1,
				garland.trvehRCL		r2

		where		c.road1_id	= r1.mslink
		and		c.road2_id	= r2.mslink

		order by
				c.esri_node,
				r1.addr_name,
				r1.addr_type,
				r2.addr_name,
				r2.addr_type,

				r1.addr_pfx,
				r1.addr_sfx,
				r1.addr_lo,

				r2.addr_pfx,
				r2.addr_sfx,
				r2.addr_lo
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
