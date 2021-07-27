	set echo	off;
	set timing	off;
--	==============================================================================
--	build streets table by merging streets from cdreladr and trvehrcl
--	==============================================================================

	Truncate table	garland.adrStreets	reuse storage;
	
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	insert --+ append
	into	garland.adrStreets

	select	addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,

			street_id,

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
			nvl(addr_type,	' ')		addr_type,
			nvl(addr_pfx,	' ')		addr_pfx,
			nvl(addr_sfx,	' ')		addr_sfx,

			street_id,

			garland.adr_compress_name	(addr_name, '6')		addr_compress,		
			garland.adr_compress_name	(addr_name,	'4')		addr_compact,		
			garland.adr_compress_name	(addr_name,	'1')		addr_reduced,		

			substr (addr_name, 1, instr(addr_name, garland.TST_name_ending(addr_name)) - 1 )	addr_begin,

			garland.adr_name_ending		(addr_name)			addr_ending,			
			soundex				(addr_name)			addr_soundex,			
			garland.adr_permute_name	(addr_name,	'1')		addr_permute		

	from	jdeacutis.STREET_ADRSTREET
);


	Commit;

--	============================================================

	analyze table	garland.adrStreets	compute statistics;

--	select count(*)	from 	garland.adrStreets;

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert into   garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================
	set echo		on;
	set fetchrows;
	set charwidth;

