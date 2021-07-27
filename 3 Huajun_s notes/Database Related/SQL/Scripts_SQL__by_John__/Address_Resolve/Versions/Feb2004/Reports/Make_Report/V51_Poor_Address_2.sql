	set echo off;
--	=====================================================================================================


	select count(*) "POOR ADDR"
	from	 garland.adrResult
	where	 verify_code = 51;


	select distinct  null, 
		'Invalid   ' " ",
		 rpad(r.form_pfx,02) " ", rpad(r.form_name,20) " ", rpad(r.form_type,04) " ", rpad(r.form_sfx,02) " ", 
		 chr(10) " ",
		'Valid     ' " ",
		 rpad(a.addr_pfx,02) " ", rpad(a.addr_name,20) " ", rpad(a.addr_type,04) " ", rpad(a.addr_sfx,02) " ", 
		 chr(10) " "

	from	 garland.adrResult	r,
		 garland.cdreladr		a

	where	 verify_code = 51
	and	r.addr_name	= a.addr_name
	and	r.addr_num	= a.addr_num

	order by 2,3,1,4;


--	=====================================================================================================
	set echo on;

