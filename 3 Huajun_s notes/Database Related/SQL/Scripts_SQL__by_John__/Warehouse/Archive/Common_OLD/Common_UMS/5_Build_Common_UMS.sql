--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
-- set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	=================================================================================

	alter session	set nls_date_format = 'yyyy-mm-dd';

	Truncate table	JDEACUTIS.Common_UMS	reuse storage;

--	=================================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table	for
--	=================================================================================

--	select count(*) from  

	insert --+ append
	into	 JDEACUTIS.Common_UMS

	select distinct
		b.address_id,
		b.addr_num,
		b.addr_pfx,
		b.addr_name,
		b.addr_type,
		b.addr_sfx,
		null, null,
		b.location_no,
		b.account_no,
		b.person_no,
		b.last_name,
		b.first_name,
		b.drivers_license,
		b.birth_date,
		null	
	from	garland.Basic_UMS		B,
(
	select address_id, 
		 max(effective_date)	effective_date
	from	garland.Basic_UMS
	group by address_id
)						U
	where	b.address_id 	= u.address_id
	and	b.effective_date	= u.effective_date
	and	translate(b.addr_num, '/1234567890','/') is null;

--	=================================================================================

	Commit;

--	=================================================================================
--	select * from jdeacutis.explain_Plan;
--	insert into   jdeacutis.plan_table (object_owner, object_name) values ('JDEACUTIS', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Table;
--	select * from jdeacutis.explain_Index;
--	select * from jdeacutis.explain_Constraint;
--	select * from jdeacutis.explain_Column;
--	select * from jdeacutis.explain_Dependent;
--	select * from jdeacutis.explain_Analyze;
--	=================================================================================

	analyze table	JDEACUTIS.Common_UMS	compute statistics;

--	===========================================================================

	select count(*)	"GARLAND"
	from	GARLAND.Common_UMS;

	select count(*)	"JDEACUTIS"
	from	JDEACUTIS.Common_UMS;

	select count(count(*))	"Dupes"
	from	JDEACUTIS.Common_UMS
	group by address_id
	having count(*) > 1;

/*
	select * from jdeacutis.common_ums
	where address_id in
(
	select address_id	
	from	JDEACUTIS.Common_UMS
	group by address_id
	having count(*) > 1
);
*/

--	===========================================================================
