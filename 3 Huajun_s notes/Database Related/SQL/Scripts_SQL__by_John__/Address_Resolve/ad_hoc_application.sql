--	display application record at specified row sequence

--	truncate table	plan_table;
--	explain plan set statement_id = 'aaa'	for

--	=====================================================

	select	r.* 

	from		garland.adrResult			r

	where	r.rec_seq	in ( 8390 )

	;

--	=====================================================

--	select * from explain_plan;

