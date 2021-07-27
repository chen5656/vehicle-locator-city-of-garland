
--	update adrResult Region ID = Council District

	truncate table	plan_table;
	explain plan	set statement_id = 'aaa'	for


	update adrResult		r
	set	Region_ID =
(
	select	council_id
	from		trvehrcl_region
	where		segment_id	= r.segment_id
);

	select * from explain_plan;


--	===========================================================================
--	update CodeAddr council district from adrResult

	truncate table	plan_table;
	explain plan	set statement_id = 'aaa'	for

	update	jdeacutis.CODEADDR	c
	set		council_district = 
(
	select	region_id
	from		adrResult			r
	where		r.rec_key	= c.addr_id
);

	select * from explain_plan;

--	===========================================================================