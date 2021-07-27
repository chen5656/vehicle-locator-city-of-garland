	set echo	off;	
	set timing	off;
--	=======================================================================================

	alter rollback segment rb_large	online;
	commit;
	set transaction use rollback segment rb_large;

--	=======================================================================================
--	update code_inspection with code_citation info
--	=======================================================================================

--	truncate table	plan_table		reuse storage;
--	explain plan	set statement_id = 'cit'	for

	update 	garland.syn_gis_table		i
	set	( 	issue_date,  comply_date)	=
(
	select	c.citation_issue_date,
			c.citation_comply_date
	from		nsa_code_citation		c

	where		c.case_number = i.case_number
);


--	=======================================================================================
--	update code_inspection with code_complaint info
--	=======================================================================================

--	explain plan	set statement_id = 'inst1'	for

	update syn_gis_table				--	remove all instigators
	set	instigator = null
	where	instigator is not null;


--	explain plan	set statement_id = 'inst2'	for

	update syn_gis_table		i		--	set instigator = complainant
	set	instigator  = 'C'
	where exists
(
	select 'x'
	from	 nsa_code_complaint	c
	where	 c.case_number = i.case_number
);


--	explain plan	set statement_id = 'inst3'	for

	update syn_gis_table				--	set instigator = inspector
	set	instigator = 'I'
	where	instigator is null;

--	=======================================================================================

--	select * from explain_plan;

--	Rollback;
	commit;
	alter rollback segment rb_large	offline;

--	analyze table	garland.NSA_CODE_INSPECT	compute statistics;

--	=======================================================================================
	set echo	on;	
	set timing	off;

