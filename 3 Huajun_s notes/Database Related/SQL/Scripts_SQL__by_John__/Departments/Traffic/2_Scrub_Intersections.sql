	set echo	off;
--	==============================================================
--	Clean up traffic intersections
--	from Sean extract
--	==============================================================

--	CHOOSE EITHER PRIMARY OR SECONDARY STREET	****************************
--	SET ROLLBACK ON / OFF

	update  	garland.temp_view

--	set	(	addr1_pfx, addr1_name, addr1_type, addr1_sfx, verify1	) = 

	set	(	addr2_pfx, addr2_name, addr2_type, addr2_sfx, verify2	) = 

(
	select	addr_pfx,  addr_name,  addr_type,  addr_sfx,  verify_code
	from		adrResult
	where		rec_key = key
);


--	=============================================================================
--	SHOW OUTPUT SAMPLE

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
		rpad(verify1,07)				"verify1",	
		rpad(verify2,07)				"verify2",	
		rpad(street1,20)				"street1",	
		rpad(street2,20)				"street2"	

	from  garland.temp_view  

	where	key between 101 and 200

--	and	intersects is	null

--	and	addr1_pfx > '0'
--	and	rownum < 11
	;

--	==============================================================

	ROLLBACK;

	Commit;

--	==============================================================
	set echo	on;
