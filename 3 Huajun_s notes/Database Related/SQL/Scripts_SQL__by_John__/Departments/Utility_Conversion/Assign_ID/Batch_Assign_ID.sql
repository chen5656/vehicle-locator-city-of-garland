	set echo		off;
--	===================================================================================
--	build App Rowid reference table (for mass update processing)

	select '*** build App RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') 		
		 " "	from dual;

--	===================================================================================

	Truncate table	garland.GIS_App_Rowid		reuse storage;

--	===================================================================================

	alter rollback segment	rb1			online;
	commit;
	set transaction	use rollback segment	rb1;

--	===================================================================================

	insert into		garland.GIS_App_Rowid

		select	rownum,	rec_rowid
		from	(	select

--	-----------------------------------------------------------------------------------
--	specify order by columns

				MSLINK,

--	-----------------------------------------------------------------------------------
--	specify app table
				rowid		rec_rowid

				from		garland.UTWATVALV		--  <<<<<<<<<<<<<<<<<<<<<<<<<

--	-----------------------------------------------------------------------------------
--	specify filter


				WHERE		VALVE_ID IS NULL

--	-----------------------------------------------------------------------------------
--	specify order by clause

				order by	1				--  <<<<<<<<<<<<<<<<<<<<<<<<<

			);
--	-----------------------------------------------------------------------------------

	commit;
	alter rollback segment	rb1			offline;

--	======================================================================
	select count(*) from garland.GIS_App_Rowid;

	select rpad(segment_name,30) segment_name, segment_type, bytes, extents, tablespace_name 
	from dba_segments
	where	segment_name in
	(	select	index_name
		from		all_indexes
		where		table_name = 'GIS_App_Rowid'	);


	analyze table	garland.GIS_App_Rowid	compute statistics;

--	======================================================================
	set echo		on;

