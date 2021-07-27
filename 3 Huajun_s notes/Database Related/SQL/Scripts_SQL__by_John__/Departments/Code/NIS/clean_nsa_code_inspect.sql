
--	miscellaneous address cleaning of nsa_code_inspect tables

	set echo off;

/*


--	========================================================================================================

	select addr_name	
	from	nsa_code_inspect_1999
	where	addr_name like 'NORTHWEST VILLAGE%';

	update nsa_code_inspect_1999
	set	addr_name = 'NORTHWEST VILLAGE'
	where	addr_name like 'NORTHWEST VILLAGE%';
		
--	========================================================================================================
--	remove dime address remnant '00' corresponding to prefix/suffix

	select addr_name, replace(addr_name, ' 00')
	from	 nsa_code_inspect_1999
	where	 addr_name || ' ' like '% 00 %';

	update nsa_code_inspect_1999
	set	addr_name = rtrim (replace (addr_name, ' 00')) 
	where	addr_name || ' ' like '% 00 %'; 

--	============================================================================================================
--	process duplex ranges in nsa_code_inspect   (eg. 504-50600, 1201-120300)

	select	addr_name,
			substr (addr_name, 01, instr (translate (addr_name, '123456789','000000000'),' 0000-0000') + 09)  " "
	from		gis_app_addr
	where		instr (translate (addr_name, '123456789','000000000'), ' 0000-00000') > 0;


	update	gis_app_addr
	set		addr_name =	substr (addr_name, 01, 
					instr (translate (addr_name, '123456789','000000000'), ' 0000-0000') + 09)
	where		instr (translate (addr_name, '123456789','000000000'), ' 0000-00000') > 0
	;


	select	addr_name,
			substr (addr_name, 01, instr (translate (addr_name, '123456789','000000000'), ' 000-000') + 07)  " "
	from		gis_app_addr
	where		instr (translate (addr_name, '123456789','000000000'), ' 000-0000') > 0;

	update	gis_app_addr
	set		addr_name =	substr (addr_name, 01, 
					instr (translate (addr_name, '123456789','000000000'), ' 000-000') + 07)
	where		instr (translate (addr_name, '123456789','000000000'), ' 000-0000') > 0;


--	============================================================================================================

*/



--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for



--	select * from explain_plan;
--	select * from explain_analyze;
--	select * from explain_indexed;

--	rollback;
	commit;


--	========================================================================================================
