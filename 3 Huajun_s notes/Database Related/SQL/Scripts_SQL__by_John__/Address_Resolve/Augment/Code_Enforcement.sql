	set echo		off;
	set charwidth	160;
--	===================================================================================
--	Obtain Violation  info	for each CodeAddr result
--	Obtain Inspection year	for each CodeAddr result
--	===================================================================================

	drop	view	temp_view;	

	create view	temp_view
(
	codeaddr_rowid,
	report_year,
	source_table,
	case_number,
	violation_id,
	violation
)
	as	select item01, item02, item03, item04, item05, item06	
		from	 garland.gis_objects;

--	---------------------------------------------------------------------------------------------------

--	Truncate table	garland.gis_objects	reuse storage;		--	temp_view

--	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1	online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id = 'xxx' 	 into garland.plan_table	for

	insert into garland.temp_view

	select	a.rowid,
			to_char(i.inspection_date, 'yyyy'),
			'I'
			,i.case_number,
			v.violation_id,
			v.violation
	from		codeaddr@cdep.world		a,
			case_violation@cdep.world	v,
			inspection@cdep.world		i
	where		a.addr_id 		= i.addr_id
	and		v.case_number	= i.case_number

	union all

	select	a.rowid,
			to_char(c.complaint_date, 'yyyy'),
			'C'
			,c.case_number,
			v.violation_id,
			v.violation
	from		codeaddr@cdep.world		a,
			case_violation@cdep.world	v,
			complaint@cdep.world		c
	where		a.addr_id 		= c.addr_id
	and		v.case_number	= c.case_number
	;


--	select * from garland.explain_plan;

	commit;
	alter rollback segment rb1	offline;

--	===================================================================================
--	Generate ASCII output
--	===================================================================================
	set	termout off;

--	Spool	c:\deacutis\extract\CodeAddr.txt;

	explain plan set statement_id = 'yyy' 	 into garland.plan_table	for

	select '/year,source,case,name,type,prefix,suffix,number,parcel,verify,violation,describe'
	" " 
	from dual
	union 

	select	
	v.report_year		||','||
	v.source_table		||','||			--  inspection / complaint	
	v.case_number		||','||
	r.addr_name			||','||
	r.addr_type			||','||
	r.addr_pfx			||','||
	r.addr_sfx			||','||
	r.addr_num			||','||
	r.parcel_id			||','||
	r.verify_code		||','||
	v.violation_id		||','||
	v.violation	

	" "
	from	garland.adrResult_Extract	r,		--  adrResult
		garland.temp_view			v
	where	r.rec_rowid	= v.codeaddr_rowid;


	spool off;
	set	termout on;

--	===================================================================================

	select count(*) "adrResult"		from garland.adrResult_Extract;

	select count(*) "Temp_View"		from garland.Temp_View;

--	===================================================================================
	set echo	on;
	set charwidth;
