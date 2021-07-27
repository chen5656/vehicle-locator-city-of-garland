	set echo	off;
	set timing	off;

	select '*** clean up gis addresses ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	clean up address components in garland.cdreladr & garland.trvehrcl

	update garland.cdreladr
	set	 addr_name = rtrim (replace (addr_name, '(PVT)'))
	where	 instr (addr_name, '(PVT)' ) > 0;

	update garland.cdreladr
	set	 addr_name	= nvl (rtrim (addr_name), ' ')
	where	 addr_name <> nvl (rtrim (addr_name), ' ');

	update garland.cdreladr
	set	 addr_type	= nvl (rtrim (addr_type), ' ')
	where	 addr_type <> nvl (rtrim (addr_type), ' ')
	or	 addr_type	is null;

	update garland.cdreladr
	set	 addr_pfx	= nvl (rtrim (addr_pfx), ' ')
	where	 addr_pfx  <> nvl (rtrim (addr_pfx), ' ')
	or	 addr_pfx	is null;

	update garland.cdreladr
	set	 addr_sfx	= nvl (rtrim (addr_sfx), ' ')
	where	 addr_sfx  <> nvl (rtrim (addr_sfx), ' ')
	or	 addr_sfx	is null;

	commit;


	update garland.trvehrcl
	set	 addr_name	= nvl (rtrim (addr_name), ' ')
	where	 addr_name <> nvl (rtrim (addr_name), ' ');

	update garland.trvehrcl
	set	 addr_type	= nvl (rtrim (addr_type), ' ')
	where	 addr_type <> nvl (rtrim (addr_type), ' ')
	or	 addr_type	is null;

	update garland.trvehrcl
	set	 addr_pfx	= nvl (rtrim (addr_pfx), ' ')
	where	 addr_pfx  <> nvl (rtrim (addr_pfx), ' ')
	or	 addr_pfx	is null;

	update garland.trvehrcl
	set	 addr_sfx	= nvl (rtrim (addr_sfx), ' ')
	where	 addr_sfx  <> nvl (rtrim (addr_sfx), ' ')
	or	 addr_sfx	is null;

	commit;
