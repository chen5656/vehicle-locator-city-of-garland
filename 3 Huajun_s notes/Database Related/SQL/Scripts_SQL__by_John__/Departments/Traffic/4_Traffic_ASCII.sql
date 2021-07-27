	set echo	off;
	set termout	off;
--	=================================================================================

	spool	c:\deacutis\extract\street_sign.txt

--	spool	c:\deacutis\extract\workorder_streetname.txt

--	=================================================================================

	select
		key			||','||
		intersects		||','||

		addr1_pfx		||','||
		addr1_name		||','||
		addr1_type		||','||
		addr1_sfx		||','||
		addr2_pfx		||','||
		addr2_name		||','||
		addr2_type		||','||
		addr2_sfx		||','

	" "
	from	garland.temp_view;

	spool	off;

--	=================================================================================
	set echo	on;
	set termout	on;

