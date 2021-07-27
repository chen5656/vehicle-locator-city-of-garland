	set echo	off;
	set timing	off;
--	========================================================================================

--	backups:	 cdrelpar / cdreladr / trvehrcl / block / intersection / pave_mast /

--	========================================================================================
--	It may be necessary to add new columns to copy tables
--	========================================================================================

	truncate table	garland.cdrelpar_copy	reuse storage;

	insert --+ append
	into			garland.cdrelpar_copy
	select * from 	garland.cdrelpar
	order by		parcel_id;

	commit;

--	========================================================================================

	truncate table	garland.cdreladr_copy	reuse storage;

	insert 	--+	append
	into			garland.cdreladr_copy
	select * from 	garland.cdreladr
	order by		addr_name, addr_num, addr_type, addr_pfx, addr_sfx;

	commit;

--	========================================================================================

	truncate table	garland.trvehrcl_copy	reuse storage;

	insert 	--+	append
	into			garland.trvehrcl_copy
	select * from 	garland.trvehrcl
	order by		addr_name, addr_lo, addr_type, addr_pfx, addr_sfx;

	commit;

--	========================================================================================

	truncate table	garland.block_copy	reuse storage;

	insert 	--+	append
	into			garland.block_copy
	select * from 	garland.block
	order by		addr_name, addr_type, addr_pfx, addr_sfx, addr_block;

	commit;

--	========================================================================================

	truncate table	garland.intersection_copy	reuse storage;

	insert 	--+	append
	into			garland.intersection_copy
	select * from 	garland.intersection
	order by		addr1_name, addr2_name, addr1_type, addr2_type, addr1_pfx, addr2_pfx, 
				addr1_sfx,  addr2_sfx,  addr1_block,addr2_block;

	commit;

--	========================================================================================

	truncate table	garland.pave_mast_copy	reuse storage;

	insert --+ append
	into			garland.pave_mast_copy
	select * from 	garland.pave_mast;

	commit;

--	========================================================================================
	
	analyze table	garland.cdrelpar	estimate statistics;
	analyze table	garland.cdreladr	estimate statistics;
	analyze table	garland.trvehrcl	estimate statistics;
	analyze table	garland.pave_mast	estimate statistics;

--	========================================================================================
	set echo	on;
	set timing	off;

