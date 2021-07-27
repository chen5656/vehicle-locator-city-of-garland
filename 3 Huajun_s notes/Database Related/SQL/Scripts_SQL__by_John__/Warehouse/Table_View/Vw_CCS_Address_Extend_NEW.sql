--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	alter session	set nls_date_format = 'yyyymmdd';  
--	=====================================================================

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

	create or replace view garland.CCS_ADDRESS_EXTEND	as

	select  
		A.*,
		acct_use							landuse,

		decode(sign(instr(tax_owner,' OF ')), 1,' ',  
		decode(sign(instr(tax_owner,' AT ')), 1,' ',
		substr(tax_owner,01,instr(tax_owner,' ') -1)))	tax_last_name,

		decode(sign(instr(tax_owner,' OF ')), 1,' ',  
		decode(sign(instr(tax_owner,' AT ')), 1,' ',
		substr(tax_owner,01,instr(tax_owner,' ') +1)))	tax_first_name

	from	garland.ccs_address	A,
		garland.gds_account	T
	where	a.tax_id = t.account+0
	;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================