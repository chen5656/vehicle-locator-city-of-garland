
--	show unique range option for wrong range (verify code = 43) or mixed (42) or poor (41)

	set echo 		off;
	set charwidth	200;

	select decode (verify_code, 43, 'Wrong  ', 42, 'Mixed  ', 41, 'Poor   ', ' ')  "Range",	
		 count(*) "Total"
	from	adrResult
	where	verify_code in (43, 42, 41)
	group by verify_code; 

--	truncate table	plan_table;
--	explain plan	set statement_id = 'aaa'		for

	select	
			   rpad(r.addr_num, 12)|| rpad(r.addr_pfx, 02)|| rpad(r.addr_name,20) 
			|| rpad(r.addr_type,05)|| rpad(r.addr_sfx, 08)
			|| ' key = ' || r.rec_key  || '  seq = ' || r.rec_seq
			|| chr(10) 
			|| rpad(a.addr_lo, 06) || rpad(a.addr_hi,06)	|| rpad(a.addr_pfx, 02) 
			|| rpad(a.addr_name,20)|| rpad(a.addr_type,  05)|| rpad(a.addr_sfx, 02)  
			|| '		code = ' || decode (r.verify_code, 43, 'wrong', 42, 'mixed', 41, 'poor', ' ')
			|| ' range ('|| r.verify_code  || ')'
			|| chr(10)	" "

	from	trvehrcl	a,
(
	select * from adrResult
	where	verify_code in (43, 42, 41)
)				r

	where	r.addr_name	= a.addr_name
	and	r.addr_num	between a.addr_lo	and a.addr_hi
	and	a.branch_no < 9999
	order by rpad(r.addr_name,20), rpad(r.addr_num,06), r.rec_key;


--	select * from explain_plan;



