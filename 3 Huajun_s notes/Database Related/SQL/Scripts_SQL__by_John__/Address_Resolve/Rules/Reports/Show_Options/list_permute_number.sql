	set echo	off;
	set termout	on;

--	spool	c:\deacutis\scripts\address_resolve\reports\report_number_permute.sql;

--	for unverified app address, display valid number permutations in cdreladr

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'	for

	select	distinct
			'possible number  '	"PERMUTATION"
			,rpad(g.addr_num,07)	"invalid"
			,g.addr_pfx			"pf"
			,rpad(g.addr_name,20)	"street_name"
			,g.addr_type		"type"
			,g.addr_sfx			"sf"
			,' || '			" "
			,rpad(p.addr_num,05)	"valid"
			,p.addr_pfx			"pf"
			,rpad(p.addr_name,20)	"street_name"
			,p.addr_type		"type"
			,p.addr_sfx			"sf"
--			,rpad(rec_key,20)		"key"

	from		adrResult		g,
			adrPermute		p

	where		p.addr_name			=  g.addr_name
	and		p.addr_num			<> g.addr_num
	and		trunc (p.addr_num, -3)	= trunc (g.addr_num, -3)
	and		p.addr_permute		= adr_permute_number (g.addr_num)

	and		g.addr_num			<> trunc (g.addr_num, -2) 

	and		g.verify_code		=  53

	order by	rpad(g.addr_name,20),
			g.addr_type,
			g.addr_pfx,
			g.addr_sfx,
			rpad(g.addr_num,07);


--	select * from explain_plan;

--	spool off;
