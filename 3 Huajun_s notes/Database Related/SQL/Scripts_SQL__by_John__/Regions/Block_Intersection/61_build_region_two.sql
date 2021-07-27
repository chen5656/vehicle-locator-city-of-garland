	set echo	off;
--	=============================================================
--	all block regions ==> block w/ two regions
--	=============================================================

	truncate table	gis_temp2	reuse storage;
	truncate table	plan_table	reuse storage;

	alter rollback segment	rb1	online;
	commit;
	set transaction	use rollback segment rb1;

	explain plan set statement_id = 'region2'		for	

	insert into block_region2_view

	select	addr_name, addr_type, addr_pfx, addr_sfx, addr_block,
		min(region1), max(region1)l
	from	block_region2_view
	where  (addr_name, addr_type, addr_pfx, addr_sfx, addr_block )
	in
(
	select		addr_name, addr_type, addr_pfx, addr_sfx, addr_block
	from		block_region2_view
	group by	addr_name, addr_type, addr_pfx, addr_sfx, addr_block
	having		count(distinct region1) = 02
)	
	group by	addr_name, addr_type, addr_pfx, addr_sfx, addr_block
;

	select * from explain_plan;

	commit;
	alter rollback segment	rb1	offline;

	analyze table	gis_temp2	compute statistics;

--	=============================================================
	set echo	on;


