	set echo		off;
	set fetchrows;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id =  'xxx'	into garland.plan_table	for
--	===========================================================================

	update	garland.BLOCK	B

	set	(	intersect1_id, 
			intersect2_id	)	= 
(
	select	min(d.intersect1),  max(d.intersect2)
	from		garland.Block	C,
(
	select
			b.rowid	row_id,
--			b.addr_block, b.addr_pfx, b.addr_name, b.addr_type, b.addr_sfx, 
			nvl(b1.intersect1_id, b.intersect1_id)	intersect1,
			nvl(b2.intersect2_id, b.intersect2_id)	intersect2

	from		trvehRCL	r,
			BLOCK		b,					-- FOR UPDATE
			block		b1,
			block		b2

	where		b.addr_name		= r.addr_name
	and		b.addr_type		= r.addr_type
	and		b.addr_pfx		= r.addr_pfx
	and		b.addr_sfx		= r.addr_sfx
	and		b.addr_block 	> trunc(r.addr_lo, -2)
	and		b.addr_block 	< trunc(r.addr_hi, -2)

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

)						D

	where		C.rowid	= B.rowid
	and		C.rowid	= D.row_id

	group by	c.addr_block, c.addr_pfx, c.addr_name, c.addr_type, c.addr_sfx 
);

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;


	select count(intersect1_id), count(intersect2_id) from block;


--	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================
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
--	===========================================================================

	set echo	on;
	set fetchrows;

