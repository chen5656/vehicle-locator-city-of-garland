	set echo	off;
--	=================================================================================
	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\V02_Non_Garland.sql;

	select	--+ rule
			distinct			
			rpad('Non Correct',16)		"bad name"

			,rpad(appl_num,   10)		" "
			,rpad(appl_pfx,   05)		" "
			,rpad(appl_name,  30)		"input address"
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "
			,rpad(appl_code1, 05)		"code1"
			,rpad(appl_unit1, 08)		"unit1"
			,chr(10)	" "

			,rpad(' ',		15)		" "
--			,rpad(rec_seq,    15)		"seq"

			,rpad(' ',        10)		" "
			,rpad(form_pfx,   05)		" "
			,rpad(form_name,  30)		"parsed name"
			,rpad(form_type,  06)		" "
			,rpad(form_sfx,   05)		" "
			,rpad(form_code1, 05)		"code1"
			,rpad(form_unit1, 08)		"unit1"
			,chr(10)	" "

--			,rpad(' ',15)			" "
			,rpad(do_alias,   15)		"alias"	
			,rpad(addr_num,   10)		" "
			,rpad(addr_pfx,   05)		" "
			,rpad(addr_name,  30)		"corrected name"
			,rpad(addr_type,  06)		" "
			,rpad(addr_sfx,   05)		" "
			,rpad(addr_code1, 05)		"code1"
			,rpad(addr_unit1, 08)		"unit1"
			,chr(10)	" "

--			,lpad(rec_seq,    08)		"seq"
--			,lpad(verify_code,02)		"ver"	
--			,rpad(rec_key,    20)		"key"
--			,chr(10)	" "

	from		garland.adrResult
	where		verify_code =  2
	and		nvl(do_alias,' ')	>= 'A'
	order by	rpad(addr_name,30);


	select	'Non Correct'		"Bad Name"
			,count(*)			"     TOTAL"
	from		garland.adrResult
	where		verify_code = 2;


	spool	off;
--	=================================================================================

