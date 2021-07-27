	set echo	off;
--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id =	'xxx'		into garland.plan_table	for
--	===========================================================================

--	select count(*)

--	insert into garland.adrAlias

	select distinct
		pp.addr_pfx,
		s.addr_name,
		tt.addr_type,
		'*',
		0,999999,0,
		pp.addr_pfx,
		s.addr_name,
		tt.addr_type,
		'',
		'mix=',
		' ', ' ', ' '

	from		garland.adrStreets	s,
(
	select	addr_name, addr_pfx
	from		garland.adrStreets
	where		addr_name	in
(
	select	addr_name
	from		garland.adrStreets
	group by	addr_name
	having	count (distinct addr_pfx) > 1
))							pp,

(
	select	addr_name, addr_type
	from		garland.adrStreets
	where		addr_name	in
(
	select	addr_name
	from		garland.adrStreets
	group by	addr_name
	having	count(distinct addr_type) > 1
))							tt

	where		s.addr_name	= pp.addr_name
	and		s.addr_name	= tt.addr_name
	and		pp.addr_pfx  > ' '
	and		tt.addr_type > ' '
	and not exists
(
	select 'x'
	from		garland.adrStreets
	where		addr_type	= tt.addr_type
	and		addr_pfx	= pp.addr_pfx
)

	order by	s.addr_name, tt.addr_type, pp.addr_pfx;

	commit;
	
--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;
--	===========================================================================
