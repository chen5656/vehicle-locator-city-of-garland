
--	show unique address option for wrong address (verify code = 53) or mixed (52) or poor (51)

	set echo 		off;
	set charwidth	200;

	select decode (verify_code, 53, 'Wrong  ', 52, 'Mixed  ', 51, 'Poor   ', ' ')  "Address",	
		 count(*) "Total"
	from	garland.adrResult
	where	verify_code in (53, 52, 51)
	group by verify_code; 

--	truncate table	plan_table;
--	explain plan	set statement_id = 'aaa'		for

	select
			   rpad(r.addr_num, 06) || rpad(r.addr_pfx, 02) || rpad(r.addr_name,20) 
			|| rpad(r.addr_type,05) || rpad(r.addr_sfx, 08)
			|| 'key  = ' || r.rec_key  	
--			|| '  seq = ' || r.rec_seq
			|| chr(10) 
			|| rpad(a.addr_num, 06) || rpad(a.addr_pfx, 02) || rpad(a.addr_name,20) 
			|| rpad(a.addr_type,05) || rpad(a.addr_sfx, 08)  
--			|| 'code = ' || decode (r.verify_code, 53, 'wrong', 52, 'mixed', 51, 'poor', ' ')
--			|| ' address (' || r.verify_code  || ')'
			|| chr(10)	" "

	from	garland.cdreladr	a,
(
	select * from garland.adrResult
	where	verify_code in (53, 52, 51)
)				r

	where	r.addr_name	= a.addr_name
	and	r.addr_num	= a.addr_num
	and	(r.addr_name, r.addr_num)	in
(
	select	addr_name, addr_num
			from garland.cdreladr
	group by	addr_name, addr_num
	having	count(*) = 1
)
	order by rpad(r.addr_name,20), rpad(r.addr_num,06), r.rec_key;


--	select * from explain_plan;





