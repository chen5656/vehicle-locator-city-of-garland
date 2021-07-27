	set echo	off;
--	=================================================================================

	select	--+ rule
			distinct			

			 lpad(verify_code,02)		"ver"	
			,lpad(rec_seq,    05)		"seq"
			,rpad(do_alias,	06)		"alias"	
			,rpad(do_name,	01)		"name"	
			,rpad(do_qual,	12)		"qual"	
--			,rpad(rec_key,    20)		"key"
			,chr(10)	" "

			,rpad(' ',15)			" "
			,rpad(appl_num,   10)		" "
			,rpad(appl_pfx,   05)		" "
			,rpad(appl_name,  30)		"input address"
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "
--			,rpad(appl_code1, 05)		"code1"
--			,rpad(appl_unit1, 08)		"unit1"
			,chr(10)	" "

/*
			,rpad(' ',15)			" "
			,rpad(addr_num,   10)		" "
			,rpad(form_pfx,   05)		" "
			,rpad(form_name,  30)		"parsed name"
			,rpad(form_type,  06)		" "
			,rpad(form_sfx,   05)		" "
			,rpad(form_code1, 05)		"code1"
			,rpad(form_unit1, 08)		"unit1"
			,chr(10)	" "
*/
			,rpad(' ',		15)		" "
			,rpad(addr_num,   10)		" "
			,rpad(addr_pfx,   05)		" "
			,rpad(addr_name,  30)		"corrected name"
			,rpad(addr_type,  06)		" "
			,rpad(addr_sfx,   05)		" "
			,rpad(addr_code1, 05)		"code1"
			,rpad(addr_unit1, 08)		"unit1"

--			,chr(10)	" "

	from		garland.adrResult

	where		verify_code < 55

	and		verify_code	<> 15

	or		mod(verify_code,10) < 05

	order by	lpad(verify_code,02), rpad(addr_name,30);


--	spool	off;
	set fetchrows;
--	=================================================================================


