	set echo	off;
--	=======================================================
--	analyze table	garland.		compute statistics;
--	insert into plan_table (object_name, object_owner) values (upper( ' ' ),	'GARLAND');

--	truncate table	garland.plan_table;
--	=======================================================

--	explain plan	set statement_id = 'a'	into garland.plan_table		for
	select distinct

		bd.account_no,
		bd.location_no,	
		bd.service_seq, 
		'   '			" ",
		bd.bill_run_dt,
		ist.service_tp	"type",
		bd.detail_amt,
		bd.detail_cd,
		rpad(ltrim(rtrim(ut.house_no)),06) || rpad(ut.street_nm,20) || rpad(ut.street_nm_sfx,04) "address"

	from	sfg.um00140t@umsp.world		ist,
		sfg.um00261t@umsp.world		bd,
		sfg.um00100m@umsp.world		ut

	where	ist.location_no	= bd.location_no
	and	ist.serv_seq	= bd.service_seq
	and	ist.location_no	= ut.location_no

	and	ist.service_tp	in ('EL', 'SWRSD')

	and	to_char(bd.bill_run_dt, 'yyyydd') = '200201'	

	and	bd.account_no	in (1095, 1232, 1320, 1332, 1373, 1571)
	;



/*
--	explain plan	set statement_id = 'b'	into garland.plan_table		for

	select distinct
		loc.house_no, loc.street_nm,    loc.street_nm_sfx,
		bc.account_no,bc.bc_detail_amt, bc.bc_detail_rate

	from	sfg.um00100m@umsp.world		loc,
		sfg.um00262t@umsp.world		bc

	where	loc.location_no	= bc.location_no
	and	bc.bill_cd = '26RES'
	and	bc.account_no	between 1001 and 5010 
	;
*/

--	======================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_analyze;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_cost;
--	select * from garland.explain_remote;
--	======================================================================

