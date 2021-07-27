	set echo	off;
--	=====================================================

	select
		chr(10)			" ",
		rpad(appl_pfx,  02)	pf,
		rpad(appl_name, 20)	name,
		rpad(appl_type, 04)	type,
		rpad(appl_sfx,  02)	sf,

		chr(10)			" ",
		rpad(form_pfx,  02)	pf,
		rpad(form_name, 20)	name,
		rpad(form_type, 04)	type,
		rpad(form_sfx,  02)	sf,

		chr(10)			" ",
		rpad(addr_pfx,  02)	pf,
		rpad(addr_name, 20)	name,
		rpad(addr_type, 04)	type,
		rpad(addr_sfx,  02)	sf,
		
	' '					" "
	from		garland.adrResult
--	from		garland.adrResult_Input

	where		rownum < 1111

	and		mod(verify_code,10) = 4

	order by	rpad(addr_name,20);


--	=====================================================
	set echo	on;
