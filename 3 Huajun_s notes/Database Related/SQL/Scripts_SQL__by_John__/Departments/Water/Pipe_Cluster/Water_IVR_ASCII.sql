	set echo	off;
	set termout	off;
--	============================================================

	spool c:\deacutis\extract\water_ivr_pipe.txt

	select cluster_id ||','|| pipe_id	" "
	from garland.water_ivr_PIPE
	order by cluster_id, pipe_id;

	spool off;

--	============================================================
	set termout	on;
