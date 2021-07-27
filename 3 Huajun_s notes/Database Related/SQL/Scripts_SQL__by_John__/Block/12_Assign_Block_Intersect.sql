	set echo		off;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan set statement_id =  'blk1'	into garland.plan_table	for

	update	garland.BLOCK	B
	set		intersect1_id	= 
(
	select	b1.intersect1_id

	from		block			b1,
			trvehRCL		r

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
	and		b1.addr_block  	= trunc(r.addr_lo, -2)

	and		b1.intersect1_id is not null
	and		rownum < 2
)

	where	intersect1_id is null;

--	===========================================================================
--	explain plan set statement_id =  'blk2'	into garland.plan_table	for

	update	garland.BLOCK	B
	set		intersect2_id	= 
(
	select	b1.intersect2_id

	from		block			b1,
			trvehRCL		r

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
	and		b1.addr_block  	= trunc(r.addr_lo, -2)

	and		b1.intersect2_id is not null
	and		rownum < 2
)

	where	intersect2_id is null;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;


	select count(*), count(intersect1_id) X1, count(intersect2_id) X2 from Block;


--	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================
	set echo	on;
