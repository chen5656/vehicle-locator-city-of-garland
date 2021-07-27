	set echo off;
	set charwidth	200;
--	================================================================================
--	alter new utility tables:    add asbuilt_date  column
--	================================================================================

	alter session set nls_date_format = 'yyyy-mm-dd';
	
--	--------------------------------------------------
	spool	c:\deacutis\scripts\execute.sql
	spool off
	spool	c:\deacutis\scripts\execute.sql
--	--------------------------------------------------

	select '	alter rollback segment  rb1   online;'			" " from dual
	union all
	select '	commit;'								" " from dual
	union all
	select '	set transaction use rollback segment rb1;' ||chr(10)	" " from dual
	union all


	select '	update  garland.' || new_table || ' n  set ' || column_name || ' = ' ||chr(10)||
		 '	(select ' || column_name || ' from ' || old_table || ' o where o.mslink = n.mslink);' ||chr(10)	
	" "
	from	 garland.temp_view1


--	union all
--	select '	rollback;'							  " " from dual

	union all
	select '	commit;'							  " " from dual
	union all
	select '	alter rollback segment  rb1   offline;' ||chr(10) " " from dual

--	--------------------------------------------------
	;
--	--------------------------------------------------

	spool off

--	--------------------------------------------------
	@c:\deacutis\scripts\execute.sql;	
--	--------------------------------------------------

--	================================================================================
	set echo on;
	set charwidth;




