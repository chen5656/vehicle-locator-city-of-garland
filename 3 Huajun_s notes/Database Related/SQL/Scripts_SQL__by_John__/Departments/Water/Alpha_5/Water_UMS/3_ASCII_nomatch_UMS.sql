	set echo	off;
--	=================================================================================
--	PREPARE

--	Copy ADRRESULT_UMS_SAFE   into  ADRRESULT

--	Load GIS_OBJECTS with Loader\Alpha5_Acct_Serial

--	=================================================================================

	spool	c:\deacutis\extract\Water_Invalid_Address.txt

--	spool	c:\deacutis\extract\Water_UMS_NoMatch.txt

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select

--		count(*)

/*
		item02					"serial"
		rpad(rec_key,10)				"account",
		lpad(nvl(addr_num,   0),05)		"num", 
		rpad(nvl(addr_pfx, ' '),02)		"pf", 
		rpad(nvl(addr_name,' '),20)		"name",
		rpad(nvl(addr_type,' '),04)		"type",	 
		rpad(nvl(addr_sfx, ' '),02)		"sf"
*/

		item02			||','||	-- serial number
		rec_key			||','||
		addr_num			||','||
		addr_pfx			||','||
		addr_name			||','||
		addr_type			||','||
		addr_sfx			||','||
		' '				" "

	from	adrResult_Water		W,
		gis_objects			G

	where	w.rec_key	= g.item01			-- feb 2005

	and	g.item02 is not null			-- feb 2005

	and	w.verify_code < 55			-- feb 2005


/*
	and	not exists
(
	select 'x'
	from	garland.adrResult			U				-- PREPARE
 
	where	u.addr_name		= w.addr_name
	and	u.addr_num		= w.addr_num
	and	w.addr_type		in (' ', u.addr_type)
	and	w.addr_pfx		in (' ', u.addr_pfx)
	and	w.addr_sfx		in (' ', u.addr_sfx)
)
*/

	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num;


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




