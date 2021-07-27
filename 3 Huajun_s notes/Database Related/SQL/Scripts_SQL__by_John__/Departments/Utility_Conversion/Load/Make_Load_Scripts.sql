	set echo		off;
	set charwidth	100;
--	============================================================================
--	generate Load scripts
--	============================================================================

	select '	insert /*+ append */  into garland.' || table_name ||
		 '  select * from jdeacutis.'			 || table_name || ';'

	" "
	from	 tabs
	where	 table_name like 'UT%'; 


--	============================================================================
	set echo		on;
	set charwidth;

