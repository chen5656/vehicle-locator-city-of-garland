	set	echo		off;
--	set timing		on;
--	===========================================================================
--	set 	termout	OFF;
--	===========================================================================

	select distinct rpad(intersect_id,2) from garland.intersection;	--  BB NN SS

--	===========================================================================

	truncate table	garland.plan_table	reuse storage;

	spool  c:\deacutis\extract\WATER_INTERSECTION.txt;

--	explain plan set statement_id = 'xxx'	into garland.plan_table	for

--	===========================================================================

--	select count(*)

	select
	 	replace (

			nvl(addr1_pfx, ' ')	||','||
			addr1_name			||','||
			nvl(addr1_type,' ')	||','||
			nvl(addr1_sfx, ' ')	||','||

			nvl(addr2_pfx, ' ')	||','||
			addr2_name			||','||
			nvl(addr2_type,' ')	||','||
			nvl(addr2_sfx, ' ')	||','


		,'  ',' ')			

	" "
	from
(		
	select	all *
	from		garland.Intersection
	where		intersect_id like 'SS%'
	order by 	addr1_name, addr1_type, addr2_name, addr2_type,
			addr1_pfx,  addr2_pfx,  addr1_sfx,  addr2_sfx
);

--	===========================================================================

	spool off;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

--	===========================================================================
	set 	termout	on;
	set	echo		on;
	set 	timing	off;


