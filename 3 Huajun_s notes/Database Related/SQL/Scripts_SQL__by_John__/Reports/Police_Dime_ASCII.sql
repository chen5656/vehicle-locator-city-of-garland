	set echo 		off;
	set termout		off;
	set charwidth	160;
	set fetchrows	;
--	=======================================================================================================
--	UPDATE  BEAT & DISTRICT  using script in /REGION directory
--	=======================================================================================================

	spool	c:\deacutis\extract\police_dime.txt

--	=======================================================================================================
--	truncate table plan_table	reuse storage;
--	explain plan set statement_id = 'xxx'	for
--	=======================================================================================================

--	select count(*)

	select 'left lo,left hi,rght lo,rght hi,prefix,name,type,suffix,left beat,left dist,left zip,rght beat,rght dist,rght zip' " "
	from	dual
	union all

	select
		addr_left_from		||','||
		addr_left_to		||','||
		addr_rght_from		||','||
		addr_rght_to		||','||

		addr_pfx			||','||   	
		addr_name			||','||  	
		addr_type			||','||	
		addr_sfx 			||','||

		l_beat			||','||	
		l_dist			||','||
		l_zip				||','||
--		l_fire			||','||

		r_beat			||','||	
		r_dist			||','||
		r_zip		
--		r_fire	

	" "
	from
(
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

		rtrim(bl.police_beat)		l_beat,
		rtrim(bl.police_district)	l_dist,
		bl.zip_code				l_zip,
		bl.fire_district			l_fire,

		rtrim(br.police_beat)		r_beat,
		rtrim(br.police_district)	r_dist,
		br.zip_code				r_zip,
		br.fire_district			r_fire

	from
		garland.trvehrcl		ll,
		garland.trvehrcl		rr,
		garland.block_side	bl,
		garland.block_side	br,

(	select r.rowid	seg_rowid,
		 b.rowid	blk_rowid
	from	garland.trvehrcl		r,
		garland.block_side	b
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
	from	garland.trvehrcl		r,
		garland.block_side	b
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
);

--	select * from explain_plan;

	spool	off;

--	=======================================================================================================
	set fetchrows;
	set charwidth;
	set termout		on;
	set echo 		on;
