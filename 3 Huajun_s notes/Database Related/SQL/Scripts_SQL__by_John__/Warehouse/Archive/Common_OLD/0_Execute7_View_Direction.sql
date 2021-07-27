	set echo off;
    	set linesize	2000;
--	=====================================================================
--	desc garland.common_record_seq
--	desc garland.common_address_keys;
--	=====================================================================

	@c:\deacutis\scripts\warehouse\common\ASSIGN_CODE_DISTRICT.sql 

--	=====================================================================

	insert into garland.Common_Record_Seq		
	values ( 0, 0, 0, 999999);				

--	=====================================================================

	insert into garland.Common_Address_Keys		values
		(	9999, ' ', 'DIRECTIONS ONLY', ' ', ' ', 
			null, null,  999999, null, null, null	);

--	=====================================================================

	insert into garland.CCS_Address	
	select * from garland.CCS_Addresses_MAKE
	where	addr_name like 'DIRECTION%'
	and	rownum < 2;


	update garland.CCS_Address
	set	address_id = 999999,
		record_seq = 999999
	where addr_name like 'DIRECT%';

	Commit;	
	
--	=====================================================================

--	select * from garland.CCS_Address
--	where addr_name like 'DIRECTION%';
	
--	=====================================================================

