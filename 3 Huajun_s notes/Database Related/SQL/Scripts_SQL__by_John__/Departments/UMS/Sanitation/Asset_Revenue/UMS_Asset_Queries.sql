--* 
--* 
--* SWSRD ASSET QUERIES
--* 
--* 
--* 	Created by Therese Weel  Cayenta March 27 2001
--* 
--*  The following are a set of 8 asset queries used to retrieve GARLAND SWRSD
--*  assets and their attributes.  They use two procedures which are pre-loaded into
--*  the oracle database, 
--* 
--*  			FA_VALUE retrieves the fixed value attributes
--*   		ATTRIB_VALUE retrieves the asset atrributes.
--*  
--*  These must be queried natively from ORACLE  - they do not work over ODBC
--*  My suggestion is to use toad or another application that will allow these
--*  tables to be exported into a form recognized by Crystal. 
--* 
--* The 8 Queries are :
--*  
--*   SET  Front Load Containers
--*   FREE Front Load Containers
--* 
--* 	SET Recycling Front Load Containers
--*   FREE Front Load Containers
--* 
--* 	SET Compactors 
--* 	FREE Compactors
--* 
--* 	SET Roll off Containers
--*   FREE Roll off Containers
--* 
--*   
--*  To run these queries from TOAD 
--*   
--* 		1) Load this file  File Open
--* 		2) Run each query individually
--*         3) Once the query is complete right click in the data portion
--*            select Save-as and in addition to the default values tick
--* 		    the 'include column headders box'
--* 		4) Paste the information into a spreadhseet
--* 
--* 
--* 

	set echo off;
--	=======================================================

	truncate table	garland.plan_table;


	explain plan into garland.plan_table	set statement_id = 'a'		for

select distinct  a.location_no,a.asset_no,a.set_dt,a.ams_asset_tp,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SHARE') share_cont,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'ROUTE') route,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MULT') mult,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MON') MO,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'TUE') TU,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'WED') WD,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'THU') TH,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'FRI') FR,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SAT') SA,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SUN') SU,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'SIZE') sizes,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'CONT#') Container, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'OWNER') Owner,
b.house_no, b.street_pfx_dir, b.street_NM, b.street_NM_SFX, b.city,
b.sec_addr_id, b.sec_addr_range, f.person_lnm
from sfg.UM00155T a, sfg.um00100m b, sfg.AM00100m c, sfg.UM00250T e, sfg.UM00200M f
where 
a.location_no = e.location_no and
a.service_seq = e.service_seq and
e.account_no = f.account_no and
b.location_no = a.location_no and
a.asset_no = c.asset_no and
a.ams_asset_tp = c.asset_type and 
a.pull_dt is null and
a.ams_asset_tp  = 'FL'



	explain plan into garland.plan_table	set statement_id = 'b'		for

select distinct a.asset_no,a.ams_asset_tp, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'SIZE') sizes,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'CONT#') Container, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'OWNER') Owner,
f.person_lnm
from sfg.UM00155T a, sfg.AM00100m c, sfg.UM00250T e, sfg.UM00200M f
where 
a.location_no = e.location_no and
a.service_seq = e.service_seq and
e.account_no = f.account_no and
c.asset_no  = a.asset_no and
a.ams_asset_tp = c.asset_type and 
a.pull_dt is not null and   
c.asset_no  not in (select d.asset_no from um00155t d where d.pull_dt is null and d.ams_asset_tp = 'FL') and 
c.asset_type =  'FL'


	explain plan into garland.plan_table	set statement_id = 'c'		for

select distinct  a.location_no,a.asset_no,a.set_dt,a.ams_asset_tp,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SHARE') share_cont,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'ROUTE') route,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MULT') mult,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MON') MO,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'TUE') TU,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'WED') WD,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'THU') TH,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'FRI') FR,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SAT') SA,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SUN') SU,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'SIZE') sizes,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'CONT#') Container, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'OWNER') Owner,
b.house_no, b.street_pfx_dir, b.street_NM, b.street_NM_SFX, b.city,
b.sec_addr_id, b.sec_addr_range, f.person_lnm
from sfg.UM00155T a, sfg.um00100m b, sfg.AM00100m c, sfg.UM00250T e, sfg.UM00200M f
where
a.location_no = e.location_no and
a.service_seq = e.service_seq and
e.account_no = f.account_no and 
b.location_no = a.location_no and
a.asset_no = c.asset_no and
a.ams_asset_tp = c.asset_type and 
a.pull_dt is null and
a.ams_asset_tp  = 'CM'


	explain plan into garland.plan_table	set statement_id = 'd'		for

