	set echo 	off;
	set termout	off;
--	=================================================

	spool	c:\deacutis\extract\tap_and_pipe.txt

	select
		tap_id		||
		chr(10)		||
		drop_x		||','||
		drop_y		||
		chr(10)		||
		extend_x		||','||
		extend_y		||
		chr(10)		||
		'end'

	" "
	from	garland.Temp_View1

	order by 1;

	spool off;

--	=================================================
	set echo 	on;
	set termout	on;

