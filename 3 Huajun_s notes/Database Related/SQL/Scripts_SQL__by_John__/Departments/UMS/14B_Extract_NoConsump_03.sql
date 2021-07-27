	set echo	off;
	set timing	off;
--	=======================================================

	TRUNCATE table	garland.ums_detail	reuse storage;

--	=======================================================
--	For Sewer & Storm Water ('SWR', 'STM')
--	These contain zero consumption amounts
--	=======================================================

	alter rollback segment	rb1			online;
	commit;
	set transaction use rollback segment	rb1;

--	=======================================================
--	truncate table	plan_table;
--	explain plan	set statement_id = 'detail'		for

	insert	--+ append		hash_sj
	into		garland.ums_detail

--	select	count(*)

	select	--+	index (s)	first_rows
			distinct

			s.location_no,
			0,
			s.serv_seq,
			rtrim(s.service_tp),

			to_date ('jan 01,2001','mon dd,yyyy'),
			0

	from		sfg.um00140T@umsrep.world		s

	where		s.service_tp = 'STM  ' 		--	<<======  fixed length = 05

	and exists
(
	select	'x'
	from		sfg.um00261t@umsrep.world	

	where		location_no	= s.location_no
	and		service_seq	= s.serv_seq

	and		to_char (bill_run_dt, 'yyyy') = '2001'	

--	and		bill_run_dt	between to_date ('jan 01 2001', 'mon dd,yyyy')
--					and	  to_date ('dec 31 2001', 'mon dd,yyyy')

)

--	and		s.location_no	between 1 	and 15000			--	TEST
;

--	=======================================================
	commit;
	alter rollback segment	rb1		offline;

--	=======================================================
--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;
--	=======================================================

--	analyze table	ums_detail			estimate statistics;

--	select * from	garland.ums_detail	where rownum < 11;

--	select count(*) from garland.ums_detail;

--	=======================================================

	set echo	on;
	set timing	off;