select distinct a.asset_no,a.ams_asset_tp, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'SIZE') sizes,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'CONT#') Container, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'OWNER') Owner,
f.person_lnm
from sfg.UM00155T a, sfg.AM00100m c, sfg.UM00250T e, sfg.UM00200M f
where 
a.location_no = e.location_no and
a.service_seq = e.service_seq and
e.account_no = f.account_no and
c.asset_no  = a.asset_no and
a.ams_asset_tp = c.asset_type and 
a.pull_dt is not null and   
c.asset_no  not in (select d.asset_no from um00155t d where d.pull_dt is null and d.ams_asset_tp = 'CM') and 
c.asset_type =  'CM'


	explain plan into garland.plan_table	set statement_id = 'e'		for


select distinct  a.location_no,a.asset_no,a.set_dt,a.ams_asset_tp,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SHARE') share_cont,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'ROUTE') route,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MULT') mult,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MON') MO,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'TUE') TU,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'WED') WD,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'THU') TH,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'FRI') FR,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SAT') SA,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SUN') SU,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'SIZE') sizes,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'CONT#') Container, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'OWNER') Owner,
b.house_no, b.street_pfx_dir, b.street_NM, b.street_NM_SFX, b.city,
b.sec_addr_id, b.sec_addr_range, f.person_lnm
from sfg.UM00155T a, sfg.um00100m b, sfg.AM00100m c, sfg.UM00250T e, sfg.UM00200M f
where
a.location_no = e.location_no and
a.service_seq = e.service_seq and
e.account_no = f.account_no and 
b.location_no = a.location_no and
a.asset_no = c.asset_no and
a.ams_asset_tp = c.asset_type and 
a.pull_dt is null and
a.ams_asset_tp  = 'RC'


	explain plan into garland.plan_table	set statement_id = 'f'		for


select distinct a.asset_no,a.ams_asset_tp, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'SIZE') sizes,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'CONT#') Container, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'OWNER') Owner,
f.person_lnm
from sfg.UM00155T a, sfg.AM00100m c, sfg.UM00250T e, sfg.UM00200M f
where 
a.location_no = e.location_no and
a.service_seq = e.service_seq and
e.account_no = f.account_no and
c.asset_no  = a.asset_no and
a.ams_asset_tp = c.asset_type and 
a.pull_dt is not null and   
c.asset_no  not in (select d.asset_no from um00155t d where d.pull_dt is null and d.ams_asset_tp = 'RC') and 
c.asset_type =  'RC'


	explain plan into garland.plan_table	set statement_id = 'g'		for


select distinct  a.location_no,a.asset_no,a.set_dt,a.ams_asset_tp,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SHARE') share_cont,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'ROUTE') route,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MULT') mult,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'MON') MO,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'TUE') TU,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'WED') WD,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'THU') TH,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'FRI') FR,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SAT') SA,
sfg.fa_value ('UM','IA',a.ext_asset_no,'XFACT','UM',sysdate,'SUN') SU,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'SIZE') sizes,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'CONT#') Container, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'OWNER') Owner,
b.house_no, b.street_pfx_dir, b.street_NM, b.street_NM_SFX, b.city,
b.sec_addr_id, b.sec_addr_range, f.person_lnm
from sfg.UM00155T a, sfg.um00100m b, sfg.AM00100m c, sfg.UM00250T e, sfg.UM00200M f
where 
a.location_no = e.location_no and
a.service_seq = e.service_seq and
e.account_no = f.account_no and
b.location_no = a.location_no and
a.asset_no = c.asset_no and
a.ams_asset_tp = c.asset_type and 
a.pull_dt is null and
a.ams_asset_tp  = 'RO'



	explain plan into garland.plan_table	set statement_id = 'h'		for


select distinct a.asset_no,a.ams_asset_tp, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'SIZE') sizes,
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'CONT#') Container, 
sfg.attrib_value(c.asset_area, c.asset_type,c.Asset_no,'OWNER') Owner,
f.person_lnm
from sfg.UM00155T a, sfg.AM00100m c, sfg.UM00250T e, sfg.UM00200M f
where 
a.location_no = e.location_no and
a.service_seq = e.service_seq and
e.account_no = f.account_no and
c.asset_no  = a.asset_no and
a.ams_asset_tp = c.asset_type and 
a.pull_dt is not null and   
c.asset_no  not in (select d.asset_no from um00155t d where d.pull_dt is null and d.ams_asset_tp = 'RO') and 
c.asset_type =  'RO'


--	======================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_analyze;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_cost;
--	select * from garland.explain_remote;
--	======================================================================
	set echo on;
