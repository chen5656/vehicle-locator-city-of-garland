	set echo		off;
	set linesize	2000;
	set pagesize	200;
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
	('ADRRESULT_TAX_GDS', 'ADRRESULT_UMS_LOCATION', 'GDS_ACCOUNT', 'GDS_ACCOUNT_EXTERNAL',
	 'CCS_ADDRESS', 'COMMON_GIS', 'COMMON_TAX', 'COMMON_UMS', 'TEMP_VIEW4')
	and	owner in ( 'GARLAND', 'JDEACUTIS' )
	and	object_type in ( 'TABLE', 'VIEW' )
	order by object_name, owner;

--	======================================================================

	select count(*) address		from gis.address; 
	select count(*) gds_acct	from garland.gds_account; 
	select count(*) ar_tax		from garland.adrresult_tax_gds; 
	select count(*) ar_ums		from garland.adrresult_ums_location; 
	select count(*) common_gis_g	from garland.common_gis; 
	select count(*) common_gis_j	from jdeacutis.common_gis; 
	select count(*) common_tax_g	from garland.common_tax; 
	select count(*) common_tax_j	from jdeacutis.common_tax; 
	select count(*) common_ums_g	from garland.common_ums; 
	select count(*) common_ums_j	from jdeacutis.common_ums; 
	select count(*) ccs_address_j	from jdeacutis.ccs_address; 
	select count(*) ccs_address_g	from garland.ccs_address; 


--	======================================================================
