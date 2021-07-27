	set echo 		off;
	set fetchrows;
	set charwidth;
	set stoponerror	on;
--	================================================================
--	What parcels on a specified Street
--	do not lie in the cluster of a specified Parcel
--	================================================================

	variable	 spec_parcel	number;
	execute	:spec_parcel :=	5700152;

	variable	 spec_street	varchar2(40);
	execute	:spec_street :=	'ASBURY';

--	=================================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table	for
--	=================================================================================

	select
		'GIS      '					"source",
		rpad(parcel_id,		 11)		"parcel",
		lpad(nvl(addr_num,   0), 05)		"num", 
		rpad(nvl(addr_pfx, ' '), 02)		"pf", 
		rpad(nvl(addr_name,' '), 20)		"name",
		rpad(nvl(addr_type,' '), 04)		"type",	 
		rpad(nvl(addr_sfx, ' '), 002)		"sf"
	from	garland.cdreladr
	where	parcel_id		in

(
	select parcel_id
	from	 garland.cdreladr
	where	 addr_name = :spec_street

	MINUS

(
	select parcel_id || '.000'			--  3.  Give me all the parcels
	from garland.water_ivr_parcel
	where cluster_id	in				--  4.  that are in that cluster
(
	select cluster_id					--  2.  What cluster is that parcel in
	from	garland.water_ivr_parcel
	where	parcel_id = :SPEC_PARCEL		--  1.  Here is the parcel that called in the complaint
)))
	order by 5, 6, 4, 7, 3, 2 ;

--	=================================================================================
--	select * from jdeacutis.explain_Plan;
--	insert into   jdeacutis.plan_table (object_owner, object_name) values ('JDEACUTIS', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Table;
--	select * from jdeacutis.explain_Index;
--	select * from jdeacutis.explain_Constraint;
--	select * from jdeacutis.explain_Column;
--	select * from jdeacutis.explain_Dependent;
--	select * from jdeacutis.explain_Analyze;
--	=================================================================================
	set echo		on;
	set fetchrows;
	set charwidth;

