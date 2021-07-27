--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
-- set pagesize	74;
-- set pagesize	57;
-- alter session set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	===========================================================================================

	select 'BUILD INTERSECTION  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	truncate table	garland.GIS_Temp4		reuse storage;

--	==========================================================================
--	BB	block-block
--	SS	street-street			(with or without prefix/suffix)
--	NN	name/type - name/type		(having removed  prefix/suffix)

--	SS = NN					(Ridgegate Dr, E Ridgegate Dr)
--	==========================================================================

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'a'	into jdeacutis.plan_table for
--	=====================================================================

	insert --+ append
	into	 garland.Temp_View4

	select
		s1_addr_name	strname1,
		s1_addr_type	strtype1,
		s1_addr_pfx		strpre1,
		s1_addr_sfx		strsuf1,
		s1_addr_block	strblok1,

		s2_addr_name	strname2,
		s2_addr_type	strtype2,
		s2_addr_pfx		strpre2,
		s2_addr_sfx		strsuf2,
		s2_addr_block	strblok2,

		'BB'			Intersect_Type,
		hub_node

	from	garland.Temp_View

	union

	select
		s1_addr_name	strname1,
		s1_addr_type	strtype1,
		s1_addr_pfx		strpre1,
		s1_addr_sfx		strsuf1,
		'0'			strblok1,

		s2_addr_name	strname2,
		s2_addr_type	strtype2,
		s2_addr_pfx		strpre2,
		s2_addr_sfx		strsuf2,
		'0'			strblok2,

		'SS'			Intersect_Type,
		hub_node

	from	garland.Temp_View

	union

	select
		s1_addr_name	strname1,
		s1_addr_type	strtype1,
		s1_addr_pfx		strpre1,
		s1_addr_sfx		strsuf1,
		'0'			strblok1,

		s2_addr_name	strname2,
		s2_addr_type	strtype2,
		s2_addr_pfx		strpre2,
		s2_addr_sfx		strsuf2,
		'0'			strblok2,

		'NN'			Intersect_Type,
		hub_node

	from	garland.Temp_View

	where	'0' < some (s1_addr_pfx, s1_addr_sfx, s2_addr_pfx, s2_addr_sfx)
	;


/*		
	and	'0' < some (s1_addr_pfx, s1_addr_sfx)
	and	'0' < some (s2_addr_pfx, s2_addr_sfx)
	and	'0' < some (s1_addr_pfx, s1_addr_sfx, s2_addr_pfx, s2_addr_sfx)

	and	' ' = all (s1_addr_pfx, s1_addr_sfx)
	and	' ' = all (s2_addr_pfx, s2_addr_sfx)
	and	' ' = all (s1_addr_pfx, s1_addr_sfx, s2_addr_pfx, s2_addr_sfx)
*/


--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

	COMMIT;

	analyze table garland.GIS_Temp4  compute statistics;

--	=====================================================================


