--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================

--    truncate table garland.plan_table  reuse storage;
--    explain plan set statement_id = 'xxx' into garland.plan_table for

    update garland.water_ivr_valve   V
    set  valve_name = 
    (
      select valve_id from gis.water_valve   G
      where g.feature_id = v.valve_id
    );
   
--    select * from garland.explain_plan;

   select * from garland.water_ivr_valve where rownum < 11;
 



    
    