	set echo off;
--	=================================================================================================

	select

	null,
	rpad(a.addr_num,05) " ", rpad(a.addr_pfx,02) " ", rpad(a.addr_name,20) " ", rpad(a.addr_type,04) " ", rpad(a.addr_sfx,02) " ", 
	chr(10) " ",
	rpad(b.addr_num,05) " ", rpad(b.addr_pfx,02) " ", rpad(b.addr_name,20) " ", rpad(b.addr_type,04) " ", rpad(b.addr_sfx,02) " ", 
	chr(10) " "

	from	garland.cdreladr	a,
		garland.cdreladr	b

	where	a.addr_name	 = b.addr_name

	and	a.addr_num	 = b.addr_num


	and (	a.addr_type <> b.addr_type
	or	a.addr_sfx  <> b.addr_sfx	)

--	or	a.addr_pfx  <> b.addr_pfx


	and	a.addr_type||'.'||a.addr_pfx||'.'||a.addr_sfx < b.addr_type||'.'||b.addr_pfx||'.'||b.addr_sfx 

--	and	rownum < 11


	order by	a.addr_pfx desc,  b.addr_pfx desc,
			a.addr_name, a.addr_type, a.addr_sfx;
	

--	=================================================================================================
	set echo on;
  