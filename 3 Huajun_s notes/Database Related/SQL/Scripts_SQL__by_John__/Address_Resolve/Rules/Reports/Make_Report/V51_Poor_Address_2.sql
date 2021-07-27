	set echo off;
--	=====================================================================================================


	select count(*) "POOR ADDR"
	from	 garland.adrResult

	where	 verify_code = 51;


	select distinct  null, 
		'Invalid   ' " ",
		 lpad(a.addr_num,05) " ",
		 rpad(r.form_pfx,02) " ", rpad(r.form_name,20) " ", rpad(r.form_type,04) " ", rpad(r.form_sfx,02) " ", 
		 lpad(r.rec_key, 20) " ",
		 chr(10) " ",
		'Valid     ' " ",
		 lpad(a.addr_num,05) " ",
		 rpad(a.addr_pfx,02) " ", rpad(a.addr_name,20) " ", rpad(a.addr_type,04) " ", rpad(a.addr_sfx,02) " ", 
		 chr(10) " "

	from	 garland.adrResult	r,
		 garland.cdreladr		a

	where	r.addr_name	= a.addr_name
	and	r.addr_num	= a.addr_num

	and	verify_code = 51
--	and	mod(verify_code,10) = 1

--	order by 2,3,1,4;

	order by	 rpad(a.addr_name,20),  lpad(a.addr_num,05)
	;

--	=====================================================================================================
	set echo on;

