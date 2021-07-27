	set echo	off;
	set timing	off;
--	================================================================

--	backups:	 cdrelpar / cdreladr / trvehrcl / pave_mast

--	================================================================
--	It may be necessary to add new columns to copy tables
--	================================================================

	comment on table	garland.cdrelpar_copy is		'regular bkup';

	truncate table	garland.cdrelpar_copy	reuse storage;

	insert --+ append
	into			garland.cdrelpar_copy
	select * from 	garland.cdrelpar
	order by		parcel_id;

	commit;

--	================================================================	

	comment on table	garland.cdreladr_copy is		'regular bkup';

	truncate table	garland.cdreladr_copy	reuse storage;

	insert 	--+	append
	into			garland.cdreladr_copy
	select * from 	garland.cdreladr
	order by		addr_name, addr_num, addr_type, addr_pfx, addr_sfx;

	commit;

--	================================================================

	comment on table	garland.trvehrcl_copy is		'regular bkup';

	truncate table	garland.trvehrcl_copy	reuse storage;

	insert 	--+	append
	into			garland.trvehrcl_copy
	select * from 	garland.trvehrcl
	order by		addr_name, addr_lo, addr_type, addr_pfx, addr_sfx;

	commit;

--	================================================================	

	comment on table	garland.pave_mast_copy is		'regular bkup';			

	truncate table	garland.pave_mast_copy	reuse storage;

	insert --+ append
	into			garland.pave_mast_copy
	select * from 	garland.pave_mast;

	commit;

--	=======================================================
	
	analyze table	garland.cdrelpar	estimate statistics;
	analyze table	garland.cdreladr	estimate statistics;
	analyze table	garland.trvehrcl	estimate statistics;
	analyze table	garland.pave_mast	estimate statistics;

--	=======================================================
	set echo	on;
	set timing	off;

