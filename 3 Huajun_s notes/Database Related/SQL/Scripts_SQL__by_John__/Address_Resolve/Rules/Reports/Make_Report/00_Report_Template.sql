	set echo		off;
	set charwidth	300;
--	======================================================================================================
--	create or replace view garland.adrResult_Alter_vw	as select * from garland.adrAlter_Part_vw;
	create or replace view garland.adrResult_Alter_vw	as select * from garland.adrAlter_Main_vw;
--	create or replace view garland.adrResult_Alter_vw	as select * from garland.adrAlter_Full_vw;
--	======================================================================================================

	select	--+ rule
			distinct			

			rpad(	'STREET'	,10)		" "			--	CHANGE

			,lpad(verify_code,02)		" "		
			,rpad(do_parse,   14)		" "	
			,rpad(do_alias,   06)		" "	
			,rpad(do_name,    01)		" "	
			,rpad(do_qual,    16)		" "	
			,lpad(rec_seq,    08)		" "
			,    (rec_key)			" "
			,chr(10)	" "

			,rpad(appl_num,   10)		" "
			,rpad(appl_pfx,   05)		" "
			,rpad(appl_name,  30)		" "
			,rpad(appl_type,  06)		" "
			,rpad(appl_sfx,   05)		" "
			,rpad(appl_code1, 05)		" "
			,rpad(appl_unit1, 08)		" "
			,chr(10)	" "

--			,rpad(' ',   	10)		" "
			,rpad(addr_num,   10)		" "

			,rpad(form_pfx,   05)		" "
			,rpad(form_name,  30)		" "
			,rpad(form_type,  06)		" "
			,rpad(form_sfx,   05)		" "
			,rpad(form_code1, 05)		" "
			,rpad(form_unit1, 08)		" "
			,chr(10)	" "

--			,rpad(' ',   	10)		" "
			,rpad(addr_num,   10)		" "

			,rpad(addr_pfx,   05)		" "
			,rpad(addr_name,  30)		" "
			,rpad(addr_type,  06)		" "
			,rpad(addr_sfx,   05)		" "
			,rpad(addr_code1, 05)		" "
			,rpad(addr_unit1, 08)		" "
			,chr(10)	" "

	from		garland.adrResult_Alter_vw
	where		spec_verify is not null

--	------------------------------------------------------

--	and		spec_verify in ( 0 )
	and		mod(spec_verify,10) = 4 
--	and		spec_verify 	between 0	and 0


--	and		spec_name	in ( 'C' )

--	and		spec_alias	in ( '23' )
--	and		spec_alias	> '0'

--	and	(	spec_qual		like '%r%'
--	OR		spec_qual		like '%c%'
--		)

	and	(	spec_parse		like '%%'
	or		spec_parse		like '%%'
		)

--	------------------------------------------------------

	order by	rpad(addr_name,30);

--	=================================================================================
--	=================================================================================
