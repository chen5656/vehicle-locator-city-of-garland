	set echo		off;
	set termout		off;
--	=============================================================================

--	analyze table	intersection		compute statistics;
--	analyze table	gis_temp4			compute statistics;

--	=============================================================================

	spool	c:\deacutis\extract\police_intersection

--	truncate table	plan_table		reuse storage;
--	explain plan	set statement_id = 'xxx'	for

	select
			addr1_block			||';'||
			addr1_pfx			||';'||
			addr1_name			||';'||
			addr1_type			||';'||
			addr1_sfx			||';'||

			addr2_block			||';'||
			addr2_pfx			||';'||
			addr2_name			||';'||
			addr2_type			||';'||
			addr2_sfx			||';'||

			beat				||';'||
			district			||''||

			' '				" "
	from
(
	select	addr1_block, addr1_pfx, addr1_name, addr1_type, addr1_sfx,
			addr2_block, addr2_pfx, addr2_name, addr2_type, addr2_sfx,
			b.item03 beat,	d.item03 district

	from		garland.intersection		x,
			garland.gis_temp4			b,
			garland.gis_temp4			d

	where		intersect_id like 'BB%'

	and		rtrim(x.node_id)	= b.item01
	and		rtrim(x.node_id)	= d.item01

	and		b.item01		= d.item01
	and		b.item02		= 'BEAT'	
	and		d.item02		= 'DISTRICT'	

	order by	addr1_name, addr2_name, addr1_type, addr2_type, addr1_pfx, addr2_pfx, 
			addr1_sfx,  addr2_sfx,  addr1_block,addr2_block
);

--	select * from explain_plan;

	spool off;

--	=============================================================================
	set echo		on;
	set termout		on;
