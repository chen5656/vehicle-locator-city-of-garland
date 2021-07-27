	set echo		off;
	set linesize	2000;
	set pagesize	200;
	set sqlblanklines	on;
--	======================================================================
--	Copy  CCS ADDRESS to backup (JDEACUTIS)
--	Load  GDS_ACCOUNT
--	Scrub TAX Address
--	Scrub UMS Address
--	Load  UMS Keys

--	======================================================================
--	make backup (jdeacutis) of current version (garland) of CCS_ADDRESS 
--	======================================================================
--	Load CCS_ADDRESS BACKUP
	select 'LOAD CCS ADDRESS BACKUP ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

--	@c:\deacutis\scripts\warehouse\common\LOAD_CCS_ADDRESS_BACKUP.sql 

--	======================================================================
--	Load GDS_ACCOUNT
--	Load GDS_YEAR
	select 'LOAD GDS Account ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

--	@c:\deacutis\scripts\warehouse\common\LOAD_GDS_ACCOUNT.sql 

--	@c:\deacutis\scripts\warehouse\common\LOAD_GDS_YEAR.sql 
--	VERIFY EXTERNAL_ACCESS FORMAT AGAINST ACTUAL ASCII FORMAT <<<<<<<<<<<

--	======================================================================
--	Scrub GDS_Account
	select 'SCRUB GDS Account ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

--	@c:\deacutis\scripts\address_resolve\jobs\90_COMMON_TAX.sql 

--	======================================================================
--	Scrub UMS_Location
	select 'SCRUB UMS LOCATION ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

--	@c:\deacutis\scripts\address_resolve\jobs\90_COMMON_UMS.sql 

--	======================================================================
--	Get UMS Keys
	select 'GET UMS KEYS ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

--	@c:\deacutis\scripts\warehouse\common\common_ums\1_GET_UMS_KEYS.sql 

--	======================================================================
--	confirm AdrResult update
/*

	select
			rpad(owner,		12)					object_owner,
			rpad(object_name, 25)					object_name,
			rpad(object_type, 08)					type, 
			to_char(last_ddl_time, 'Mon dd,yyyy hh24:mi')	last_ddl_time
			,'   ' " "
			,to_char(created, 'Mon dd,yyyy hh24:mi')		create_time 
	from ALL_Objects
	where	object_name in 
	('ADRRESULT_TAX_GDS', 'ADRRESULT_UMS_LOCATION', 'GDS_ACCOUNT', 'GDS_ACCOUNT_EXTERNAL',
	 'CCS_ADDRESS', 'TEMP_VIEW4')
	and	owner in ( 'GARLAND', 'JDEACUTIS' )
	and	object_type in ( 'TABLE', 'VIEW' )
	order by object_name, owner;
*/
--	======================================================================
