	set echo	off;
    set linesize	2000;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

--	===========================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	select 
			c.addr_number, c.addr_prefix, c.addr_name, c.addr_type, 
			c.tax_addr2,   g.acct_type
--			a.addr_num,    a.addr_pfx,    a.addr_name, a.addr_type 

	from	ccs_addresses	C,
		cdreladr		A,
		GDS_Account		G

	where	a.addr_name = 'MILLER'

	and	c.addr_name   (+)	= a.addr_name 
	and	c.addr_number (+)	= a.addr_num  

	and	g.addr_name	(+)	like  c.addr_name || '%'
	and	g.addr_num  (+)	= c.addr_number

	order by c.addr_number, c.addr_type, c.addr_prefix;

--	===========================================================================
--	insert into garland.plan_table(object_owner, object_name)values('GARLAND', '');

--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_index;
--	select * from garland.explain_table;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

--	===========================================================================
	set echo	on;


