--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================
--	
--	=====================================================================

--	execute	garland.CCS_LOAD_DIRECTIONS;

	create or replace procedure garland.CCS_LOAD_DIRECTIONS	AS

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select '*** CCS LOAD DIRECTIONS   ' into heading from dual; 
	dbms_output.put_line(heading);

--	=====================================================================
/*
	insert into garland.COMMON_RECORD_SEQ
	values ( 0, 0, 0, 999999);				

	insert into garland.COMMON_ADDRESS_KEYS	
	values
		(	9999, ' ', 'DIRECTIONS ONLY', ' ', ' ', 
			null, null,  999999, null, null, null	);
*/
--	=====================================================================

	insert into garland.CCS_ADDRESS_NEW
	(	  address_id, addr_block, addr_number, addr_name, addr_city,  tax_deed_chng_date, record_seq		)
	values 
	(	   999999,   990,   9999,  'DIRECTIONS ONLY',  'GARLAND', to_char(sysdate,'yyyy-mm-dd'), 999999	);

--	=====================================================================

	update garland.CCS_ADDRESS_NEW
	set	address_id = 999999,
		record_seq = 999999
	where addr_name like 'DIRECT%';

	COMMIT;
	
--	=====================================================================

END;

--	=====================================================================
--	insert into garland.CCS_Address	
--	select * from garland.CCS_Addresses_MAKE
--	where	addr_name like 'DIRECTION%'
--	and	rownum < 2;
--	=====================================================================

