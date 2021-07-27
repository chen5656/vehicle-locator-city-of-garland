	set echo	off;
	set timing	on;
--	===================================================================

	variable	serv_type		varchar2(5);
	variable	from_date		date;
	variable	to_date		date;

	execute	:serv_type	:= 'WTR';	
	execute	:from_date	:= to_date ('APR 01 2003', 'MON dd,yyyy');
	execute	:to_date	:= to_date ('DEC 31 2003', 'MON dd,yyyy');

	TRUNCATE table	garland.ums_detail	reuse storage;

--	=======================================================
--	For Electric & Water & Sanitation  ('EL', 'WTR', 'SWRSD')
--	These contain non-zero consumption amounts
--	=======================================================

	alter rollback segment	rb1			online;
	commit;
	set transaction use rollback segment	rb1;

--	=======================================================
--	truncate table	garland.plan_table;
--	explain plan	set statement_id = 'detail'	into garland.plan_table	for

	insert --+	append
	into		garland.ums_detail

	select
--			count(*)

			d.location_no,
			d.account_no,
			d.service_seq,
			rtrim (k.service_type),

			d.bill_run_dt,
			d.cons_amt,
			d.detail_amt,
			'', '', 				--	asset, asset no
			k.parcel_id

	from		sfg.um00261t@umsrep.world		d,	--	11.6M records
			garland.ums_keys			k

	where		d.location_no	= k.location_no
	and		d.account_no	= k.account_no
	and		d.service_seq	= k.service_seq

	and		k.service_type	= :serv_type

	and		d.bill_run_dt	between :from_date and :to_date
--	and		to_char(d.bill_run_dt, 'yyyymm') = '200303'

	and		d.cons_amt > 0

--	and		d.location_no	between 1 and 5000					--	TEST
	;

	commit;
	alter rollback segment	rb1		offline;

--	=======================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_remote;

--	select * from garland.explain_analyze;
--	select * from garland.explains_analyze;

--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;

--	select * from garland.explains_indexed;
--	select * from garland.explains_constraint;
--	select * from garland.explains_table;
--	select * from garland.explains_index;
--	=======================================================

	analyze table garland.ums_detail	compute statistics;

	select * from garland.ums_detail	where rownum < 11;

	select count(*) from garland.ums_detail;

--	=======================================================

	set echo	on;
	set timing	off;
