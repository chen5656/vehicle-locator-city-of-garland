	set echo	off;
--	=============================================================
--	all block regions ==> unique block regions
--	=============================================================

	truncate table	gis_temp1	reuse storage;
	truncate table	plan_table	reuse storage;

	alter rollback segment	rb1	online;
	commit;
	set transaction	use rollback segment rb1;

--	explain plan set statement_id = 'region1'		for	

	insert into block_region1_view

	select	distinct
			addr_name, addr_type, addr_pfx, addr_sfx, addr_block,
			region1, null
	from		block_region3_view
	where 	(addr_name, addr_type, addr_pfx, addr_sfx, addr_block)
	in
(
	select	addr_name, addr_type, addr_pfx, addr_sfx, addr_block
	from		block_region3_view
	group by	addr_name, addr_type, addr_pfx, addr_sfx, addr_block
	having	count(distinct region1) = 01
)	;

--	select * from explain_plan;

	commit;
	alter rollback segment	rb1	offline;

	analyze table	gis_temp1	compute statistics;

--	=============================================================
	set echo	on;

