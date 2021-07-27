
--	which TRVEHRCL streets can be corrected to match CDRELADR
--	based on unique street names & overlapping ranges

	set echo off;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'aaa'	for

	select
		min(r.addr_pfx)	" ", 
		a.addr_name		segm_name, 
		min(r.addr_type)	" ", 
		min(r.addr_sfx)	" ",
		min(r.addr_lo)	range_lo, 
		max(r.addr_hi)	range_hi,	 
		'    '		" ",
		min(a.addr_pfx)	" ", 
		a.addr_name, 
		min(a.addr_type)	" ", 
		min(a.addr_sfx)	" ",
		min(a.addr_num)	addr_min, 
		max(a.addr_num)	addr_max 

	from	garland.cdreladr	a,
		garland.trvehrcl	r

	where	a.addr_name	 = r.addr_name

	and (	a.addr_type	<> r.addr_type
	or	a.addr_pfx	<> r.addr_pfx
	or	a.addr_sfx	<> r.addr_sfx	)

	and	a.addr_num > 0
	and	r.addr_lo  > 0
	and	r.addr_hi  > 0

	and	1 = (select count(*) from garland.adrStreets where addr_name = r.addr_name) 

	group by	a.addr_name
--	having	trunc(min(a.addr_num),-2) between trunc(min(r.addr_lo),-2) and trunc(max(r.addr_hi),-2)
--	or		trunc(max(a.addr_num),-2) between trunc(min(r.addr_lo),-2) and trunc(max(r.addr_hi),-2)
	;

--	select * from explain_plan;

	set echo on;

