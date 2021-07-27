set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
--	===================================================================
--	Job series to rebuild Common_GIS table
--	used by CCS_ADDRESSES  (Code Compliance Address view)
--	===================================================================
 
	select 'BUILD COMMON GIS  '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\Common\BUILD_COMMON_GIS.sql


	select 'REMOVE DUPE GIS  '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\Common\REMOVE_DUPE_GIS.sql


	select 'GET INTERSECT ID  '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\Common\01_GET_INTERSECT_ID.sql


	select 'PUT INTERSECT ID  '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\Common\01_PUT_INTERSECT_ID.sql


	select 'UPDATE GIS INTERSECTIONS  '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\Common\01_UPDATE_GIS_INTERSECTIONS.sql


--	======================================================================
/*

	select * from JDEACUTIS.Common_GIS		where rownum < 11;

	select count(ltrim(intersect_id1)) intersect1, count(ltrim(intersect_id2)) intersect2 
	from jdeacutis.Common_GIS;	

	select * from user_dependencies  where name = 'CCS_ADDRESSES';

*/
--	===================================================================
