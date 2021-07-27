	set echo 		off;
	set fetchrows	111;
--	================================================================
--	Find the cluster that contains a specified PARCEL
--	and show all parcel-addresses that lie within that cluster
--	================================================================

	variable	 spec_name		varchar2(40);
	execute	:spec_name :=	'ASBURY';

	variable	 spec_number	number;
	execute	:spec_number :=	0;
--	execute	:spec_number :=	637;

--	=================================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table	for
--	=================================================================================

	select
		rpad(c.cluster_id,	   07)	"cluster",		-- 1
		rpad(a.parcel_id,		   11)	"parcel",		-- 2
		lpad(nvl(a.addr_num,   0), 05)	"num", 		-- 3
		rpad(nvl(a.addr_pfx, ' '), 02)	"pf", 		-- 4
		rpad(nvl(a.addr_name,' '), 20)	"name",		-- 5
		rpad(nvl(a.addr_type,' '), 04)	"type",	 	-- 6
		rpad(nvl(a.addr_sfx, ' '), 002)	"sf"			-- 7
	from	garland.cdreladr			A,
(
	select cluster_id, 
		 parcel_id || '.000'	parcel_id	
	from garland.water_ivr_parcel
	where cluster_id	in		
(
	select cluster_id			
	from	garland.water_ivr_parcel	p,
		garland.cdreladr			a
	where	p.parcel_id = a.parcel_id	
	and	a.addr_name	= :SPEC_NAME
	and	:SPEC_NUMBER in (0, a.addr_num)
))							C
	Where	a.parcel_id = c.parcel_id

	Order by 1, 5,6,4,7,3, 2;

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
	set fetchrows;



