--	MERGE & NO_MERGE HINTS
--	no luck

	set echo off;

--	analyze table	adrName		compute statistics;
--	analyze table	adrStreet		compute statistics;
--	analyze table	cdreladr		compute statistics;

	truncate table	plan_table;

--	=================================================================
	explain plan	set statement_id = 'aaa'	for

	select /*+	merge (v) */	t.addr_pfx, v.aver
	from	adrStreet		t,
(
	select	addr_name,
			avg(addr_num)	aver
	from		cdreladr
	group by	addr_name
)					v
	where	t.addr_name = v.addr_name
	and	t.addr_type = 'RD'
	;

--	=================================================================
	explain plan	set statement_id = 'bbb'	for

	select /*+	no_merge (v) */	t.addr_pfx, v.aver
	from	adrStreet		t,
(
	select	addr_name,
			avg(addr_num)	aver
	from		cdreladr
	group by	addr_name

	union all

	select	addr_name,
			0
	from		adrName
)					v
	where	t.addr_name = v.addr_name
	and	t.addr_type = 'RD'
	;

--	=================================================================

	select * from explain_plan;
