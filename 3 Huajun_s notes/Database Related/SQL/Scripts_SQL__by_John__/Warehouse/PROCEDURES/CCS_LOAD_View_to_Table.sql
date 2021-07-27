--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================
--	Backup CCS_ADDRESSES
--	Load CCS_ADDRESSES
--	=====================================================================

--	execute	garland.CCS_LOAD_VIEW_TO_TABLE;

	create or replace procedure garland.CCS_LOAD_VIEW_TO_TABLE	AS

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

	OKAY			integer	:= 0;

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	title :=  '*** CCS LOAD VIEW TO TABLE  '; 
	dbms_output.put_line(title);

--	==============================================================================
--	drop COPY
--	insert MAKE into CCS

	title := 'LOAD MAKE TO CCS NEW';  dbms_output.put_line(title);

	script := 'truncate table garland.CCS_ADDRESS_NEW reuse storage';
	execute immediate (script);

	insert --+ append 
	into	 garland.CCS_ADDRESS_NEW
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
		,nvl(addr_prefix,' ')
		,addr_name
		,nvl(addr_type,  ' ')
		,nvl(addr_suffix,' ')
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
	from  garland.CCS_ADDRESS_MAKE
	where	addr_name > 'A'
	order by addr_name, addr_type, addr_prefix, addr_suffix, addr_number
	; 

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Insert Total = ' || total_processed);

	COMMIT;

--	==============================================================================

	insert into garland.CCS_ADDRESS_NEW
	(	address_id, addr_block,	addr_number, addr_prefix, addr_name, addr_type, addr_suffix,
		addr_city,  tax_deed_chng_date, record_seq	)
	values 
	(	999999, 990,	9999, ' ', 'DIRECTIONS ONLY', ' ', ' ',  
		'GARLAND', to_char(sysdate,'yyyy-mm-dd'), 999999	);

	COMMIT;

--	==============================================================================

END;

