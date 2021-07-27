
--	===============================================	
--	set options

--	OPTION TABLE

	type	options_table  is table of  number
		index by	binary_integer;

	options	options_table;


	for x in 1..max_options					loop
		options (x) := 1;
	end loop;

	while	addr_audit like '/%'
	and	ndx < max_options					loop
		addr_audit := ltrim (addr_audit, '/');
		while ndx < max_options				loop
			ndx  := ndx + 01;
			trim := ndx ||' ';
			if	addr_audit like  trim || '%'	then
				addr_audit    := ltrim (addr_audit, trim);
				options (ndx) := 0;
				exit;
			end if;
		end loop;
	end loop;
