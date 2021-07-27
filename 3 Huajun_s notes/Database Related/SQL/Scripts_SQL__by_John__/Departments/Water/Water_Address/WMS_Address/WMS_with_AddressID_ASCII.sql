	set echo 		off;
	set fetchrows;
	set charwidth;
	set stoponerror	on;
--	=================================================================================
--	Load WMS extract (joe whitacre) into garland.gis_objects (26 items)
--	Append AddressID from gis.Address_GIS (item27)

--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================
	
	update garland.gis_objects		G
	set	item27 =
(
	select max(addressid)
	from	 garland.address_gis

	where	 streetnum		= to_number(g.item02)
	and	 streetprefix	= nvl(g.item03,' ')
	and	 streetname		= nvl(g.item04,' ')
	and	 streettype		= nvl(g.item05,' ')
	and	 rtrim(unit) is null
);
	
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

--	Rollback;
	Commit;

--	=================================================================================
	set echo		on;
	set fetchrows;
	set charwidth;
