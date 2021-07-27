	set echo	off;
--	set timing	on;
--	=================================================================================
--	Verify Traffic Intersections against Intersection table

--	Flag whether Intersection exists
--	Update Street Qualifiers
--	=================================================================================

--	delete from temp_view
--	where	street1 is null 
--	or	street2 is null;
--	commit;

--	=================================================================================

	update	garland.temp_view
	set		addr1_pfx	= nvl(addr1_pfx,  ' '),
			addr2_pfx	= nvl(addr2_pfx,  ' '),
			addr1_sfx	= nvl(addr1_sfx,  ' '),
			addr2_sfx	= nvl(addr2_sfx,  ' '),
			addr1_type	= nvl(addr1_type, ' '),
			addr2_type	= nvl(addr2_type, ' ');
	commit;

--	=================================================================================

	truncate table	garland.plan_table	reuse storage;

--	explain plan set statement_id = ' '		into garland.plan_table	for

--	=================================================================================

	update	garland.Temp_View		V

	set	(	intersects,
			addr1_type,
			addr1_pfx,
			addr1_sfx,
			addr2_type,
			addr2_pfx,
			addr2_sfx
		)	
	=
(
	select
			'X',
			nvl(x.addr1_type, t.addr1_type),
			nvl(x.addr1_pfx,  t.addr1_pfx),
			nvl(x.addr1_sfx,  t.addr1_sfx),
			nvl(x.addr2_type, t.addr2_type),
			nvl(x.addr2_pfx,  t.addr2_pfx),
			nvl(x.addr2_sfx,  t.addr2_sfx)

	from		garland.Intersection	X

			,garland.temp_view	T
--			,garland.temp_view	V				-- TEST

	where		x.intersect_id		in
(
	select	max (xx.intersect_id)

	from		garland.Intersection	XX

	where		xx.intersect_id	like 'BB%'

	and		t.addr1_name	= xx.addr1_name
	and		t.addr2_name	= xx.addr2_name

	and		t.addr1_type	in (' ', xx.addr1_type)
	and		t.addr2_type	in (' ', xx.addr2_type)

--	and		t.addr1_pfx		in (' ', xx.addr1_pfx)
--	and		t.addr2_pfx		in (' ', xx.addr2_pfx)
--	and		t.addr1_sfx		in (' ', xx.addr1_sfx)
--	and		t.addr2_sfx		in (' ', xx.addr2_sfx)
)
	and		t.rowid	= v.rowid
)


--	where		key between 100 and 200			-- TEST
--	order by	1						-- TEST
;

--	==============================================================
--	SHOW SAMPLE

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
	where	key between 100 and 200
--	and	intersects is	null
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

--	==============================================================

--	ROLLBACK;

	COMMIT;

--	==============================================================
	set echo	on;
	set timing	off;

