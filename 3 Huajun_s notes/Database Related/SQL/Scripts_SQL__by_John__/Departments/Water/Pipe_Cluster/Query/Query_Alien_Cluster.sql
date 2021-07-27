	set echo 		off;
	set fetchrows;
	set charwidth;
	set stoponerror	on;
--	================================================================
--	Specify PARCELS that seem to lie outside an expected Cluster
--	Find out to which Clusters they were assigned
--	================================================================

	variable	 spec_parcels	varchar2(100);
	execute	:spec_parcels :=	' 5600613 5600614 5700154';

--	=================================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table	for
--	=================================================================================

	select
		rpad(c.cluster_id,	   08)	"cluster",
		rpad(a.parcel_id,		   11)	"parcel",
		lpad(nvl(a.addr_num,   0), 05)	"num", 
		rpad(nvl(a.addr_pfx, ' '), 02)	"pf", 
		rpad(nvl(a.addr_name,' '), 20)	"name",
		rpad(nvl(a.addr_type,' '), 04)	"type",	 
		rpad(nvl(a.addr_sfx, ' '), 02)	"sf"

	from	garland.cdreladr			A,
(
	select cluster_id, 
		 parcel_id || '.000'	parcel_id
	from garland.water_ivr_parcel
	where cluster_id	in			
(
	select cluster_id				
	from	garland.water_ivr_parcel
	where	instr (:spec_parcels, parcel_id) > 0
))							C

	where	a.parcel_id = c.parcel_id

	order by 1, 5, 6, 4 ,7, 3;

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
