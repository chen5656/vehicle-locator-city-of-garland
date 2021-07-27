	set echo	off;
	set timing	on;

--	===================================================================
--	Extract Consumption for Sanitation ('SWRSD')
--	===================================================================

	TRUNCATE table	garland.ums_detail	reuse storage;

--	===================================================================

	variable	serv_type	char(10);
	variable	year_month	char(06);
	variable	from_date	date;
	variable	to_date	date;

	execute	:serv_type	:= 'SWRSD';
	execute	:year_month	:= '200211';	--	<<<==== specify year & month (yyyymm)

	execute	:from_date	:= to_date ('JAN 01 2002', 'MON dd yyyy');	--	<<<==== specify date
	execute	:to_date	:= to_date ('JAN 31 2002', 'MON dd yyyy');	--	<<<==== specify date

--	===================================================================

--	truncate table	garland.plan_table;
--	insert into 	garland.plan_table (object_name,object_owner) values ( 'UM00261T' , '' );

	alter rollback segment	rb1			online;
	commit;
	set transaction use rollback segment	rb1;

--	===================================================================
--	explain plan	set statement_id = 'detail'	into garland.plan_table for

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

			k.asset_size,
			k.asset_no,
			k.parcel_id

	from		sfg.um00261t@umsp.world		d,		--	11.6M records
			garland.ums_keys_sanitation	k

	where		d.location_no	= k.location_no
	and		d.account_no	= k.account_no
	and		d.service_seq	= k.service_seq

	and		d.detail_cd		= :serv_type

	and		to_char(d.bill_run_dt, 'yyyymm') = :year_month;

--	and		d.bill_run_dt	>= :from_date  
--	and		d.bill_run_dt	<= :to_date
	;

--	===================================================================
	commit;
	alter rollback segment rb1 offline;

--	===================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_remote;

--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;

--	select * from garland.explains_indexed;
--	select * from garland.explains_table;
--	select * from garland.explains_index;
--	select * from garland.explains_constraint;
--	select * from garland.explains_column;

--	select * from garland.explain_analyze;
--	select * from garland.explains_analyze;
--	===================================================================

	analyze table garland.ums_detail	compute statistics;

	select * from garland.ums_detail	where rownum < 11;

	select count(*) from garland.ums_detail;

--	===================================================================
	set echo	on;
	set timing	off;

