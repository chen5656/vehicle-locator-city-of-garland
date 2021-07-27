	set echo	off;
--	===========================================================================
--	display overlapping address ranges on TRVEHRCL
--	optionally, filter for equal address ranges
--	===========================================================================

	select 'Overlapping Address Ranges' " " from dual;
--	select 'Equal  Address Ranges'	" " from dual;
--	select 'Differ Address Ranges'	" " from dual;

	select rpad (' ', 70, ' ')		" " from dual;
--	===========================================================================

--	truncate table	garland.plan_table		reuse storage;;
--	explain plan	set statement_id = 'aaa'	for

	select
		lpad(r.addr_lo,6) "    lo",  lpad(r.addr_hi,5) "   hi",
		r.addr_pfx " ",  rpad(r.addr_name,30) "street",  r.addr_type " ",  r.addr_sfx " ",  
		rpad(r.mslink,8) "mslink", 
		lpad(r.branch_no,4) "  br", lpad(r.section_no,2) "sc", 
		lpad(r.addr_left_from,6) "  left",  lpad(r.addr_left_to,5) "   ",
		lpad(r.addr_rght_from,6) " right",  lpad(r.addr_rght_to,5) "   ",

		chr(10) " ",	

		lpad(rr.addr_lo,5) " ", lpad(rr.addr_hi,5) " ",	
		rr.addr_pfx " ", rpad(rr.addr_name,30) " ",	   rr.addr_type " ", rr.addr_sfx " ", 
		rpad(rr.mslink,8) " ", 
		lpad(rr.branch_no,4) " ", lpad(rr.section_no,2) " ", 
		lpad(rr.addr_left_from,6) "  left",  lpad(rr.addr_left_to,5) "   ",
		lpad(rr.addr_rght_from,6) " right",  lpad(rr.addr_rght_to,5) "   ",
		chr(10) " "	

	from	garland.trvehrcl	r,
		garland.trvehrcl	rr
	
	where	r.addr_name	= rr.addr_name
	and	r.addr_type	= rr.addr_type
	and	r.addr_pfx	= rr.addr_pfx
	and	r.addr_sfx	= rr.addr_sfx

	and	r.addr_lo	<= rr.addr_lo
	and	r.addr_hi	between rr.addr_lo and rr.addr_hi

	and(( r.addr_lo	<> rr.addr_lo
	or	r.addr_hi	<> rr.addr_hi )
	or	r.mslink	<  rr.mslink  )

	and	r.branch_no	 <  9999
	and	r.section_no <  9999
	and	r.addr_lo	 <> 9999
	and	r.addr_hi	 <> 9999

--	===================================================

--	and	r.addr_lo	= rr.addr_lo			--	filter for equal ranges
--	and	r.addr_hi	= rr.addr_hi

--	and (	r.addr_lo	<> rr.addr_lo			--	filter for different ranges
--	or	r.addr_hi	<> rr.addr_hi  )

--	===================================================
	
	order by  r.addr_name, r.addr_type, r.addr_pfx, r.addr_sfx, r.addr_lo;

--	===========================================================================
--	select * from explain_plan;
--	===========================================================================
	set echo	on;

