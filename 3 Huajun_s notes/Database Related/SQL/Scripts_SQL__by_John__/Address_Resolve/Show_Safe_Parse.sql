
--	select count(*)	from	(


	select 
		distinct

--		do_parse,

		 null,
--		 rpad(ltrim(appl_num),05),   
		 rpad(appl_pfx,02),   rpad(appl_name,20), rpad(appl_type,04), rpad(appl_sfx,02), 
		 rpad(appl_unit1,10), rpad(appl_unit2,10), chr(10),


--		 rpad(ltrim(addr_num),05),   
		 rpad(addr_pfx,02),   rpad(addr_name,20), rpad(addr_type,04), rpad(addr_sfx,02), 
		 rpad(addr_unit1,10), rpad(addr_unit2,10), chr(10)

	from
(
	select * from adrResult
	where	do_parse > '.........'

	and	substr (do_parse,5) < '.....                   '
	and	do_parse not between '0' and '9999'

	and	verify_code >= 10

--	and	addr_name <> appl_name
	and	nvl(do_name,' ') < 'C'


--	and	nvl(lower(do_alias),' ') not like '%pull%'

	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_num
)



--	where	rownum < 111

;  
