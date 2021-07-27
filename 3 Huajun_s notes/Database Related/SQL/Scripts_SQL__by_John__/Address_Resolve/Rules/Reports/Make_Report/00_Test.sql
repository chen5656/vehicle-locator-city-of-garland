	set echo		off;
	set charwidth	300;
--	======================================================================================================
	create or replace view garland.adrResult_Alter_vw	as select * from garland.adrAlter_Part_vw;
--	create or replace view garland.adrResult_Alter_vw	as select * from garland.adrAlter_Full_vw;
--	======================================================================================================

	select	--+ rule
			distinct			
			'Type A    '			" "

			,lpad(verify_code,02)		" "			--	??????????????	
			,rpad(do_alias,   10)		" "	
			,lpad(rec_seq,    08)		" "
			,rpad(rec_key,    20)		" "
			,chr(10)	" "

			,rpad(appl_num,   10)		" "
			,rpad(appl_pfx,   05)		" "
			,rpad(appl_name,  30)		" "
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "
			,rpad(appl_code1, 05)		" "
			,rpad(appl_unit1, 08)		" "
			,chr(10)	" "

			,rpad(addr_num,   10)		" "
			,rpad(form_pfx,   05)		" "
			,rpad(form_name,  30)		" "
			,rpad(form_type,  06)		" "
			,rpad(form_sfx,   05)		" "
			,rpad(form_code1, 05)		" "
			,rpad(form_unit1, 08)		" "
			,chr(10)	" "

			,rpad(addr_num,   10)		" "
			,rpad(addr_pfx,   05)		" "
			,rpad(addr_name,  30)		" "
			,rpad(addr_type,  06)		" "
			,rpad(addr_sfx,   05)		" "
			,rpad(addr_code1, 05)		" "
			,rpad(addr_unit1, 08)		" "
			,chr(10)	" "

	from		garland.adrResult_Alter_vw
	where		do_name = 'A'
	order by	rpad(addr_name,30);

--	=================================================================================

	select	'correction'		"TYPE A"
			,count(*)			"     TOTAL"
	from		garland.adrResult
	where		do_name = 'A';

--	=================================================================================

