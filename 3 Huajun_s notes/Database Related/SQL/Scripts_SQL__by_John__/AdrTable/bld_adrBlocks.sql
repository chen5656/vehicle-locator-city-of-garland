	set echo 	off;
--	---------------------------------------------------------------------------------------------
--	build Block table from TRVEHRCL & CDRELADR
--	---------------------------------------------------------------------------------------------

	Truncate table	garland.Block	reuse storage;		

	@c:\deacutis\scripts\adrTable\bld_adrBlock.sql;

	commit;

--	---------------------------------------------------------------------------------------------
--	extend adrBlock with CDRELADR blocks not found in TRVEHRCL

	insert into	garland.Block						

	select
			999999, 				--	temporary block id
			trunc(addr_num,-2), addr_pfx, addr_name, addr_type, addr_sfx,  	
			0,0,0,				--	start lo, stop lo, stop hi 
			null,					--	record count
			null, null				--	intersect ids
		from		garland.cdreladr
	where		addr_num > 0

	minus
	select
			999999, 				--	temporary block id
			addr_block,	addr_pfx, addr_name, addr_type, addr_sfx, 
			0,0,0,				--	start lo, stop lo, stop_hi
			null,					--	record count
			null, null				--	intersect ids
	from		garland.Block;

	commit;


--	---------------------------------------------------------------------------------------------
	set echo on;
