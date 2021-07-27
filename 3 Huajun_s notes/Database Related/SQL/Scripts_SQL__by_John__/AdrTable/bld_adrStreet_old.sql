	set echo	off;
	set timing	on;
--	==============================================================================
--	build streets table by merging streets from cdreladr and trvehrcl
--	==============================================================================

	truncate table	adrStreets;

--	alter rollback segment	rb1			online;
--	commit;
--	set transaction	use rollback segment	rb1;
	
--	truncate table	plan_table;
--	explain plan	set statement_id = 'aaa'		for

	insert into	adrStreets

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

			adr_compress_name		(addr_name, '9')		addr_compress,		
			adr_compress_name		(addr_name,	'4')		addr_compact,		
			adr_compress_name		(addr_name,	'2')		addr_reduced,		

			substr (addr_name, 1, instr(addr_name, adr_name_ending(addr_name)) - 1 )	addr_begin,
--			substr (addr_name, 1, replace ((instr(addr_name, ' ') ), 0, null))		addr_begin,

			adr_name_ending		(addr_name)			addr_ending,			
			soundex			(addr_name)			addr_soundex,			
			adr_permute_name		(addr_name,	'1')		addr_permute		

	from
	(
	select	distinct
			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx

	from		cdreladr
	where		addr_name > '0'

	union all

	select	distinct
			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx

	from		trvehrcl
	where		addr_name > '0'

--	and		length(addr_name) <= 20
	)
);

--	select * from explain_plan;

	commit;
--	alter rollback segment	rb1			offline;

--	============================================================

	analyze table	adrStreets		compute statistics;

--	============================================================

	select	count(*)	from 	adrStreets;

--	select	all *		from	adrStreets
--	where		rownum < 22;

--	============================================================
/*

--	alter rollback segment	rb1			online;
--	set transaction	use rollback segment	rb1;

	update	adrStreets
	set		street_id = rownum
	where		street_id is null;

	commit;
--	alter rollback segment	rb1			offline;

*/
--	============================================================

	set echo	on;
	set timing	off;

