--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
-- set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	=========================================================================================================

--	build app Rowid reference table (to enhance mass update processing)

	select '*** build App RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	=========================================================================================================

	Truncate table	garland.GIS_App_Rowid		reuse storage;

--	--------------------------------------------------------
--	explain plan  set statement_id = 'xxx'   for

	insert into		garland.GIS_App_Rowid
	select	rownum,
			rec_rowid
	from	
(
	select
		account,
		rowid			rec_rowid
	from		garland.GDS_Account
	order by	1
);

--	--------------------------------------------------------

	commit;

--	======================================================================

	select count(*) from garland.GIS_App_Rowid;

--	select rpad(segment_name,30) segment_name, segment_type, bytes, extents, tablespace_name 
--	from   user_segments
--	where	 segment_name in
--	(
--		select	index_name
--		from		all_indexes
--		where		table_name = 'GIS_APP_ROWID'
--	);

--	======================================================================

	select 'analyze input' " " from dual;

	analyze table	garland.GIS_App_Rowid	compute statistics;

--	======================================================================

