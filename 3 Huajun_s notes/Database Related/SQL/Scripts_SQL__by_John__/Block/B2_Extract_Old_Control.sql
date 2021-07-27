	set echo		off;
	set fetchrows;
--	===========================================================================
--	Extract Old Block Controls  (modified Trvehrcl/Cdreladr records)
--	Exist in Block table but do not exist in TRVEHRCL or CDRELADR
--	===========================================================================

--	B2

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	What current Block records are no longer in TRVEHRCL or CDRELADR
--	===========================================================================

	explain plan set statement_id =  'old blk'	into garland.plan_table	for

--	select count(*)

	insert into	garland.Block_Control_vw

	select 	block_control_seq.nextval, null,
			'N', null, 
			addr_block, addr_pfx, addr_name, addr_type,	addr_sfx,
			null,		null,	    null,	   null,		null,
			null,		null,	    null,	   null,	
			'B', sysdate	  	

	from		garland.Block
	where	   (	addr_block, addr_pfx, addr_name, addr_type, addr_sfx	)
	in
	
(
	select	addr_block, addr_pfx, addr_name, addr_type, addr_sfx
	from		garland.Block
	where		addr_name > '0'  

	minus

(
	select	trunc(addr_num, -2), addr_pfx, addr_name, addr_type, addr_sfx
	from		garland.cdreladr
	where		addr_name > '0'  and addr_num > 0

	union

	select	trunc(addr_lo, -2), addr_pfx, addr_name, addr_type, addr_sfx
	from		garland.trvehrcl
	where		addr_name > '0'  and addr_lo > 0
)

);

--	===========================================================================
	select * from garland.explain_plan;

--	rollback;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================
	set echo		on;
	set fetchrows;

