	set echo	off;
--	---------------------------------------------------------------------------------
--	build NSA_CODE_CITATION extract
--	---------------------------------------------------------------------------------

--	This extract obtains almost nothing
--	Citation dates appear to be unavailable	

--	---------------------------------------------------------------------------------

	truncate table	garland.NSA_CODE_CITATION	reuse storage;

	alter rollback segment rb_large	online;
	commit;
	set transaction use rollback segment rb_large;

--	---------------------------------------------------------------------------------

--	truncate table	plan_table		reuse storage;
--	explain plan	set statement_id = 'test'		for

	insert	--+	append
	into		garland.nsa_code_citation

	select	c.case_number,
			c.citation_number,
			c.citation_issue_date,
			c.citation_comply_date

	from		citation@cdep.world		c,
			inspection@cdep.world		i

	where		c.case_number = i.case_number

	and		to_char (citation_issue_date, 'yyyy') = '2003'

	and		c.citation_number = 
		(	
			select	min (citation_number)
			from		citation@cdep.world
			where		case_number = i.case_number
		);

--	---------------------------------------------------------------------------------

--	select * from explain_plan;

--	Rollback;
	commit;
	alter rollback segment rb_large	offline;

	analyze table	garland.NSA_CODE_CITATION	compute statistics;

--	---------------------------------------------------------------------------------
	set echo	on;

