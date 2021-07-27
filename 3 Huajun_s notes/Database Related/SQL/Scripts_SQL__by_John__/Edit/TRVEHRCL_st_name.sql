
--	populate st_name field according to address fields


	update trvehrcl
	set	st_name = 
		rpad (addr_pfx,  length(addr_pfx)  + 1)	|| 		
		rpad (addr_name, length(addr_name) + 1)	|| 
		rpad (addr_type, length(addr_type) + 1)	|| 
		rpad (addr_sfx,  length(addr_sfx)  + 1)	

	where	nvl(st_name,' ') < '1'

	;

	rollback;
	commit;

