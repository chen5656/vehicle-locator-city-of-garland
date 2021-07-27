	set echo	off;
	set termout	off;
	set charwidth	100;
--	===========================================================================

--	PREPARATION:	Copy adrResult_CodeAddr	into adrResult_Extract;
--				/Documents and Settings / Common SQL / Copy Table

	select comments from user_tab_comments  where table_name = 'ADRRESULT_EXTRACT';

--	===========================================================================

	alter session	set nls_date_format = 'yyyy-mm-dd';

	Truncate table	garland.GIS_Objects	reuse storage;

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

--	===========================================================================
--	explain plan set statement_id = 'extract'		into garland.plan_table	for

--	select count(*)  from

	insert --+ append
	into	 garland.GIS_Objects  (item01, item02, item03)
(
	select i.case_number 
		,a.rowid
		,i.inspection_date

	from	cog.inspection@cdep.world	I,
		cog.codeaddr@cdep.world		A

	where	i.addr_id	= a.addr_id
	and	i.inspection_date		between to_date ('Oct 01, 2003', 'mon dd, yyyy')
						and	  to_date ('Oct 31, 2004', 'mon dd, yyyy')
);

--	===========================================================================

	commit;
	alter rollback segment rb1 offline;

	analyze table	garland.GIS_Objects   compute statistics;

	comment on table	garland.GIS_Objects  is 'Code Inspect Address 10-2003 to 10-2004';	--  SPECIFY

--	===========================================================================

	spool	c:\deacutis\extract\Code_Violation_Address.dat;

--	explain plan set statement_id = 'report'		into garland.plan_table	for

--	select count(*)

	select 'CaseNo;ViolationID;Violation;Inspect Date;AdrNum;AdrPrefix;AdrName;AdrType;AdrSuffix;MsLink'
		 " "	from dual
	union  all

	select item01 ||';'|| v.violation_id ||';'|| v.violation ||';'|| item03	||';'||
		 r.addr_num ||';'|| r.addr_pfx ||';'|| r.addr_name ||';'|| r.addr_type ||';'||  
		 r.addr_sfx ||';'|| r.segment_id


	from	GIS_Objects					C,
		cog.Case_Violations@cdep.world	V,

		adrResult_Extract				R
--		adrResult_CodeAddr			R


	where	r.rec_key	= c.item02
	and	c.item01	= rtrim(v.case_number);

	spool	off;

--	===========================================================================
--	insert into garland.plan_table(object_owner, object_name) values('GARLAND', '');

--	select * from garland.explain_plan;

--	execute  explain_more;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_column;
--	select * from garland.explain_dependent;
	select * from garland.explain_analyze;

--	===========================================================================
	set echo	on;
	set termout	on;
	set charwidth;
