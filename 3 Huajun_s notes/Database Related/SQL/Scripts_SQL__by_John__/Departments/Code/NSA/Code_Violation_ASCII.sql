	set echo		off;
	set termout		off;
	set timing		on;
	set charwidth	200;
	set fetchrows	;
--	===========================================================================

--	EXTRACT BASIC CODE VIOLATION INFO INTO ASCII FORMAT

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	insert into	garland.plan_table (object_name,object_owner) values ( '' , '' );

--	alter rollback segment rb1 online;
--	commit;
--	set transaction use rollback segment rb1;

--	explain plan set statement_id =	'xxx'		into garland.plan_table	for
--	===========================================================================
/*
	truncate table	garland.gis_objects	reuse storage;

	insert into	garland.gis_objects	(	
			item01, 
			item02, item03, item04, item05, item06, 
			item07, item08, item09,
			item10			)

--	----------------------------------------------------------------------------
--	select	count(*)

	select	r.parcel_id,
			r.addr_num,	r.addr_pfx, r.addr_name, r.addr_type, r.addr_sfx,
			v.case_number, v.violation_id, v.violation,
			r.verify_code

	INCOMPLETE
--	===========================================================================

	spool c:\deacutis\extract\code_violation.txt;

	select 'Parcel,Number,Prefix,Street,Type,Suffix,Case,Violation,Description,Verify' 	" "
	from	dual
	union all

	select
		r.parcel_id		||','||			
		r.addr_num		||','||
		r.addr_pfx 		||','||
		r.addr_name 	||','||
		r.addr_type 	||','||
		r.addr_sfx		||','||
		v.case_number 	||','||
		v.violation_id 	||','||	
		v.violation		||','||
		r.verify_code

	spool	off;
*/
--	===========================================================================

	spool c:\deacutis\extract\code_violation.txt;

	select 'Parcel,Number,Prefix,Street,Type,Suffix,Case,Violation,Description,Verify'  " "
	from	dual
	union all

	select
		r.parcel_id		||','||			
		r.addr_num		||','||
		r.addr_pfx 		||','||
		r.addr_name 	||','||
		r.addr_type 	||','||
		r.addr_sfx		||','||
		v.case_number 	||','||
		v.violation_id 	||','||	
		v.violation		||','||
		r.verify_code

	from	codeaddr@cdep.world		a,
		case_violation@cdep.world	v,
		inspection@cdep.world		i,
		garland.adrResult			r

	where	i.addr_id		= a.addr_id
	and	i.case_number	= v.case_number
	and	r.rec_rowid		= a.rowid;

	spool	off;

--	===========================================================================
	select * from garland.explain_plan;

--	ROLLBACK;
--	commit;
--	alter rollback segment rb1 offline;
--	===========================================================================

	set echo		on;
	set termout		on;
	set timing		off;
	set charwidth;
	set fetchrows;
