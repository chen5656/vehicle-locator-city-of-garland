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

--	execute garland.CCS_LOAD_PRODUCTION ('STOP');

	create or replace procedure garland.CCS_LOAD_PRODUCTION (SPEC varchar2)	as

--	DECLARE
--	SPEC			varchar2(8)	:= 'STOP';

--	=====================================================================

	ACTION		varchar2(8);

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	OKAY			integer	:= 0;

	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN

	if	compile_only > 0		then
		return;
	end if;

	ACTION := nvl(SPEC, 'WAIT');

--	=================================================================================
	title := '****  CCS LOAD ****  ';	dbms_output.put_line(title);
--	=================================================================================

	OKAY := garland.CCS_LOAD_Quality_Check ('CCS');

	if	action = 'FORCE'		then
		null;
	elsif	OKAY < 0			then
		dbms_output.put_line ( '*** ACTION = ' ||action|| ' ***  ');
		dbms_output.put_line ( '*** ERROR ***  New CCS ADDRESS contains critical errors');
		dbms_output.put_line ( '*** ERROR ***  The CCS ADDRESS remains unchanged');
		return;
	end if;

	if	action in ('GO', 'FORCE')	then
		dbms_output.put_line ( '*** ACTION = ' ||action|| ' ***  ');

	elsif	action = 'STOP'		then
		dbms_output.put_line ( '*** ACTION = STOP ***  ');
		return;

	elsif to_char(sysdate,'DAY') in ('SATURDAY', 'SUNDAY')		then
		null;

	elsif	to_char(sysdate, 'hh24mi') between '0600' and '2000'		then
		dbms_output.put_line ( '*** ACTION = WAIT (6:00am - 8:00pm  Mon - Fri) *** ');
		return;
	end if;

--	===========================================================================

	script := 'truncate table garland.CCS_ADDRESS reuse storage';
	execute immediate (script);

	insert --+ append 
	into	 garland.CCS_ADDRESS
	(
		 address_id
		,addr_block
		,addr_number
		,addr_prefix
		,addr_name
		,addr_type
		,addr_suffix
		,addr_bldg
		,addr_unit
		,addr_city
		,addr_zip
		,addr_ten_code
		,council_dist
		,inspector_dist
		,police_beat
		,tax_account
		,tax_dcad
		,tax_prop_type
		,tax_zoning_code
		,tax_exemption
		,tax_deed_chng_date
		,tax_owner
		,tax_addr1
		,tax_addr2
		,tax_city
		,tax_state
		,tax_zip
		,tax_ten_code
		,tax_occupied
		,tax_legal_desc
		,ums_last_name
		,ums_first_name
		,ums_drivers_lic
		,ums_birth_date
		,intersection1
		,intersection2
		,parcel_id
		,street_id
		,block_id
		,road_id
		,intersect_id1
		,intersect_id2
		,tax_id
		,ums_id
		,record_seq
		,parcel_id_new
		,cdbg
	)

	select
		 address_id
		,addr_block
		,addr_number
		,addr_prefix
		,addr_name
		,addr_type
		,addr_suffix
		,addr_bldg
		,addr_unit
		,addr_city
		,addr_zip
		,addr_ten_code
		,council_dist
		,inspector_dist
		,police_beat
		,tax_account
		,tax_dcad
		,tax_prop_type
		,tax_zoning_code
		,tax_exemption
		,tax_deed_chng_date
		,tax_owner
		,tax_addr1
		,tax_addr2
		,tax_city
		,tax_state
		,tax_zip
		,tax_ten_code
		,tax_occupied
		,tax_legal_desc
		,ums_last_name
		,ums_first_name
		,ums_drivers_lic
		,ums_birth_date
		,intersection1
		,intersection2
		,parcel_id
		,street_id
		,block_id
		,road_id
		,intersect_id1
		,intersect_id2
		,tax_id
		,ums_id
		,record_seq
		,parcel_id_new
		,cdbg
	from	garland.CCS_ADDRESS_NEW;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Total CCS ADDRESS insert = ' || total_processed);

	COMMIT;

--	===========================================================================

	script := 'truncate table garland.CCS_IDENTIFIER reuse storage';
	execute immediate (script);

	insert
	--+	append
	into garland.CCS_IDENTIFIER
(
	CCS_ID,

	ADDR_NUMBER,
	ADDR_PREFIX,
	ADDR_NAME,
	ADDR_TYPE,
	ADDR_SUFFIX,

	TAX_LEGAL_DESC,
	TAX_OWNER,
	UMS_LAST_NAME,
	UMS_FIRST_NAME,

	GIS_ID,	
	TAX_ID,	
	UMS_ID,	

	ACTIVE,
	INACTIVE
)
	select

	CCS_ID,

	ADDR_NUMBER,
	ADDR_PREFIX,
	ADDR_NAME,
	ADDR_TYPE,
	ADDR_SUFFIX,

	TAX_LEGAL_DESC,
	TAX_OWNER,
	UMS_LAST_NAME,
	UMS_FIRST_NAME,

	GIS_ID,	
	TAX_ID,	
	UMS_ID,	

	ACTIVE,
	INACTIVE

	from	garland.CCS_IDENTIFIER_NEW;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Total CCS IDENTIFIER insert = ' || total_processed);

	COMMIT;

--	===========================================================================
/*
	script := 'analyze table garland.CCS_IDENTIFIER compute statistics';
	execute immediate (script);

	script := 'analyze table garland.CCS_ADDRESS compute statistics';
	execute immediate (script);
*/
--	===========================================================================

END;

