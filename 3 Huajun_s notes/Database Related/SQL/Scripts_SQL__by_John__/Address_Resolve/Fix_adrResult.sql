	set echo off;
--	==========================================================================================
--	Fix non-address mistakes
--	When addr_name is a valid street name, but is padded w/spaces
--	Fix padded street & Fix Verify Code
--	==========================================================================================

	update garland.adrResult
		set	addr_name	=  nvl(rtrim(addr_name),' ')
		where	addr_name	> ' '
		and	addr_name	<> rtrim(addr_name);

	update garland.adrResult
		set	addr_type	=  nvl(rtrim(addr_type),' ')
		where	addr_type	> ' '
		and	addr_type	<> rtrim(addr_type);

	update garland.adrResult
		set	addr_pfx	=  nvl(rtrim(addr_pfx), ' ')
		where	addr_pfx	> ' '
		and	addr_pfx	<> rtrim(addr_pfx);

	update garland.adrResult
		set	addr_sfx	=  nvl(rtrim(addr_sfx), ' ')
		where	addr_sfx	> ' '
		and	addr_sfx	<> rtrim(addr_sfx);

	commit;

--	==========================================================================================


--	update garland.adrResult_Input	r			--	C H A N G E		<<<<<<<==========
	update garland.adrResult		r

	set	verify_code = 10,
		do_parse	= '.........',
		addr_name   = rtrim(addr_name),
		addr_type	= nvl(rtrim(addr_type),' '),
		addr_pfx	= nvl(rtrim(addr_pfx), ' '),
		addr_sfx	= nvl(rtrim(addr_sfx), ' ')

--	-----------------------------------------------------

	where	verify_code < 10

	and	ltrim(addr_num, '0123456789 ') is null

--	-----------------------------------------------------

	and	exists
(
	select 'x'
	from	garland.adrStreets
	where	addr_name = rtrim(r.addr_name)
);

--	-----------------------------------------------------

--	rollback;
	commit;

--	-----------------------------------------------------
