--	set echo 		off;
--	set charwidth	200;
--	==========================================================================
--	Load Name Corrections into Alias table
--	==========================================================================

--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = ' '		into garland.plan_table	for
--	=================================================================================

	select

	'	insert into garland.adrAlien_Insert_vw	values ( '

	|| alias_lo  || ', ' 	 || alias_hi	|| ', ' ||  nvl(addr_min,0) || ', '''
	|| alias_weight || ''', ''' || alias_how	|| ''''

	|| chr(10)	  ||'	'
	|| rpad(',''' || alias_pfx	|| '''', 05)	
	|| rpad(',''' || replace(alias_name,'''','''''') || '''', 35) 
	|| rpad(',''' || alias_type	|| '''', 08)	
	|| rpad(',''' || alias_sfx	|| '''', 05)	

	|| chr(10)	  ||'	'
	|| rpad(',''' || addr_pfx  || '''', 05)	
	|| rpad(',''' || replace(addr_name,'''','''''')	 || '''', 35) 
	|| rpad(',''' || addr_type || '''', 08)	
	|| rpad(',''' || addr_sfx  || '''', 05)	

	||chr(10)	  ||	'	);'

	" "
	from	(select * from
	(
	select distinct
		rtrim(alias_name) alias_name, rtrim(alias_type) alias_type, 
		rtrim(alias_pfx)  alias_pfx,  rtrim(alias_sfx)  alias_sfx, 
		rtrim(addr_name)  addr_name,  rtrim(addr_type)  addr_type, 
		rtrim(addr_pfx)   addr_pfx,   rtrim(addr_sfx)   addr_sfx, 
		alias_how,  alias_weight, alias_lo, alias_hi, addr_min
	from	garland.adrAlien

	where	alias_how	between :alias_method_lo  and :alias_method_hi

	)
	order by alias_how, addr_name	);

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

--	==========================================================================
--	set echo		on;
--	set charwidth;


--	desc adrAlias;
