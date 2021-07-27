	set echo	off;
--	=================================================================================

	truncate table	garland.plan_table	reuse storage;

--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for


--	SPECIFY   ADDR1 or ADDR2  ***********

	update	garland.temp_view				T
	set		(addr2_type, addr2_pfx) = 
(
	select	addr_type, addr_pfx
	from		adrResult
	where		rec_key = t.key
)	
	where		nvl(intersects,' ') = ' ';

--	-----------------------------------------------------------------------------------

	update	garland.temp_view	
	set		addr1_type = 'FRWY'  
	where		nvl(intersects,' ') = ' '
	and		addr1_name = 'I30';

	update	garland.temp_view	
	set		addr2_type = 'FRWY'  
	where		nvl(intersects,' ') = ' '
	and		addr2_name = 'I30';


	update	garland.temp_view	
	set		addr1_name = 'NAAMAN SCHOOL'  
	where		nvl(intersects,' ') = ' '
	and		addr1_name = 'NAAMAN';

	update	garland.temp_view	
	set		addr2_name = 'NAAMAN SCHOOL'  
	where		nvl(intersects,' ') = ' '
	and		addr2_name = 'NAAMAN';

--	=================================================================================

	select 
		rpad(key,05)				"key",
		rpad(intersects,4)			"intersect",
		rpad(nvl(addr1_pfx, ' '),02)		"pf", 
		rpad(nvl(addr1_name,' '),20)		"name",
		rpad(nvl(addr1_type,' '),04)		"type",	 
		rpad(nvl(addr1_sfx, ' '),02)		"sf",
		'|||'						" ",
		rpad(nvl(addr2_pfx, ' '),02)		"pf", 
		rpad(nvl(addr2_name,' '),20)		"name",
		rpad(nvl(addr2_type,' '),04)		"type",	 
		rpad(nvl(addr2_sfx, ' '),02)		"sf",
		'|||'						" ",
		rpad(street1,20)				"street1",	
		rpad(street2,20)				"street2"	

	from  garland.temp_view  
	where	key between 100 and 2000000
	and	nvl(intersects,' ') = ' '
--	and	rownum < 1
	;


--	=================================================================================
--	insert into garland.plan_table (object_owner, object_name) values ('GARLAND', '');

--	select * from garland.explain_Plan;

--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;


	COMMIT;
	ROLLBACK;

--	=================================================================================
	set echo	on;

