	set echo	off;
--	=================================================================================
	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\V80_Non_Address.sql;

	select	--+ rule
			distinct			

--			rpad('Non Address',17)		" "
			rpad('Bad Name', 17)		" "


--			,rpad(rec_key,    20)		"record key"
--			,lpad(rec_seq,    08)		" "
--			,rpad(do_alias,   15)		" "	
--			,chr(10)	" "

--			,rpad(ltrim(appl_num),10)	" "
--			,rpad(' ',10)			" "

--			,rpad(appl_num,   05)		" "
			,rpad(appl_pfx,   05)		" "
			,rpad(appl_name,  30)		" "
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "
			,rpad(appl_code1, 05)		" "
			,rpad(appl_unit1, 08)		" "
			,rpad(appl_code2, 05)		" "
			,rpad(appl_unit2, 08)		" "
--			,chr(10)	" "

			,decode (rpad(do_parse,01), '!', do_parse, ' ')		" "

	from		garland.adrResult		r


	where		verify_code < 10

	and not exists
(
	select 'x'
	from garland.adrStreets
	where addr_name = rtrim(r.addr_name)
)


	and	addr_name not like 'FIRE HYDRANT%'
	and	addr_name not like 'FLOATING%'



	order by	rpad(appl_name,30)
	;

	spool	off;
--	=================================================================================




