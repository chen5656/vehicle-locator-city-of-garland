	set echo off;
--	======================================================================================================

	select '*** load Wrong Street alter ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
	spool	c:\deacutis\scripts\address_resolve\alterations\Wrong_Street.sql;			--	change

	select	rpad(	
			'--   ,'''				||
			rec_key				||
			''''	
			, 30)
					
			|| '  --   '        
			|| lpad(addr_num,05) ||' '|| addr_pfx ||' '|| addr_name ||' '|| addr_type	

			" "
	from		garland.adrResult
	where		verify_code = 53
	;

	spool off;
--	======================================================================================================


