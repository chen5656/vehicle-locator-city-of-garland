	set echo off;

--	=====================================================================================
--	verify Alias corrections involving street qualifiers
--	=====================================================================================

	select distinct
		rpad(form_pfx,05), rpad(form_name,20), rpad(form_type,05), rpad(form_sfx,05),
		'///   ', 
		rpad(addr_pfx,05), rpad(addr_name,20), rpad(addr_type,05), rpad(addr_sfx,05)
	from adrResult 
	where do_alias = ' '

	and ( form_type	<> addr_type
	or	form_pfx	<> addr_pfx
	or	form_sfx	<> addr_sfx	)
	;

	set echo on;
