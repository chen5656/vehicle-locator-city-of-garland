	set echo 	off;
	set timing	off;
	
--	================================================================================
	select 'Address Names not in Segment' " "	from dual;

--	select count(distinct addr_name) " "
	select distinct addr_name " " 
	from  garland.adrStreets
	where addr_name in
(
	select addr_name 	from	garland.adrStreets
	minus
	select addr_name 	from 	garland.trvehrcl
);

--	crested cove / crestcove
--	state highway 190 => george bush

--	================================================================================
	select 'Address Streets not in Segment' " "	from dual;

--	select count(distinct a.addr_pfx || a.addr_name || a.addr_type || a.addr_sfx)	" "
	select distinct a.addr_pfx, a.addr_name, a.addr_type, a.addr_sfx
	from	garland.cdreladr	a,
		garland.trvehrcl	r
	where	a.addr_name = r.addr_name
	and not exists
(
	select 'x'
	from 	garland.trvehrcl
	where	addr_name	= a.addr_name
	and	addr_type	= a.addr_type
	and	addr_pfx	= a.addr_pfx
	and	addr_sfx	= a.addr_sfx
);

--	================================================================================
	select 'Segment Names not in Address' " "	from dual;

--	select count(distinct addr_name) " "
	select distinct addr_name
	from garland.trvehrcl
	where addr_name	in
(
	select addr_name		from	garland.trvehrcl
	where addr_name not like '%FEEDER'
	and	addr_name not like '%SERVICE'
	minus
	select addr_name		from 	garland.cdreladr
);

--	================================================================================
	select 'Segment Streets not in Address' " "	from dual;

--	select count(distinct r.addr_pfx || r.addr_name || r.addr_type || r.addr_sfx) " " 
	select distinct r.addr_pfx, r.addr_name, r.addr_type, r.addr_sfx	
	from	garland.trvehrcl	r,
		garland.cdreladr	a
	where r.addr_name = a.addr_name
	and not exists	
(	select 'x'	from garland.adrStreets
	where	addr_name	= r.addr_name
	and	addr_type	= r.addr_type
	and	addr_pfx	= r.addr_pfx
	and	addr_sfx	= r.addr_sfx
);

--	================================================================================
	select 'Address not within Segment Range' " "	from dual;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'aaa'	for

--	select count(*) " "
	select addr_num, addr_pfx, addr_name, addr_type, addr_sfx
	from	garland.cdreladr	a
	where addr_num > 0
	and	not exists
(
	select 'x'
	from garland.trvehrcl	r
	where	r.addr_name	= a.addr_name
	and	r.addr_type	= a.addr_type
	and	r.addr_pfx	= a.addr_pfx
	and	r.addr_sfx	= a.addr_sfx
	and	a.addr_num between r.addr_lo and addr_hi
	and	a.addr_num > 0
	and	r.addr_lo  > 0
	and	r.addr_hi  > 0
)
	and exists
(
	select addr_name
	from	 garland.trvehrcl	r
	where	r.addr_name	= a.addr_name
	and	r.addr_type	= a.addr_type
	and	r.addr_pfx	= a.addr_pfx
	and	r.addr_sfx	= a.addr_sfx
)
	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num;

--	select * from explain_plan;

--	================================================================================
	select 'Addresses not within Block Range' " "	from dual;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'aaa'		for

--	select count(distinct addr_num || addr_pfx || addr_name || addr_type || addr_sfx) " "
	select distinct trunc(addr_num, -2) " ", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " " 
	from	garland.cdreladr		a
	where addr_num > 0
	and	not exists
(
	select 'x'
	from garland.trvehrcl		r
	where	r.addr_name	= a.addr_name
	and	r.addr_type	= a.addr_type
	and	r.addr_pfx	= a.addr_pfx
	and	r.addr_sfx	= a.addr_sfx
	and	a.addr_num between trunc(r.addr_lo,-2) and trunc(addr_hi,-2) + 99
	and	r.addr_lo > 0
	and	r.addr_hi > 0
)
	and exists
(
	select addr_name
	from	 garland.trvehrcl		r
	where	r.addr_name	= a.addr_name
	and	r.addr_type	= a.addr_type
	and	r.addr_pfx	= a.addr_pfx
	and	r.addr_sfx	= a.addr_sfx
)
	order by	addr_name, addr_type, addr_pfx, addr_sfx, trunc(addr_num,-2);

--	select * from explain_plan;

--	================================================================================
	select 'Unique CDRELADR Name & Type but non_unique in TRVEHRCL'  " " from dual;

--	select count(distinct	a.addr_pfx || a.addr_name || a.addr_type || a.addr_sfx ||
--					r.addr_pfx || r.addr_name || r.addr_type || r.addr_sfx  ) " " 
	select distinct
		rpad(a.addr_pfx, 02) " ", rpad(a.addr_name,20) "address", 
		rpad(a.addr_type,05) " ", rpad(a.addr_sfx, 02) " ",
		rpad(r.addr_pfx, 02) " ", rpad(r.addr_name,20) "centerline", 
		rpad(r.addr_type,05) " ", rpad(r.addr_sfx, 02) " "

	from	garland.cdreladr	a,
		garland.trvehrcl	r
	where	a.addr_name	 = r.addr_name

	and	1 =
(
	select count (distinct addr_name || addr_type)
	from	garland.adrStreets
	where	addr_name = a.addr_name
)
	and	1 <
(
	select count (distinct addr_name || addr_type)
	from	garland.trvehrcl
	where	addr_name = a.addr_name
)
	order by rpad(a.addr_name,20), rpad(a.addr_type,05), rpad(a.addr_pfx,02), rpad(a.addr_sfx,02);

--	select * from explain_plan;

--	================================================================================
--	===============================================================
/*
	select addr_name, addr_lo, addr_hi
	from garland.trvehrcl
	where translate (addr_name, '/ ', '/') = 'REDBUD';

	select min(addr_num) " ", max(addr_num) " "
	from garland.cdreladr
	where translate (addr_name, '/ ', '/') = 'REDBUD';
*/
--	===============================================================
/*
	update garland.trvehrcl
	set addr_name = 'BOIS D ARC'
	where addr_name = 'BOIS-D-ARC';	

	rollback;
	commit;
*/
--	===============================================================

	set echo 	on;