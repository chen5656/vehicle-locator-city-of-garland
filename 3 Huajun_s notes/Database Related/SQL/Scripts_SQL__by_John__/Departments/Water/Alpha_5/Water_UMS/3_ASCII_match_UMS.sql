	set echo	off;
	set termout	off;
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;

	spool	c:\deacutis\extract\Water_UMS_Match.txt

--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

--	select count(*) from

(
	select distinct

		w.parcel_id			||','||		-- serial number
		w.rec_key			||','||
		u.rec_key			||','||

		w.addr_num			||','||
		w.form_pfx			||','||
		w.form_name			||','||
		w.form_type			||','||
		w.form_sfx			||','||

		u.addr_num			||','||
		u.form_pfx			||','||
		u.form_name			||','||
		u.form_type			||','||
		u.form_sfx			||','||

		' '				" "
	from	adrResult_Water			W,
		adrResult_UMS_Location		U

	where	w.addr_name		= u.addr_name
	and	w.addr_num		= u.addr_num

	and	w.addr_type		in (' ', u.addr_type)
	and	w.addr_pfx		in (' ', u.addr_pfx)
	and	w.addr_sfx		in (' ', u.addr_sfx)

	and	rtrim(w.addr_unit1) is null
	and	rtrim(u.addr_unit1) is null
	and	rtrim(w.addr_code1) is null
	and	rtrim(u.addr_code1) is null

);


--	=================================================================================

	spool off;

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

--	=================================================================================
	set echo	on;
	set termout	on;
