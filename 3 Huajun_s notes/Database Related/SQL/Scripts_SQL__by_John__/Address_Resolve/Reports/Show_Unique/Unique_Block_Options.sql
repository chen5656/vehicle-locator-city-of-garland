
--	show unique block option for wrong block (verify code = 33) or mixed (32) or poor (31)

	set echo 		off;
	set charwidth	200;

	select decode (verify_code, 33, 'Wrong  ', 32, 'Mixed  ', 31, 'Poor   ', ' ')  "Block",	
		 count(*) "Total"
	from	adrResult
	where	verify_code in (33, 32, 31)
	group by verify_code; 

--	truncate table	plan_table;
--	explain plan	set statement_id = 'aaa'		for

	select	
			   rpad(r.addr_num, 06) || rpad(r.addr_pfx, 02)	|| rpad(r.addr_name,20) 
			|| rpad(r.addr_type,05) || rpad(r.addr_sfx, 08)
			|| ' key = ' || r.rec_key  || '  seq = ' || r.rec_seq
			|| chr(10) 
			|| rpad(a.addr_block, 06) || rpad(a.addr_pfx, 02) || rpad(a.addr_name,20) 
			|| rpad(a.addr_type,  05) || rpad(a.addr_sfx, 02)  
			|| '		code = ' || decode (r.verify_code, 33, 'wrong', 32, 'mixed', 31, 'poor', ' ')
			|| ' block ('|| r.verify_code  || ')'
			|| chr(10)	" "

	from	adrBlock	a,
(
	select * from adrResult
	where	verify_code in (33, 32, 31)
)				r

	where	r.addr_name	= a.addr_name
	and	r.addr_num	between a.addr_block and a.addr_block + 99
	order by rpad(r.addr_name,20), rpad(r.addr_num,06), r.rec_key;


--	select * from explain_plan;


