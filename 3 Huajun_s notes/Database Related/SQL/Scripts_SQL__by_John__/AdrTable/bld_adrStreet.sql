set echo	off;
	set timing	off;
--	==============================================================================
--	build street table by merging streets from cdreladr and trvehrcl
--	==============================================================================

	truncate table	adrStreet	reuse storage;

--	alter rollback segment	rb1			online;
--	commit;
--	set transaction	use rollback segment	rb1;
	
--	truncate table	plan_table;
--	explain plan	set statement_id = 'aaa'		for

	insert into	adrStreet

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

			adr_compress_name		(addr_name, '6)		addr_compress,		
			adr_compress_name		(addr_name,	'4')		addr_compact,		
			adr_compress_name		(addr_name,	'1')		addr_reduced,		

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

	and		length(addr_name) <= 20				--	oct 2002
	)
);

--	select * from explain_plan;

	commit;
--	alter rollback segment	rb1			offline;

--	============================================================

	analyze table	adrStreet		compute statistics;

--	============================================================

	select	count(*)	from 	adrStreet;

--	select	all *		from	adrStreet
--	where		rownum < 22;

--	============================================================
/*

	alter rollback segment	rb1			online;
	set transaction	use rollback segment	rb1;

	update	adrStreet
	set		street_id = rownum
	where		street_id is null;

	commit;
	alter rollback segment	rb1			offline;

*/
--	============================================================

	set echo	on;
	set timing	off;

