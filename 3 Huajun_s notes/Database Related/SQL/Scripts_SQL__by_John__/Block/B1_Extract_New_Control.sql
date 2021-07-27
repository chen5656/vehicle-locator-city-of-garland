	set echo		off;
	set fetchrows;
--	===========================================================================
--	Extract New Block Controls 
--	New blocks in TRVEHRCL & CDRELADR that do not exist in current BLOCK table.
--	===========================================================================

--	B1

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	What new hundred blocks exist on TRVEHRCL that do not exist on BLOCK
--	===========================================================================

	explain plan set statement_id =  'new seg'	into garland.plan_table	for

	insert into	garland.Block_Control_vw

--	select count(*) 

	select 	block_control_seq.nextval,	null,
			'I',		null, 
			trunc(addr_lo, -2),	addr_pfx,	addr_name,	addr_type,	addr_sfx,
			null,		null,		null,		null,		null,
			null,		null,		null,		null,	
			'R',		sysdate

	from		garland.trvehrcl
	where	(	trunc(addr_lo, -2), addr_pfx, addr_name, addr_type, addr_sfx	)
	in

(
	select	trunc(addr_lo, -2), addr_pfx, addr_name, addr_type, addr_sfx
	from		garland.trvehrcl
	where		addr_name > '0'  and addr_lo > 0

	minus

	select	addr_block, addr_pfx, addr_name, addr_type, addr_sfx
	from		garland.block
	where		addr_name > '0'  
);


--	==============================================================================
--	What hundred blocks exist on CDRELADR that do not exist on TRVEHRCL or BLOCK
--	==============================================================================

	explain plan set statement_id =  'new adr'	into garland.plan_table	for

	insert into	garland.Block_Control_vw

--	select count(*) from

	select 	block_control_seq.nextval, null,
			'I', null, 
			trunc(addr_num,-2),	addr_pfx,	addr_name,	addr_type,	addr_sfx,
			null,				null,		null,		null,		null,
			null,		null,		null,		null,	
			'A', sysdate

	from		garland.cdreladr
	where	(	trunc(addr_num, -2), addr_pfx, addr_name, addr_type, addr_sfx	)
	in
(
(
	select	trunc(addr_num, -2), addr_pfx, addr_name, addr_type, addr_sfx
	from		garland.cdreladr
	where		addr_name > '0'  and addr_num > 0

	minus

	select	trunc(addr_lo, -2), addr_pfx, addr_name, addr_type, addr_sfx
	from		garland.trvehrcl
	where		addr_name > '0'  and addr_lo > 0
)
	minus

	select	addr_block, addr_pfx, addr_name, addr_type, addr_sfx
	from		garland.block
	where		addr_name > '0'  
);

--	===========================================================================
	select * from garland.explain_plan;

--	rollback;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================
	set echo		on;
	set fetchrows;
