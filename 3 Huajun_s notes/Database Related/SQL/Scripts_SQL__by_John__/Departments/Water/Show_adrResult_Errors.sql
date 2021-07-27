	set echo off;
--	==================================================================================================
	spool  c:\deacutis\report\Water_Errors.txt

	select count(*) non_address	from garland.adrResult_Water	where verify_code = 0;

	select count(*) bad_number	from garland.adrResult_Water	where verify_code between 10 and 49;

	select count(*) incomplete	from garland.adrResult_Water	where verify_code = 54;

	select count(*) wrong		from garland.adrResult_Water	where verify_code = 53;

--	==================================================================================================

	select  'NON ADDRESS' " ",
		lpad(nvl(addr_num,   0),05)		"num", 
		rpad(nvl(addr_pfx, ' '),02)		"pf", 
		rpad(nvl(addr_name,' '),20)		"name",
		rpad(nvl(addr_type,' '),04)		"type",	 
		rpad(nvl(addr_sfx, ' '),02)		"sf"
	from garland.adrResult_Water	where verify_code = 0;

	select  'BAD NUMBER' " ",
		lpad(nvl(addr_num,   0),05)		"num", 
		rpad(nvl(addr_pfx, ' '),02)		"pf", 
		rpad(nvl(addr_name,' '),20)		"name",
		rpad(nvl(addr_type,' '),04)		"type",	 
		rpad(nvl(addr_sfx, ' '),02)		"sf"
	from garland.adrResult_Water	where verify_code between 10 and 49;

	select  'INCOMPLETE' " ",
		lpad(nvl(addr_num,   0),05)		"num", 
		rpad(nvl(addr_pfx, ' '),02)		"pf", 
		rpad(nvl(addr_name,' '),20)		"name",
		rpad(nvl(addr_type,' '),04)		"type",	 
		rpad(nvl(addr_sfx, ' '),02)		"sf"
	from garland.adrResult_Water	where verify_code = 54;


	select  'WRONG' " ",
		lpad(nvl(addr_num,   0),05)		"num", 
		rpad(nvl(addr_pfx, ' '),02)		"pf", 
		rpad(nvl(addr_name,' '),20)		"name",
		rpad(nvl(addr_type,' '),04)		"type",	 
		rpad(nvl(addr_sfx, ' '),02)		"sf"
	from garland.adrResult_Water	where verify_code = 53;

	spool	off;

--	==================================================================================================
	set echo on;
