	set echo		off;
	set timing		on;
	set fetchrows;
--	=========================================================================================================
--	build app Rowid reference table

	select '*** Build Block RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
--	=========================================================================================================

	truncate table	garland.gis_app_rowid	reuse storage;

	alter rollback segment	rb1			online;
	commit;
	set transaction	use rollback segment	rb1;

	insert into		garland.gis_app_rowid

		select	rownum - 1,
				rec_rowid
		from
	(
		select
				s.parity,
				r.addr_name,
				r.addr_type,
				r.addr_pfx,
				r.addr_sfx,
				r.addr_lo,
				r.junction,
				r.side

				s.rowid			rec_rowid

		from		garland.Radial_Side	s,
				garland.trvehRCL		r

		where		s.road_id	= r.mslink

		order by	1,2,3,4,5,6,7,8
	);

--	=======================================================

	commit;
	alter rollback segment	rb1			offline;

--	======================================================================

	select count(*) from garland.gis_app_rowid;

	select rpad(s.segment_name,30), s.segment_name, s.segment_type, s.bytes, s.extents, s.tablespace_name 
	from  user_segments	s,
		user_indexes	x
	where	x.index_name	= s.segment_name
	and	x.table_name	= 'GIS_APP_ROWID'; 	

--	======================================================================

	analyze table	garland.gis_app_rowid	compute statistics;

--	======================================================================

