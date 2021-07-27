	set echo	off;

--	=================================================================
--	display next input record after last one written to adrResult
--	=================================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

--	=================================================================

	select m.row_seq, l.*
	from	adrResult_Local	l,
(
	select row_seq, row_id
	from	 gis_app_rowid	
	where	 row_seq =
(
	select max(rec_seq) + 1
	from	 adrResult
))					m

	where	l.rowid   = m.row_id;

--	=======================================================

--	select * from explain_plan;

	set echo	on;

--	=======================================================
