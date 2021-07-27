	set echo	off;
--	================================================================================================
--	Show Wrong Street Corrections
--	================================================================================================

	select 
	distinct

	rpad(addr_num,06) ||' '|| rpad(form_pfx,02) ||' '|| rpad(form_name,20) ||' '|| rpad(form_type,04) ||' '|| form_sfx || chr(10) ||
	rpad(addr_num,06) ||' '|| rpad(addr_pfx,02) ||' '|| rpad(addr_name,20) ||' '|| rpad(addr_type,04) ||' '|| addr_sfx 
	||chr(10)	

	"""Wrong Street"" Corrections"

	from	
(	select * from garland.adrResult

	where	do_qual like '%cp%'
	or	do_qual like '%ct%'
	or	do_qual like '%cs%'

	order by	addr_name, addr_num
);

--	================================================================================================
	set echo	on;
