	set echo	off;
--	=================================================================================
	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\V01_Non_Garland.sql;

	select	--+ rule
			distinct			

			rpad('Non Garland',16)		" "
--			rpad('Bad Street' ,16)		" "


--			,rpad(rec_key,    20)		" "
--			,rpad(rec_seq,    15)		" "	
--			,lpad(verify_code,02)		" "	

			,rpad(do_alias,   15)		" "	
			,rpad(do_name,    01)		" "	
--			,chr(10)	" "


			,rpad(appl_num,   10)		" "
			,rpad(appl_pfx,   05)		" "
			,rpad(appl_name,  30)		" "
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "
			,rpad(appl_code1, 05)		" "
			,rpad(appl_unit1, 08)		" "
			,rpad(appl_code2, 05)		" "
			,rpad(appl_unit2, 08)		" "
--			,chr(10)	" "

--			,rpad(' ',		16)		" "			--	either
--			,rpad(addr_num,   10)		" "
--			,rpad(addr_pfx,   05)		" "
--			,rpad(addr_name,  30)		" "
--			,rpad(addr_type,  06)		" "
--			,rpad(addr_sfx,   05)		" "
--			,rpad(addr_code1, 05)		" "
--			,rpad(addr_unit1, 08)		" "
--			,rpad(addr_code2, 05)		" "
--			,rpad(addr_unit2, 08)		" "
--			,chr(10)	" "


	from		garland.adrResult	
	where		verify_code =  01

--	and		nvl(do_alias,' ')	>= 'A'
--	order by	rpad(addr_name,30)
	;

--	=================================================================================

	select count(*) "TOTAL"
	from	garland.adrResult
	where	verify_code = 01;


	spool off;
--	=================================================================================

