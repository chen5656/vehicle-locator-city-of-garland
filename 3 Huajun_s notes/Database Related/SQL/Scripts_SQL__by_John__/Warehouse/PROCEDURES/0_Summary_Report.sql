--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
-- set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	======================================================================
--	confirm AdrResult update

	select
			rpad(owner,		12)					object_owner,
			rpad(object_name, 25)					object_name,
			rpad(object_type, 08)					type, 
			to_char(last_ddl_time, 'Mon dd,yyyy hh24:mi')	last_ddl_time
			,'   ' " "
			,to_char(created, 'Mon dd,yyyy hh24:mi')		create_time 
	from ALL_Objects

	where	object_name in 
	(
	'ADDRESS',	'GDS_ACCOUNT', 'GDS_EXEMPTION', 'GDS_YEAR', 'BASIC_UMS', 
	'CCS_ADDRESS', 'COMMON_GIS',	'COMMON_TAX',	'COMMON_UMS', 
	'COMMON_ADDRESS_KEYS',	'COMMON_RECORD_SEQ', 
	'ADRRESULT_TAX_GDS',	'ADRRESULT_UMS_LOCATION',	'TEMP_VIEW4'
	)

	and	owner in ( 'GARLAND', 'JDEACUTIS', 'GIS' )
	and	object_type in ( 'TABLE', 'VIEW' )

	order by owner, object_name;

--	======================================================================

	select count(*) ccsg_addresses	from garland.ccs_addresses;
	select count(*) ccsj_addresses	from jdeacutis.ccs_addresses;
	select count(*) ccsg_address		from garland.ccs_address;
	select count(*) ccsj_address		from jdeacutis.ccs_address;
	select '=============' " " from dual;

	select count(*) address			from gis.address;
	select count(*) commong_gis		from garland.common_gis;
	select count(*) commonj_gis		from jdeacutis.common_gis;
	select count(ltrim(intersect_id1)) intersection from jdeacutis.Common_GIS;	
	select '=============' " " from dual;

	select count(*) ar_tax			from garland.adrresult_tax_gds;
	select count(*) ar_tax_55		from garland.adrresult_tax_gds where verify_code = 55;
	select count(*) gds_account		from garland.gds_account;
	select count(*) commong_tax		from garland.common_tax;
	select count(*) commonj_tax		from jdeacutis.common_tax;
	select '=============' " " from dual;

	select count(*) ar_ums			from garland.adrresult_ums_location;
	select count(*) ar_ums_55		from garland.adrresult_ums_location where verify_code = 55;
	select count(*) basic_ums		from garland.basic_ums;
	select count(*) commong_ums		from garland.common_ums;
	select count(*) commonj_ums		from jdeacutis.common_ums;
	select '=============' " " from dual;

	select count(*) address_keys		from garland.common_address_keys;
	select count(*) record_seq		from garland.common_record_seq;

--	======================================================================
