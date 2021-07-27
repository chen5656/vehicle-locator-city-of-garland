	set echo	off;
	set termout	on;

--	for unverified application address, display possible address number gaps in cdreladr

--	===================================================================================

	@c:\deacutis\scripts\adrTable\bld_adrGap.sql;

--	===================================================================================

--	spool	c:\deacutis\scripts\address_resolve\reports\report_address_gap.sql;

	select	distinct
			'address    '	"ADDRESS GAP"
			,g.addr_num		"number"
			,g.addr_pfx		"pf"
			,g.addr_name	"street name"
			,g.addr_type	"type"
			,g.addr_sfx		"sf"
			,g.verify_code	"vc"
--			,rpad(rec_key,20)	"key"

	from		adrResult		g,
			adrGap		a

	where		g.verify_code	< 50
	and		g.addr_name		= a.addr_name
	and		g.addr_type		= a.addr_type
	and		g.addr_pfx		= a.addr_pfx
	and		g.addr_sfx		= a.addr_sfx
	and		g.addr_num		= a.addr_num;


--	spool off;

