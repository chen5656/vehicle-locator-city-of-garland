--	=====================================================================
set echo		on;
set linesize	200;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	===========================================================
--	ad hoc query of adrResult 
--	===========================================================

	select	--+ rule
			distinct

			 chr(10)					" "

			,Verify_Code ,do_Alias ,do_Name ,do_Qual ,do_Parse


			,chr(10)				" "
			,rpad(' ',15)			" "
			,lpad(nvl(r.appl_num,0),6)	" "
			,rpad(r.appl_pfx,  2)		" "
			,rpad(r.appl_name, 30)		" "
			,rpad(r.appl_type, 4)		" "	
			,rpad(r.appl_sfx,  2)		" "

			,rpad(r.appl_code1, 5)		" "
			,rpad(r.appl_unit1, 5)		" "

--		----------------------------------------------------

			,chr(10)				" "
			,rpad(' ',15)			" "
			,rpad(nvl(r.form_pfx, ' ') ,2)		" "
			,rpad(nvl(r.form_name, ' '),30)		" "
			,rpad(nvl(r.form_type,' '), 4)		" "
			,rpad(nvl(r.form_sfx, ' '), 2)		" "

			,rpad(nvl(r.form_code1,' '), 5)		"code"
			,rpad(nvl(r.form_unit1,' '), 5)		" "

--		----------------------------------------------------

			,chr(10)				" "
			,rpad(' ',15)			" "
			,lpad(nvl(r.addr_num,0),6)			" "
			,rpad(nvl(r.addr_pfx, ' ') ,2)		" "
			,rpad(nvl(r.addr_name, ' '),30)		" "
			,rpad(nvl(r.addr_type,' '), 4)		" "
			,rpad(nvl(r.addr_sfx, ' '), 2)		" "

			,rpad(nvl(r.addr_code1,' '), 5)		"code"
			,rpad(nvl(r.addr_unit1,' '), 5)		" "

--		----------------------------------------------------

--	from		garland.adrResult			R
	from		garland.adrResult_Input		R

--	==================================================================================

	where		appl_name > '0'		-- dummy

--	and		translate (a.addr_name, '123456789', '000000000') like '%9' 

--	and		length(a.addr_name) - instr (rtrim(replace (a.addr_name, r.old_type)), ' ', -1) 
--			between 2 and 4

--	and		r.do_parse like '%u%'
--	and		r.addr_unit > '0'

--	and		r.do_alias = 'many'

--	and		r.verify_code between 0 and 9

--	==================================================================================

	and	rownum < 111

	order by	5,6,4,7,3;

--	==================================================================================
