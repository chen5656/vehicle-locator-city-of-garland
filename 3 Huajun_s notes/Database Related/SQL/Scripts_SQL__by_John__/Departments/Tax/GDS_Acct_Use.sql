--	=====================================================================
set echo		off
set timing		off
set sqlblanklines	on
set serveroutput	on	size 99999
set linesize	2000
set pagesize	9999
-- set pagesize	74
-- set pagesize	57
-- alter session set nls_date_format = 'yyyymmdd hh24miss'  
--	=====================================================================

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================

	select distinct a.acct_type, a.acct_use
	from	jdeacutis.tax_commercial_external	T,
		garland.gds_account			A
	where	a.pidn = substr(t.text, 9, 17);

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;

--	=====================================================================
/*	Acct_Use for Real Property

(
	'A11',
	'B11',
	'C11',
	'C12',
	'C13',
	'C14',
	'D10',
	'D20',
	'E12',
	'F10',
	'F20',
	'G10',
	'J30',
	'J51'
);

*/
--	=====================================================================
