	set echo 		off;
	set fetchrows;
	set charwidth;
	set stoponerror	on;
--	=================================================================================
--	If citizen at specified PARCEL reports a busted pipe
--	then show all Verizon parcel-addresses that lie within that Cluster
--	=================================================================================

	variable	 spec_parcel	number;
	execute	:spec_parcel :=	5700152

--	=================================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table	for
--	=================================================================================

	select
		'VERIZON  '						"source",
		rpad(a.parcel_id,				12)	"parcel",				
		lpad(nvl(v.streetnum,     0), 	05)	"num", 
		rpad(nvl(v.streetprefix, ' '), 	02)	"pf", 
		rpad(nvl(v.streetname,   ' '), 	20)	"name",
		rpad(nvl(v.streettype,   ' '),	04)	"type",	 
		rpad(nvl(v.streetsuffix, ' '),	02)	"sf"

	from	garland.verizon_info	V,
		garland.cdreladr		A

	where	v.streetname	= a.addr_name
	and	v.streetnum		= a.addr_num

	and	a.parcel_id		in
(
	select parcel_id || '.000'			--  3.  Give me all the parcels
	from garland.water_ivr_parcel
	where cluster_id	in				--  4.  that are in that cluster
(
	select cluster_id					--  2.  What cluster is that parcel in
	from	garland.water_ivr_parcel
	where	parcel_id = :SPEC_PARCEL		--  1.  Here is the parcel that called in the complaint
))
	order by 5, 6, 4, 7, 3, 2 ;

--	=================================================================================
--f	select * from jdeacutis.explain_Plan;
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


