	set echo	off;
	set timing	off;
--	==========================================================================
--	copy adrResult into adrResult_Input
--	define adrResult_Local as adrResult_Input
--	==========================================================================

	select '*** Put Output into Input ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

	truncate table	garland.adrResult_Input	reuse storage;

--	alter rollback segment rb1	online;
--	commit;
--	set transaction use rollback segment rb1;

	insert /*+ append */	into garland.adrResult_Input	
	select *			from garland.adrResult;

	commit;
--	alter rollback segment rb1	offline;

	analyze table	garland.adrResult_Input		compute statistics;

--	==========================================================================
	
--	create or replace view	garland.adrResult_Local			-- dec 2004
--		as select * from	garland.adrResult_Input;	

	@c:\deacutis\scripts\address_resolve\12_app_rowid.sql;

--	==========================================================================
--	EXECUTE the SQL command generated from the following script

	select 'comment on table adrResult_Input  is ''' || comments
		 || 	'''; --	<<<<=====	EXECUTE'		" "
	from	 user_tab_comments
	where	 table_name = 'GIS_VERIFY_ADDR';	

--	==========================================================================
	set echo on;
