
	set echo	off;
--	=================================================================================
	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\V03_Non_Comlete.sql;


	select	--+ rule
			distinct			
			rpad('Non Complete',17)		" "

			,rpad(rec_key,    20)		" "
--			,rpad(do_alias,   15)		" "	
--			,lpad(verify_code,02)		" "	
			,chr(10)	" "

			,rpad(appl_num,   10)		" "
			,rpad(appl_pfx,   05)		" "
			,rpad(appl_name,  30)		" "
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "
			,rpad(appl_code1, 05)		" "
			,rpad(appl_unit1, 08)		" "
			,chr(10)	" "

--			,rpad(' ',        10)		" "
--			,rpad(form_pfx,   05)		" "
--			,rpad(form_name,  30)		" "
--			,rpad(form_type,  06)		" "
--			,rpad(form_sfx,   05)		" "
--			,rpad(form_code1, 05)		" "
--			,rpad(form_unit1, 08)		" "
--			,chr(10)	" "

--			,rpad(' ',16)			" "
--			,rpad(addr_num,   10)		" "
--			,rpad(addr_pfx,   05)		" "
--			,rpad(addr_name,  30)		" "
--			,rpad(addr_type,  06)		" "
--			,rpad(addr_sfx,   05)		" "
--			,rpad(addr_code1, 05)		" "
--			,rpad(addr_unit1, 08)		" "

	from		garland.adrResult

	where		verify_code =  3
--	and		nvl(do_alias,' ')	>= 'A'
--	order by	rpad(addr_name,30)
	;



	select 'Possible Completion   ' " ",
		 r.rec_key			"key", 
		 rpad(r.addr_name,20)	"invalid name",
		 rpad(s.addr_name,20)	"valid name" 
	from	adrResult		r,
		adrStreets		s
	where	r.verify_code = 3
	and	s.addr_name like r.addr_name || '%'
	order by 1,2,3;



	spool	off;
--	=================================================================================
