	set echo		off;
	set fetchrows	111;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id =  'xxx'	into garland.plan_table	for
--	===========================================================================

	update	garland.BLOCK	B

	set	(	intersect1_id, 
			intersect2_id	)	= 
	(
	select
			nvl(min(b1.intersect1_id), bb.intersect1_id),
			nvl(max(b2.intersect2_id), bb.intersect2_id)

--	---------------------------------------------------------------------------------------
--	TESTS

--			b1.intersect1_id,
--			b1.intersect2_id,
--			b2.intersect1_id,
--			b2.intersect2_id

--			trunc(r.addr_hi,-2)  -  trunc(r.addr_lo,-2),
--			b.addr_block,	b.addr_name,
--			r.addr_lo,		r.addr_hi,		r.addr_name,
--			b1.addr_block,	b1.addr_pfx,	b1.addr_name,	b1.addr_type,
--			b2.addr_block,	b2.addr_pfx,	b2.addr_name,	b2.addr_type

--			count(*),
--			count(distinct b1.intersect1_id),
--			count(distinct b1.intersect2_id),
--			count(distinct b2.intersect1_id),
--			count(distinct b2.intersect2_id)
--	---------------------------------------------------------------------------------------

	from		trvehrcl	r,

			BLOCK		BB,					-- FOR UPDATE
--			BLOCK		B,					-- FOR TESTING

			block		b1,
			block		b2

	where		bb.addr_name	= r.addr_name
	and		bb.addr_type	= r.addr_type
	and		bb.addr_pfx		= r.addr_pfx
	and		bb.addr_sfx		= r.addr_sfx
	and		bb.addr_block 	> trunc(r.addr_lo, -2)
	and		bb.addr_block 	< trunc(r.addr_hi, -2)

	and		b1.addr_name	= r.addr_name
	and		b1.addr_type	= r.addr_type
	and		b1.addr_pfx		= r.addr_pfx
	and		b1.addr_sfx		= r.addr_sfx
	
	and		b2.addr_name	= r.addr_name
	and		b2.addr_type	= r.addr_type
	and		b2.addr_pfx		= r.addr_pfx
	and		b2.addr_sfx		= r.addr_sfx

	and		b1.addr_block 	< b2.addr_block
	and		b1.addr_block  in (trunc(r.addr_lo, -2), trunc(r.addr_hi, -2) )
	and		b2.addr_block  in (trunc(r.addr_lo, -2), trunc(r.addr_hi, -2) )

	AND		BB.ROWID	= B.ROWID					-- FOR UPDATE
	

--	AND		B.ADDR_NAME = 'CASTLE'

	order by	bb.addr_name, bb.addr_type, bb.addr_pfx, bb.addr_sfx, bb.addr_block
	)
	;

--	===========================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;
--	===========================================================================
	set echo	on;
	set fetchrows;

