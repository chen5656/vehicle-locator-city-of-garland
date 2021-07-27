--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================
--	set jdeacutis phone = garland phone
--	=====================================================================

--    analyze table jdeacutis.code_district  compute statistics;
--    analyze table garland.code_district  compute statistics;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set statement_id = 'aaa '	into jdeacutis.plan_table for
--	=====================================================================

    update jdeacutis.code_district    J
    set nuisance_phone = 
(
    select nuisance_phone
    from   
    (
    select nuisance_inspector, max(nuisance_phone) nuisance_phone
    from garland.code_district 
    group by nuisance_inspector
    having count(distinct nuisance_phone) = 1   
    )   G
    where g.nuisance_inspector = j.nuisance_inspector
);

--	explain plan set statement_id = 'bbb '	into jdeacutis.plan_table for
--	=====================================================================

    update jdeacutis.code_district    J
    set rental_phone = 
(
    select rental_phone
    from   
    (
    select rental_inspector, max(rental_phone)  rental_phone
    from garland.code_district 
    group by rental_inspector
    having count(distinct rental_phone) = 1   
    )   G
    where g.rental_inspector = j.rental_inspector
);  

	COMMIT;
	
--	=====================================================================
--	select * from jdeacutis.explain_Plan;

--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('JDEACUTIS', '');
--	delete   from jdeacutis.plan_table where object_name like 'SDE%' or object_name like 'GDB%';

--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;

--	select * from jdeacutis.explain_Table;
--	select * from jdeacutis.explain_Index;
--	select * from jdeacutis.explain_Constraint;
--	select * from jdeacutis.explain_Dependent;
--	select * from jdeacutis.explain_Column;
--	=====================================================================
