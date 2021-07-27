	set echo off;

--	truncate table plan_table	reuse storage;
--	explain plan set statement_id = 'xxx'	for

--	select count(*)

	select
		ll.addr_name,  	
		ll.addr_type,	
		ll.addr_pfx,   	
		ll.addr_sfx,   	
		ll.addr_lo,

		ll.addr_left_from,
		ll.addr_left_to,
		rr.addr_rght_from,
		rr.addr_rght_to,

		bl.zip_code				l_zip,
		bl.fire_district			l_fire,
		rtrim(bl.police_beat)		l_beat,
		rtrim(bl.police_district)	l_dist,

		br.zip_code				r_zip,
		br.fire_district			r_fire,
		rtrim(br.police_beat)		r_beat,
		rtrim(br.police_district)	r_dist

	from
		trvehrcl		ll,
		trvehrcl		rr,
		block_side		bl,
		block_side		br,

(	select r.rowid	seg_rowid,
		 b.rowid	blk_rowid
	from	trvehrcl		r,
		block_side		b
	where	b.addr_name		= r.addr_name
	and	b.addr_type		= r.addr_type
	and	b.addr_pfx		= r.addr_pfx
	and	b.addr_sfx		= r.addr_sfx
	and	b.addr_block	= trunc(r.addr_lo, -2)
	and	b.addr_parity	= mod(r.addr_left_from, 02)
	and	nvl(r.addr_left_from, 0) > 0
)	L,

(	select r.rowid	seg_rowid,
		 b.rowid	blk_rowid
	from	trvehrcl		r,
		block_side		b
	where	b.addr_name		= r.addr_name
	and	b.addr_type		= r.addr_type
	and	b.addr_pfx		= r.addr_pfx
	and	b.addr_sfx		= r.addr_sfx
	and	b.addr_block	= trunc(r.addr_lo, -2)
	and	b.addr_parity	= mod(r.addr_rght_from, 02)
	and	nvl(r.addr_rght_from, 0) > 0
)	R

	where	l.seg_rowid		= r.seg_rowid
	and	ll.rowid		= l.seg_rowid
	and	rr.rowid		= r.seg_rowid
	and	bl.rowid		= l.blk_rowid
	and	br.rowid		= r.blk_rowid

	order by	1,2,3,4,5
	;

--	select * from explain_plan;

--	select count(*) "segment"	from trvehrcl;
--	select count(*) "block"		from block_side;

	set echo on;

