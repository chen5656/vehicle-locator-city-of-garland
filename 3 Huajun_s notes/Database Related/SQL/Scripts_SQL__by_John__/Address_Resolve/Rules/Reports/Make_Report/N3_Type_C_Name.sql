	set echo		off;
	set termout		on;
--	=================================================================================
	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\N3_Type_C_Name.sql;

	select	--+ rule
			distinct			
			rpad('Type C',12)			"correction"


--			,rpad(appl_num,   06)		" "
			,rpad(appl_pfx,   02)		" "
			,rpad(appl_name,  30)		"input address"
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "
			,rpad(appl_code1, 05)		"code1"
			,rpad(appl_unit1, 08)		"unit1"
			,chr(10)	" "
			,rpad(' ',11)			" "


--			,rpad(addr_num,   06)		" "
--			,rpad(form_pfx,   02)		" "
--			,rpad(nvl(form_name,appl_name),30)		"parsed name"
--			,rpad(form_type,  06)		" "
--			,rpad(form_sfx,   05)		" "
--			,rpad(form_code1, 05)		"code1"
--			,rpad(form_unit1, 08)		"unit1"
--			,chr(10)	" "
--			,rpad(' ',11)			" "

--			,rpad(addr_num,   06)		" "
			,rpad(addr_pfx,   02)		" "
			,rpad(addr_name,  30)		"corrected name"
			,rpad(addr_type,  06)		" "
			,rpad(addr_sfx,   05)		" "
--			,rpad(addr_code1, 05)		"code1"
--			,rpad(addr_unit1, 08)		"unit1"
			,chr(10)	" "

--			,lpad(rec_seq,    08)		"seq"
--			,lpad(verify_code,02)		"ver"	
--			,rpad(do_alias,   09)		"alias"	
--			,rpad(rec_key,    20)		"key"
--			,chr(10)	" "

			,decode ( rpad(do_parse,01), '!', do_parse, ' ')	"parse failed"


	from		garland.adrResult
	where		do_name = 'C'
	order by	rpad(addr_name,30);


	select	'correction'		"TYPE C"
			,count(*)			"     TOTAL"
	from		garland.adrResult
	where		do_name = 'C';


	spool	off;
--	=================================================================================
