	set echo off;

	update garland.Temp_View
	set
		addr_name	= nvl(rtrim(addr_name),' '),
		addr_type	= nvl(rtrim(addr_type),' '),
		addr_pfx	= nvl(rtrim(addr_pfx), ' '),
		addr_sfx	= nvl(rtrim(addr_sfx), ' '),
		addr_num	= ltrim(addr_num,'0');
	commit;


	update garland.adrResult
	set
		addr_name	= nvl(rtrim(addr_name),' '),
		addr_type	= nvl(rtrim(addr_type),' '),
		addr_pfx	= nvl(rtrim(addr_pfx), ' '),
		addr_sfx	= nvl(rtrim(addr_sfx), ' '),
		addr_num	= nvl(ltrim(addr_num,'0'),'0');
	commit;

	set echo on;
