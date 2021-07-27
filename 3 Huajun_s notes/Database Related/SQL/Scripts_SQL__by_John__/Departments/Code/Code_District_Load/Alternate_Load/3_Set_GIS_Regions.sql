--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';

--	================================================================
--	analyze table jdeacutis.code_district_new		compute statistics;
--	analyze table jdeacutis.parcel_convert		compute statistics;
--	analyze table jdeacutis.cdrelpar			compute statistics;

--	=================================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table	for
--	=================================================================================
	update	jdeacutis.Code_District		C
	set		(zip_code, council_id, police_beat)	=
(
	select	rtrim(p.zip_code),
			rtrim(p.council_id),
			p.police_beat
	from		garland.CDRELPAR		P
	where		p.parcel_id = c.parcel_id_old
)
	where exists
(
	select	'x'
	from		garland.CDRELPAR		P
	where		p.parcel_id = c.parcel_id_old
)
	and	zip_code	is null 
	and	council_id	is null 
	and	police_beat	is null
;


	Commit;

--	=================================================================================
--	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Table;
--	select * from jdeacutis.explain_Index;
--	select * from jdeacutis.explain_Constraint;
--	select * from jdeacutis.explain_Column;
--	select * from jdeacutis.explain_Dependent;
--	select * from jdeacutis.explain_Analyze;
--	=================================================================================
	set echo on;