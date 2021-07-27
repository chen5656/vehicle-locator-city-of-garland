--	=====================================================================
	select * from viewer.me;
	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('', '', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	
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

				MSLINK,					--  <<<<<<<<<<<<<<<<<<<<<<<<<

--	-----------------------------------------------------------------------------------
--	specify app table
				rowid		rec_rowid

				from		garland.UTWATVALV			--  <<<<<<<<<<<<<<<<<<<<<<<<<

--	-----------------------------------------------------------------------------------
--	specify filter


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
