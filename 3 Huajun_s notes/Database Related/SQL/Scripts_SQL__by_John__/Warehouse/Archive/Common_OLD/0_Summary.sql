	set linesize 2000;
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
	('ADRRESULT_TAX_GDS', 'ADRRESULT_UMS_LOCATION', 'GDS_ACCOUNT', 
	 'CCS_ADDRESS', 'TEMP_VIEW4')
	and	owner in ( 'GARLAND', 'JDEACUTIS' )
	and	object_type in ( 'TABLE', 'VIEW' )
	order by object_name, owner;

--	======================================================================

	select count(*) ccs_addr_bkup	from jdeacutis.ccs_address;
	select count(*) ccs_addr	from garland.ccs_address;
	select count(*) gds_acct	from garland.gds_account;
--	select count(*)  from garland.;
	select count(*) ar_tax		from garland.adrresult_tax_gds;
	select count(*) ar_location	from garland.adrresult_ums_location;
	select count(*) address		from gis.address;

--	======================================================================
