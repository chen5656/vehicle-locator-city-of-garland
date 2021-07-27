	set echo 		off;
	set fetchrows;
	set charwidth;
	set stoponerror	on;
--	=================================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table	for
--	=================================================================================

	select
		max(length(a.addressid))		adrid,
		max(length(a.parcelid))			pid,
		max(length(u.location_no))		lid,

		max(length(a.streetnum))		num,
		max(length(a.streetprefix))		pfx,
		max(length(a.streetname))		name,
		max(length(a.streettype))		type,
		max(length(a.streetsuffix))		sfx,

		max(length(r.zone))			zone,
		max(length(r.basin))			basin

	from	gis.ADDRESS				A,
		garland.Temp_View1		R,	-- Regions
		garland.Temp_View			U	-- UMS Location

	where	r.address_id	= rtrim(a.addressid)
	and	u.parcel_id		= a.parcelid || '.000'
	;


--	=================================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('JDEACUTIS', '');
--	delete   from jdeacutis.plan_table where object_name like 'SDE%' or object_name like 'GDB%';

--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Column;
--	select * from jdeacutis.explain_Table;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Indexed;

--	select * from jdeacutis.explain_Index;
--	select * from jdeacutis.explain_Constraint;
--	select * from jdeacutis.explain_Dependent;
--	=================================================================================
	set fetchrows;
	set charwidth;

