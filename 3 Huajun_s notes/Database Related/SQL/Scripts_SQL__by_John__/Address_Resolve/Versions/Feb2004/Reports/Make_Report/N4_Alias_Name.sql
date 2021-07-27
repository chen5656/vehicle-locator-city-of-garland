	set echo	off;
--	=================================================================================
	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\N4_Alias_Name.sql;

	select	--+ rule
			distinct			

			rpad(do_alias,	16)		"alias"	

/*
--			,rpad(appl_num,   10)		" "
			,rpad(appl_pfx,   05)		" "
			,rpad(appl_name,  30)		"input address"
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "
			,rpad(appl_code1, 05)		"code1"
			,rpad(appl_unit1, 08)		"unit1"
			,chr(10)	" "
			,rpad(' ',15)			" "
*/

--			,rpad(addr_num,   10)		" "
			,rpad(nvl(form_pfx, appl_pfx),	05)		" "
			,rpad(nvl(form_name,appl_name),	30)		"parsed name"
			,rpad(nvl(form_type,appl_type),	06)		" "
			,rpad(nvl(form_sfx, appl_sfx),	05)		" "
--			,rpad(form_code1, 			05)		"code1"
--			,rpad(form_unit1,				08)		"unit1"
			,chr(10)	" "

			,rpad(' ',		15)		" "
--			,rpad(rec_seq,    15)		"seq"

--			,rpad(addr_num,   10)		" "
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
	where		do_alias > ' '
	and		do_alias not in  ('-', 'many')
	and		do_alias not like '%/'				-- dec 2004
--	and		do_alias not like '1%'				-- dec 2004

	order by	rpad(do_alias, 16), rpad(addr_name,30);
--	order by	rpad(addr_name,30);


	select	'Alias     '		"Correction"
			,count(*)			"     TOTAL"
	from		garland.adrResult
	where		do_alias > ' '
	and		do_alias not in  ('-', 'many');

	select	'Alias     '		"Pseudo"
			,count(*)			"     TOTAL"
	from		garland.adrResult
	where		do_alias > ' '
	and		do_alias = '-';

	select	'Alias     '		"Many"
			,count(*)			"     TOTAL"
	from		garland.adrResult
	where		do_alias > ' '
	and		do_alias = 'many';

	spool	off;
	set fetchrows;
--	=================================================================================

