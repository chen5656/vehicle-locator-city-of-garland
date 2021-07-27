	set echo off;
	set linesize 2000;	
--	==============================================================================
--	Define view of Common tables

--	@c:\deacutis\scripts\warehouse\table_view\vw_CCS_ADDRESSES_MAKE.sql
--	@c:\deacutis\scripts\warehouse\table_view\vw_CCS_ADDRESSES_MAKE_TEST.sql


--	==============================================================================
--	make backup of current CCS_ADDRESS

	drop table		garland.CCS_ADDRESS_COPY;
	create table	garland.CCS_ADDRESS_COPY  
				tablespace gis_data	nologging
	as	select * from garland.CCS_ADDRESS;

--	==============================================================================
--	Load CCS ADDRESS table using above view

	select 'LOAD CCS_ADDRESS ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;
    
	truncate table  garland.CCS_ADDRESS  reuse storage;

	insert --+ append 
	into	 garland.CCS_ADDRESS
	select * 
	from  garland.CCS_ADDRESSES_MAKE
	order by addr_name, addr_type, addr_prefix, addr_suffix, addr_number
	; 

	commit;

--	==============================================================================
--	Make adjustment to duplicate RECORD_SEQ in CCS_ADDRESS

	select 'FIX OWNER ADDRESS    '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\Common\FIX_OWNER_ADDR.sql

	select 'FIX DUPE RECORD SEQ ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;
	@c:\deacutis\scripts\warehouse\Common\FIX_DUPE_RECORD_SEQ.sql

--	===========================================================================
--	Define CCS_ADDRESSES view as query of CCS_ADDRESS table
--	drop view			garland.CCS_Addresses;
--	create or replace view	  garland.CCS_Addresses
--		as	select * from garland.CCS_Address;
--	==============================================================================

--	select * from garland.CCS_Addresses	where mod(record_seq,100) > 0;

--	==============================================================================
