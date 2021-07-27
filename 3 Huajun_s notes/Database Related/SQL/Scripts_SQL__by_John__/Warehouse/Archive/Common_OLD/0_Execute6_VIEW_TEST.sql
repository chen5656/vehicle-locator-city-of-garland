	set echo off;
    set linesize	2000;
--	==============================================================================
--	Define view of Common tables

--	@c:\deacutis\scripts\warehouse\common\table_view\vw_CCS_ADDRESSES_MAKE_TEST.sql

--	==============================================================================
--	Load CCS ADDRESS table using above view

	select 'LOAD CCS_ADDRESS_TEST ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	truncate table  garland.CCS_ADDRESS_TEST  reuse storage;

	insert --+ append
	into	 garland.CCS_ADDRESS_TEST
	select * 
	from  jdeacutis.CCS_ADDRESSES_TEST_MAKE
--	from  garland.CCS_ADDRESSES_MAKE			--  T E S T I N G
	order by addr_name, addr_type, addr_prefix, addr_suffix, addr_number
	; 

	commit;

--	==============================================================================
--	Make adjustment to duplicate RECORD_SEQ in CCS_ADDRESS
--	select 'FIX DUPE RECORD SEQ ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;
--	@c:\deacutis\scripts\warehouse\Common\FIX_DUPE_RECORD_SEQ.sql
--	CCS_ADDRESS contains some muliple GIS/TAX key combinations
--	Some of these multipleS contain invalid UMS occupant info
--	Remove such CCS_ADDRESS records
--	select 'REMOVE WRONG OCCUPANT ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;
--	@c:\deacutis\scripts\warehouse\Common\REMOVE_EMPTY_OCCUPANT.sql

--	===========================================================================
--	Define CCS_ADDRESSES_TEST view as query of CCS_ADDRESS_TEST table

--	drop view				garland.CCS_Addresses_TEST;

	create or replace view	  garland.CCS_Addresses_TEST		
		as	select * from garland.CCS_Address_TEST;


--	==============================================================================

	select * 
	from garland.CCS_Addresses_TEST
	where	mod(record_seq,100) > 0;

--	==============================================================================
