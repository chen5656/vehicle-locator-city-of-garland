--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
--	=====================================================================

--	execute	jdeacutis.CCS_BACKUP ('GO');

	create or replace procedure	jdeacutis.CCS_BACKUP (SPEC  varchar2)	AS

--	DECLARE

--	=====================================================================

--	SPEC			varchar2(8)	:= 'GO';
	ACTION		varchar2(8);

	compile_only	integer	:= 0;

	script		varchar2(1000);
	title			varchar2(100);
	heading		varchar2(100);
	counter		integer	:= 0;
	today			integer;
	backup_date		integer;

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	ACTION := nvl(SPEC, 'WAIT');

--	=====================================================================
	title := '***  CCS BACKUP *** ';
	dbms_output.put_line(title);
--	=====================================================================

	select to_char(sysdate, 'J')		into today	from dual;
	select to_char(last_ddl_time, 'J')	into backup_date
	from all_objects 
	where object_name = 'CCS_ADDRESS' 
	and	owner 	= 'JDEACUTIS';

	if	action = 'FORCE'				then
		null;

	elsif	today - backup_date < 21		then	
		dbms_output.put_line ( '***  REPEAT BACKUP SUPPRESSED ***');
		return;
	end if;

	script := 'drop table jdeacutis.CCS_ADDRESS';
	execute immediate (script);
	script := 'create table jdeacutis.CCS_ADDRESS tablespace gis_data as select * from garland.CCS_ADDRESS';
	execute immediate (script);
	COMMIT;

	script := 'drop table jdeacutis.GDS_ACCOUNT';
	execute immediate (script);
	script := 'create table jdeacutis.GDS_ACCOUNT tablespace gis_data as select * from garland.GDS_ACCOUNT';
	execute immediate (script);
	COMMIT;

	script := 'drop table jdeacutis.GDS_EXEMPTION';
	execute immediate (script);
	script := 'create table jdeacutis.GDS_EXEMPTION tablespace gis_data as select * from garland.GDS_EXEMPTION';
	execute immediate (script);
	COMMIT;

	script := 'drop table jdeacutis.GDS_YEAR';
	execute immediate (script);
	script := 'create table jdeacutis.GDS_YEAR tablespace gis_data as select * from garland.GDS_YEAR';
	execute immediate (script);
	COMMIT;

	script := 'drop table jdeacutis.ADRRESULT_TAX_GDS';
	execute immediate (script);
	script := 'create table jdeacutis.ADRRESULT_TAX_GDS tablespace gis_data as select * from garland.adrResult_TAX_GDS';
	execute immediate (script);
	COMMIT;

	script := 'drop table jdeacutis.ADRRESULT_UMS_LOCATION';
	execute immediate (script);
	script := 'create table jdeacutis.ADRRESULT_UMS_LOCATION tablespace gis_data as select * from garland.adrResult_UMS_LOCATION';
	execute immediate (script);
	COMMIT;

--	=====================================================================

	select count(*) into counter from garland.CCS_ADDRESS;
	dbms_output.put_line ('CCS ADDRESS:   ' || counter);
	select count(*) into counter from jdeacutis.CCS_ADDRESS;
	dbms_output.put_line ('CCS ADDRESS:   ' || counter);

	select count(*) into counter from garland.GDS_ACCOUNT;
	dbms_output.put_line ('GDS ACCOUNT:   ' || counter);
	select count(*) into counter from jdeacutis.GDS_ACCOUNT;
	dbms_output.put_line ('GDS ACCOUNT:   ' || counter);

	select count(*) into counter from garland.GDS_EXEMPTION;
	dbms_output.put_line ('GDS EXEMPTION: ' || counter);
	select count(*) into counter from jdeacutis.GDS_EXEMPTION;
	dbms_output.put_line ('GDS EXEMPTION: ' || counter);

	select count(*) into counter from garland.GDS_YEAR;
	dbms_output.put_line ('GDS YEAR:      ' || counter);
	select count(*) into counter from jdeacutis.GDS_YEAR;
	dbms_output.put_line ('GDS YEAR:      ' || counter);

	select count(*) into counter from garland.ADRRESULT_TAX_GDS;
	dbms_output.put_line ('TAX GDS:       ' || counter);
	select count(*) into counter from jdeacutis.ADRRESULT_TAX_GDS;
	dbms_output.put_line ('TAX GDS:       ' || counter);

	select count(*) into counter from garland.ADRRESULT_UMS_LOCATION;
	dbms_output.put_line ('UMS LOCATION:  ' || counter);
	select count(*) into counter from jdeacutis.ADRRESULT_UMS_LOCATION;
	dbms_output.put_line ('UMS LOCATION:  ' || counter);

--	=====================================================================

END;

