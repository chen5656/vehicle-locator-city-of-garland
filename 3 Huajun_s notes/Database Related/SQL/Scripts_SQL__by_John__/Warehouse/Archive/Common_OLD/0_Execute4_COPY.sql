--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
--	===========================================================================================

	select 'COPY COMMON GIS ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	truncate table	garland.Common_GIS	reuse storage;

	insert --+ append
			into	garland.Common_GIS
	select * 	from	jdeacutis.Common_GIS;

	commit;

--	===========================================================================================

	select 'COPY COMMON TAX ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	truncate table	garland.Common_TAX	reuse storage;

	insert --+ append
			into	garland.Common_TAX
	select * 	from	jdeacutis.Common_TAX;

	commit;

--	===========================================================================================

	select 'COPY COMMON UMS ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	truncate table	garland.Common_UMS	reuse storage;

	insert --+ append
			into	garland.Common_UMS
	select * 	from	jdeacutis.Common_UMS;

	commit;

--	===========================================================================================
