--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
--	==============================================================================
--	Build COMMON_ADDRESS_KEYS  table

	select 'DEFINE VIEWS  '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\address_keys\0_DEFINE_VIEWS.sql


	select 'BUILD COMMON ADDRESS KEYS  '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\address_keys\1_BUILD_COMMON_ADDRESS_KEYS.sql


	select 'COPY TO PRODUCTION  '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\address_keys\2_COPY_TO_PRODUCTION.sql


	select 'REMOVE NULL UMS  ' || to_char(sysdate,'hh24:mi') " " from dual;
	@c:\deacutis\scripts\warehouse\address_keys\2A_REMOVE_NULL_UMS.sql


	select 'ALTERATIONS  '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\address_keys\3_ALTERATIONS.sql


	select 'ASSIGN RECORD SEQUENCE  '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\address_keys\4_ASSIGN_RECORD_SEQ.sql


--	select 'DISPLAY RESULTS  '|| to_char(sysdate,'hh24:mi')  " " from dual;
--	@c:\deacutis\scripts\warehouse\address_keys\9_DISPLAY_RESULTS.sql


	select count(*) ADDR_KEYS from garland.COMMON_ADDRESS_KEYS;
	select count(*) REC_SEQ from garland.COMMON_RECORD_SEQ;

--	==============================================================================
