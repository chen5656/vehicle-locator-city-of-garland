	set echo off;

--	display CDRELADR streets that do not exist on TRVEHRCL
--	display related streets on TRVEHRCL for comparison


--	truncate table	plan_table;
--	explain plan	set statement_id = 'aaa'	for

	select distinct
		rpad(s.addr_pfx, 02) " ", rpad(s.addr_name,20) "address", 
		rpad(s.addr_type,05) " ", rpad(s.addr_sfx, 02) " "
--		,'    ' " "
--		,rpad(r.addr_pfx, 02) " " ,rpad(r.addr_name,20) "centerline" 
--		,rpad(r.addr_type,05) " ",rpad(r.addr_sfx, 02) " "

	from	garland.adrStreets	s,
		garland.trvehrcl		r

	where	s.addr_name  = r.addr_name
	and (	s.addr_type	<> r.addr_type
	or	s.addr_pfx	<> r.addr_pfx
	or	s.addr_sfx	<> r.addr_sfx  )

	and	not exists
(
	select 'x'
	from	garland.trvehrcl
	where	addr_name	= s.addr_name
	and	addr_type	= s.addr_type
	and	addr_pfx	= s.addr_pfx
	and	addr_sfx	= s.addr_sfx
)

	order by rpad(s.addr_name,20), rpad(s.addr_type,05), rpad(s.addr_pfx,02), rpad(s.addr_sfx,02)
--		   ,rpad(r.addr_name,20) ,rpad(r.addr_type,05) ,rpad(r.addr_pfx,02) ,rpad(r.addr_sfx,02)
	;

--	select * from explain_plan;


--	==================================================================================================
--	==================================================================================================

--	display TRVEHRCL streets that do not exist on CDRELADR
--	display streets that do exist on CDRELADR for comparison


--	truncate table	plan_table;
--	explain plan	set statement_id = 'bbb'	for

	select distinct
		rpad(r.addr_pfx, 02) " ", rpad(r.addr_name,20) "centerline", 
		rpad(r.addr_type,05) " ", rpad(r.addr_sfx, 02) " "
--		,'    ' " "
--		,rpad(s.addr_pfx, 02) " " ,rpad(s.addr_name,20) "address" 
--		,rpad(s.addr_type,05) " " ,rpad(s.addr_sfx, 02) " "

	from	garland.adrStreets	s,
		garland.trvehrcl		r

	where	s.addr_name  = r.addr_name
	and (	s.addr_type	<> r.addr_type
	or	s.addr_pfx	<> r.addr_pfx
	or	s.addr_sfx	<> r.addr_sfx  )

	and	not exists
(
	select 'x'
	from	garland.adrStreets
	where	addr_name	= r.addr_name
	and	addr_type	= r.addr_type
	and	addr_pfx	= r.addr_pfx
	and	addr_sfx	= r.addr_sfx
)
	order by  rpad(r.addr_name,20), rpad(r.addr_type,05), rpad(r.addr_pfx,02), rpad(r.addr_sfx,02)
--		   ,rpad(s.addr_name,20) ,rpad(s.addr_type,05) ,rpad(s.addr_pfx,02) ,rpad(s.addr_sfx,02)
	;

--	select * from explain_plan;

--	====================================================================================================

	select addr_pfx, addr_name, addr_type, addr_sfx,
		addr_lo, addr_hi,
--		branch_no, section_no, 
		mslink
	from	garland.trvehrcl
	where	addr_name in
(
	select distinct addr_name
	from	garland.trvehrcl	t
	where	not exists
(
	select '*'
	from	garland.cdreladr
	where addr_name = t.addr_name
)
)
	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_lo;

--	====================================================================================================
