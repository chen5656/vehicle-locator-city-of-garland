--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================

	update garland.ccs_address		A
	set   inspector_dist = 
(
	select distinct inspector_dist
	from garland.ccs_inspector_districts B
	where b.address_id = a.address_id
);

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('JDEACUTIS', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

	select count(inspector_dist) from garland.ccs_address;

--	=====================================================================
/*  

	select distinct inspector_dist+0 from garland.ccs_inspector_districts;

INSPECTOR_DIST
----------------
               1
               2
               3
               4
               5
               6
               7
               8
               9
              10
              21
              22
              23
              24
              25
*/
--	=====================================================================
