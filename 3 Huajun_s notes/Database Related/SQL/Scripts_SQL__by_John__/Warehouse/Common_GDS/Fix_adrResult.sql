	set echo	off;
--	===========================================================================
--	Fix parsing errors of unit info
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	I 30 A | 101   becomes   I 30 | 101A
--	===========================================================================
--	explain plan set statement_id =  'x1'	into garland.plan_table		for

	update  garland.adrResult	set
	
	addr_name	=	substr(addr_name, 01, instr(addr_name,' ', -1)),
	addr_unit1	=	addr_unit1 || ltrim(substr(addr_name, instr(addr_name,' ', -1)))

	where	do_parse like '%u%'
	and	do_parse like '%hiwy%'
	and	translate (addr_name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ','AAAAAAAAAAAAAAAAAAAAAAAAAA')
		like '% A';

--	================================================================================================
--	DUCK CREEK | A | 1   becomes  DUCK CREEK | 1A
--	================================================================================================
--	explain plan set statement_id =  'x2'	into garland.plan_table	for

	update  garland.adrResult	set

	addr_unit1 = addr_unit2 || addr_unit1,			-- "new unit1"
	addr_unit2 = null							-- "new unit2"
	where	do_parse like '%u%v%'
	and	addr_unit1 > '9'
	and	addr_unit2 < 'A';

--	================================================================================================
--	MARINA DR  E 23   becomes   MARINA | DR | 23E
--	================================================================================================
--	explain plan set statement_id =  'x3'	into garland.plan_table	for

	update  garland.adrResult	set

	addr_unit1 = addr_unit1 || ltrim(substr(appl_name, instr(appl_name,' ', -1,2),2))	-- "new unit"

	where	do_parse like '%u%'
	and	translate (appl_name, 	'NSEW ABCDFGHIJKLMOPQRTUVXYZ123456789',
						'XXXX AAAAAAAAAAAAAAAAAAAAAA000000000')
		like	'% X 0%';

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

--	===========================================================================
--	Verify Corrections

	select 
		rpad(appl_name, 30) appl,  
		rpad(addr_name, 20) name,	
		rpad(addr_code1,05) code1,  rpad(addr_unit1,05) unit1,
		rpad(addr_code2,05) code2,  rpad(addr_unit2,05) unit2		
	from	garland.adrResult
	where	rtrim(addr_unit1) > '0'
	and	rownum < 2222;

--	===========================================================================

--	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================


/*
--	================================================================================================
--	I 30 A | 101   becomes   I 30 | A101
--	================================================================================================

	select

		do_parse,rpad(addr_name,20) name,  
		rpad(addr_code1,05) code, rpad(addr_unit1,10) unit1, rpad(addr_unit2,10) unit2,
			
		rpad(substr(addr_name, 01, instr(addr_name,' ',-1)), 20)				"new name",

		rpad(addr_unit1 || ltrim(substr(addr_name, instr(addr_name,' ', -1))), 10)	"new unit"

	from	adrResult
	where	do_parse like '%u%'
	and	do_parse like '%hiwy%'

	and	translate (addr_name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ','AAAAAAAAAAAAAAAAAAAAAAAAAA')
		like '% A'

	and	rownum < 11;

--	================================================================================================
--	DUCK CREEK | A | A   becomes  DUCK CREEK | A1
--	================================================================================================

	select

		do_parse, rpad(addr_name,20) name,  
		rpad(addr_code1,10) code, rpad(addr_unit1,10) unit1, rpad(addr_unit2,10) unit2,

		rpad(addr_unit2 || addr_unit1,10)		"new unit"

	from	adrResult

	where	do_parse like '%u%v%'
	and	addr_unit1 > '9'
	and	addr_unit2 < 'A'
	and	rownum < 11;
	
--	================================================================================================
--	MARINA DR  E 23   becomes   MARINA | DR | E23
--	================================================================================================

	select

		rpad(do_parse,15) parse,  rpad(appl_name,25) appl, rpad(addr_name,20)		name,  

		rpad(addr_code1,10) code, rpad(addr_unit1,10) unit1, rpad(addr_unit2,10)	unit2,

		addr_unit1 || ltrim(substr(appl_name, instr(appl_name,' ', -1,2),2))		"new unit"

--		,addr_type


	from	adrResult
	where	do_parse like '%u%'


	and	translate (appl_name, 	'NSEW ABCDFGHIJKLMOPQRTUVXYZ123456789',
						'XXXX AAAAAAAAAAAAAAAAAAAAAA000000000')
		like	'% X 0%'

	and	rownum < 11;

--	================================================================================================
*/


--	================================================================================================
	set echo	on;

