
	set echo	off;
	set timing	off;

--	GENERATE SCRIPTS

--	================================================================================
--	Specify the correct Tablespaces for tables and indexes

--	Specify what "append name" should be temporarily prefixed to the name of the new table (eg. NEW_)
--		Any prefix name will do, as long as the result does not duplicate an existing table name 
--	================================================================================

--	================================================================================

	update tmp_view set name_append = 'NEW_', tablespace_ = 'GIS_DATA'		
	where key_ = 'TABLE SPECS';	
	commit;

	@c:\deacutis\scripts\ora_create\1_TABLES.sql;

--	================================================================================

	update tmp_view set name_append = null, tablespace_ = 'GISINDX'			
	where key_ = 'TABLE SPECS';	
	commit;

	@c:\deacutis\scripts\ora_create\2_INDEXES.sql;

--	================================================================================

	update tmp_view set name_append = null, tablespace_ = 'GIS_DATA'	
	where key_ = 'TABLE SPECS';	
	commit;

	@c:\deacutis\scripts\ora_create\3_DROPS.sql;

--	================================================================================

	update tmp_view set name_append = 'NEW_',	tablespace_ = 'GIS_DATA'	
	where key_ = 'TABLE SPECS';	
	commit;

	@c:\deacutis\scripts\ora_create\4_RENAMES.sql;

--	================================================================================
	set echo off;

	spool c:\deacutis\scripts\ora_create\Script_Analyze.sql;

	select 'analyze table ' || schema_ ||'.'|| key_ || '   compute statistics;'		" "
	from	tmp_view
	where	tablespace_ = '=table=';

	spool off;

--	================================================================================
	set echo off;

	spool c:\deacutis\scripts\ora_create\Script_Recompile.sql;

	select 'alter ' || object_type || ' ' || owner ||'.'|| object_name || ' compile;'		" "
	from	dba_objects
	where	status = 'INVALID'
	and	object_type <> 'PACKAGE BODY'; 

	spool off;

--	================================================================================

	

