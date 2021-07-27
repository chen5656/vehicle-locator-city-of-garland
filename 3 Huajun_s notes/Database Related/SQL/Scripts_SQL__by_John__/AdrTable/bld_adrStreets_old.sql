	set echo	off;
	set timing	off;
--	==============================================================================
--	build streets table by merging streets from cdreladr and trvehrcl
--	==============================================================================

	truncate table	garland.adrStreets	reuse storage;
	
--	truncate table	garland.plan_table;
--	explain plan	set statement_id = 'aaa'		for

	insert --+ append
	into	garland.adrStreets

	select	addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,

			rownum,

			addr_compress,
			addr_compact,
			addr_reduced,

			addr_begin,
			addr_ending,
			addr_soundex,
			addr_permute
	from
(
	select	distinct 

			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,

			garland.adr_compress_name	(addr_name, '6')		addr_compress,		
			garland.adr_compress_name	(addr_name,	'4')		addr_compact,		
			garland.adr_compress_name	(addr_name,	'1')		addr_reduced,		

			substr (addr_name, 1, instr(addr_name, garland.TST_name_ending(addr_name)) - 1 )	addr_begin,
--			substr (addr_name, 1, replace ((instr(addr_name, ' ') ), 0, null))			addr_begin,

			garland.adr_name_ending		(addr_name)			addr_ending,			
			soundex				(addr_name)			addr_soundex,			
			garland.adr_permute_name	(addr_name,	'1')		addr_permute		

	from
	(

	select	distinct
			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx

	from		garland.cdreladr
	where		addr_name > '0'

	union all

	select	distinct
			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx

	from		garland.trvehrcl
	where		addr_name > '0'

--	and		length(addr_name) <= 20


	)

);

--	select * from garland.explain_plan;

	commit;
--	alter rollback segment	rb1			offline;

--	============================================================

	analyze table	garland.adrStreets		compute statistics;

--	============================================================

	select	count(*)	from 	garland.adrStreets;

--	select	all *		from	garland.adrStreets
--	where		rownum < 22;

--	============================================================
/*

--	alter rollback segment	rb1			online;
--	set transaction	use rollback segment	rb1;

	update	garland.adrStreets
	set		street_id = rownum
	where		street_id is null;

	commit;
--	alter rollback segment	rb1			offline;

*/
--	============================================================
	set echo	on;
	set timing	off;
