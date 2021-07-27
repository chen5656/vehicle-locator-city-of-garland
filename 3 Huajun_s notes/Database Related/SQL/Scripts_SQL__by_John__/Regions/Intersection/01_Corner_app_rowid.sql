	set echo		off;
	set timing		on;
--	=========================================================================================================
--	build app Rowid reference table (to enhance mass update processing)

	select '*** build Corner RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
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
				c.node_id,
				b1.addr_name,
				b1.addr_type,
				b2.addr_name,
				b2.addr_type,

				b1.addr_pfx,
				b1.addr_sfx,
				b1.addr_block,

				b2.addr_pfx,
				b2.addr_sfx,
				b2.addr_block,

				c.rowid		rec_rowid

		from		corner		c,
				intersection	x,
				adrBlock_Side	b1,
				adrBlock_Side	b2

		where		c.block1_rowid	= b1.rowid
		and		c.block2_rowid	= b2.rowid
		and		c.intersect_rowid = x.rowid
		and		x.intersect_id	like 'BB%'
		order by	1,2,3,4,5,6,7,8,9	
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
