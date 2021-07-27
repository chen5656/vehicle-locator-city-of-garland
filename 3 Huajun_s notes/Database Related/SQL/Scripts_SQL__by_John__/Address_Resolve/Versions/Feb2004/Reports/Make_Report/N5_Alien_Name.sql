	set echo	off;
--	=================================================================================
	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\N5_Alien_Name.sql;

	select	--+ rule
			distinct			
			rpad(do_alias,16)			"alien"	

			,rpad(appl_num,   10)		" "
			,rpad(appl_pfx,   05)		" "
			,rpad(appl_name,  30)		"input address"
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "
			,rpad(appl_code1, 05)		"code1"
			,rpad(appl_unit1, 08)		"unit1"
			,chr(10)	" "

/*
			,rpad(' ',15)			" "
--			,rpad(addr_num,   10)		" "
			,rpad(form_pfx,   05)		" "
			,rpad(form_name,  30)		"parsed name"
			,rpad(form_type,  06)		" "
			,rpad(form_sfx,   05)		" "
--			,rpad(form_code1, 05)		"code1"
--			,rpad(form_unit1, 08)		"unit1"
			,chr(10)	" "
*/

			,rpad(' ',		15)		" "
--			,rpad(rec_seq,    15)		"seq"

			,rpad(addr_num,   10)		" "
			,rpad(addr_pfx,   05)		" "
			,rpad(addr_name,  30)		"corrected name"
			,rpad(addr_type,  06)		" "
			,rpad(addr_sfx,   05)		" "
--			,rpad(addr_code1, 05)		"code1"
--			,rpad(addr_unit1, 08)		"unit1"
			,chr(10)	" "

--			,lpad(verify_code,02)		"ver"	
--			,rpad(rec_key,    20)		"key"
--			,chr(10)	" "

	from		garland.adrResult	
	where		do_alias like '1%' 
	and		do_alias like '%/'				-- DEC 2004

--	order by	rpad(do_alias, 16), rpad(addr_name, 30);
	order by	rpad(addr_name,30);


	select	'alien     '		"Correction"
			,count(*)			"     TOTAL"
	from		garland.adrResult

	where		do_alias between '1' and '1zzz'
	and		do_alias like '%/'				-- DEC 2004
	;


	spool	off;
	set fetchrows;

--	=================================================================================

