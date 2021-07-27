	set echo off;

--	display TRVEHRCL streets where st_name differs from street columns


--	select count(*)

	select rpad(mslink,08) "mslink", 
		 st_name, 

		rpad (addr_pfx,  length(addr_pfx)  + 1)	|| 		
		rpad (addr_name, length(addr_name) + 1)	|| 
		rpad (addr_type, length(addr_type) + 1)	|| 
		rpad (addr_sfx,  length(addr_sfx)  + 1)		" "	

--		 ,addr_pfx, addr_name, addr_type, addr_sfx, addr_lo

	from trvehrcl

	where	ltrim(rtrim(st_name)) <>
		ltrim(rtrim(
		rpad (addr_pfx,  length(addr_pfx)  + 1)	|| 		
		rpad (addr_name, length(addr_name) + 1)	|| 
		rpad (addr_type, length(addr_type) + 1)	|| 
		rpad (addr_sfx,  length(addr_sfx)  + 1)	
		))

--	and	rownum < 111
	;

	set echo on;
