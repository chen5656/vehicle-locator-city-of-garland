	set echo		off;
	set timing		on;
	set fetchrows	111;
	select 'Full UMS Start	' || to_char (sysdate, 'mon dd,yyyy  hh24:mi:ss') " " from dual;

--	=====================================================================================================
--	truncate table	plan_table;
--	explain plan	set statement_id = 'full'	for
--	=====================================================================================================

	select	--+	driving_site (al)	all_rows
				distinct

	' addr =  '  " "
	,ul.house_no " "		,ul.street_pfx_dir " "	
	,rpad(ul.street_nm, 20)				 " " 
	,ul.street_nm_sfx " "	,ul.street_sfx_dir " " 
	,ul.sec_addr_id   " "	,ul.sec_addr_range " "
		,chr(10) " "

	,'date = ' || rpad(to_char(bd.bill_run_dt,'Mon dd,yyyy'),20)	" "
	,to_char (bd.bill_run_dt, 'yyyy-mm-dd')					" "
		,chr(10) " "

	,'type = ' || rpad(st.service_tp, 06)	" "		
	,'cons = ' || rpad(bd.cons_amt,   06)	" "	
	,'code = ' || rpad(bd.detail_cd,  10)	" "	
	,'amount = '  || rpad(bd.detail_amt, 08)	" "	
		,chr(10) " "

	,'acct = '	 || rpad(al.account_no,  06)	" "	
	,'locn = '	 || rpad(al.location_no, 06)	" " 
	,'seqn = '	 || rpad(al.service_seq, 06)	" "	
		,chr(10) " "

	from		 sfg.um00250t@umsrep.world	al		--	account location
		 	,sfg.um00100m@umsrep.world	ul		--	utility location
			,sfg.um00260t@umsrep.world	bh		--	utility bill header
			,sfg.um00261t@umsrep.world	bd		--	utility bill detail
			,sfg.um00140t@umsrep.world	st		--	installed service
	,(
		select	account_no,
				location_no,
				min (service_seq)		service_seq
		from		sfg.um00250t@umsrep.world
		where		service_stat = 'CUTON'
		group by	account_no, location_no
	)							als

--	--------------------------------------------------------
	where		al.account_no	between 1	and 1000
	and		rtrim(st.service_tp) in ( 'EL', 'WTR' )
	and		rownum < 111
--	--------------------------------------------------------

	and		al.account_no	= als.account_no
	and		al.location_no	= als.location_no
	and		al.service_seq	= als.service_seq

	and		al.location_no	= ul.location_no

	and		al.account_no	= bh.account_no

	and		al.location_no	= bd.location_no
	and		al.account_no	= bd.account_no
	and		al.service_seq	= bd.service_seq

	and		al.location_no	= st.location_no
	and		al.service_seq	= st.serv_seq

	and		bh.bill_run_dt	= bd.bill_run_dt
	and		bh.bill_run_tm	= bd.bill_run_tm

	and		ul.street_nm	> 'A'
	and		bh.audit_or_live	= 'L'

--	and		al.cutoff_dt	is null
--	and		st.pull_dt		is null

	order by	rpad(ul.street_nm,20), ul.house_no, 
			to_char(bd.bill_run_dt,'yyyy-mm-dd')
	;

--	=====================================================================================================
-- 	select * from explain_plan;
--	=====================================================================================================

	select 'Full UMS Stop	' || to_char (sysdate, 'mon dd,yyyy  hh24:mi:ss') " " from dual;
	set echo		on;
	set timing		off;
	set fetchrows;
