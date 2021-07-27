	set echo	off;
--	=====================================================================

	select count(*)					-- 3607 / 61358 /  66225
								-- 3141 ("AVE")


	from

(
	select rec_key, 
		 addr_num, addr_pfx, addr_name, addr_type, addr_sfx

	from	garland.adrResult

	where	verify_code = 55

	and 	lower(do_parse) not like '%u%'
	and	lower(do_parse) not like '%v%'  

	and	nvl(do_qual,' ') not like '%r%'
	and	nvl(do_qual,' ') not like '%c%'

--	------------------------------------------------------

--	and	nvl(do_alias,' ')  = ' '

	and (	nvl(do_name, ' ')  in (' ', 'A')
	or	appl_name = addr_name	)

	and	nvl(do_qual, ' ')  = ' '
	and	appl_type	in (' ', addr_type)
	and	appl_pfx	in (' ', addr_pfx)
	and	appl_sfx	in (' ', addr_sfx)

--	------------------------------------------------------

	and	appl_name not like 'AVE %'

--	------------------------------------------------------

	MINUS
	select	rec_key, 
			appl_num, appl_pfx, appl_name, appl_type, appl_sfx
	from		garland.adrResult

)

	;


--	=====================================================================
/*

DO_ALIAS
--------
23   
AVE  
MISC 
NTH  

*/
--	=====================================================================
	set echo	on;

