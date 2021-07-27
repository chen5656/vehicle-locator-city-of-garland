--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.BUILD_ALIAS;

--	create or replace procedure garland.BUILD_ALIAS		AS

	DECLARE

--	=====================================================================

	compile_only	integer	:= 01;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select '*** BUILD ALIAS ***'||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);

	garland.BUILD_ALIAS_FROM_STREET;

	garland.BUILD_ALIAS_FROM_SPECIFY;

	garland.BUILD_ALIAS_TRANSPOSE;

	garland.BUILD_ALIAS_ABBREVIATION;

	garland.BUILD_ALIAS_ABC;

	garland.BUILD_ALIAS_NONGAR;

	garland.BUILD_ALIAS_NONADR;

	garland.BUILD_ALIAS_COMPRESS;

END;
