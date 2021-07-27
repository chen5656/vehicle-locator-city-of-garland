--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	=====================================================================

--	CCS_ADDRESS Table	is the current version
--	CCS_ADDRESS_MAKE View is the new version

--	CCS_LOAD will always run a quality control test on the CCS_ADDRESS_MAKE View.
--	If the test fails then only a FORCE action will permit loading to production CCS_ADDRESS.

--	By Default the production CCS_ADDRESS will NOT be loaded 
--	between 6:00am and 8:00pm on Monday - Friday

--	The GO and STOP actions override the Default action (WAIT) - pending the quality control check. 
--	The FORCE action will load production CCS_ADDRESS regardless of circumstances.

--	=====================================================================
--	execute	garland.CCS_LOAD ( 'STOP' );
--	execute	garland.CCS_LOAD ( 'GO' );
--	execute	garland.CCS_LOAD ( 'FORCE' );
--	execute	garland.CCS_LOAD ( 'WAIT' );	is the Default action
--	=====================================================================

--	execute garland.CCS_LOAD ('STOP');

	create or replace procedure garland.CCS_LOAD (SPEC varchar2)	as

--	DECLARE

--	=====================================================================

--	SPEC			varchar2(8)	:= 'STOP';

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	OKAY			integer	:= 0;

	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);
	action		varchar2(10);

BEGIN

	if	compile_only > 0		then
		return;
	end if;

	ACTION := SPEC;

--	=================================================================================
	title := '****  CCS LOAD ****  ';
	dbms_output.put_line(title);
--	=================================================================================

--	==============================================================================
--	drop COPY
--	insert MAKE into COPY

	title := 'LOAD MAKE TO COPY';  dbms_output.put_line(title);

	script := 'truncate table garland.CCS_ADDRESS_COPY reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

	insert --+ append 
	into	 garland.CCS_ADDRESS_COPY
	select * 
	from  garland.CCS_ADDRESS_MAKE
	order by addr_name, addr_type, addr_prefix, addr_suffix, addr_number
	; 

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Insert total = ' || total_processed);

	COMMIT;
				
--	==============================================================================

	OKAY := garland.CCS_LOAD_Quality_Check ('CCS');

	if	action = 'FORCE'		then
		null;
	elsif	OKAY < 0			then
		dbms_output.put_line ( '*** ERROR ***  New CCS ADDRESS contains critical errors');
		dbms_output.put_line ( '*** ERROR ***  The CCS ADDRESS remains unchanged');
		return;
	end if;

	if	action in ('GO', 'FORCE')	then
		dbms_output.put_line ( '*** action = ' ||action|| ' ***  ');

	elsif	action = 'STOP'		then
		dbms_output.put_line ( '*** action = STOP ***  ');
		return;

	elsif to_char(sysdate,'DAY') in ('SATURDAY', 'SUNDAY')		then
		null;

	elsif	to_char(sysdate, 'hh24mi') between '0600' and '2000'		then
		dbms_output.put_line ( '*** action = WAIT (6:00am - 8:00pm  Mon - Fri) *** ');
		return;
	end if;

--	===========================================================================

	garland.CCS_LOAD_VIEW_TO_TABLE;

	garland.CCS_LOAD_REMOVE_DUPE;

	garland.CCS_LOAD_DIRECTIONS;

	garland.CCS_LOAD_CODE_DISTRICT;

	garland.CCS_LOAD_IDENTIFIER;
--	garland.CCS_LOAD_RECORD_SEQ;

	script := 'analyze table garland.CCS_ADDRESS compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	===========================================================================

END;

