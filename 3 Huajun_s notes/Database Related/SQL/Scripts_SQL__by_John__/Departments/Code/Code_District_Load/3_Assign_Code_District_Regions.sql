	set echo 		off;
	set stoponerror	on;
--	=================================================================================

--	analyze table garland.code_district_new		compute statistics;
--	analyze table garland.parcel_convert		compute statistics;
--	analyze table garland.cdrelpar			compute statistics;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	update	garland.Code_District_NEW	CD

	set		(zip_code, council_id, police_beat)	=
(
	select	nvl(rtrim(p.zip_code),		c.zip_code),
			nvl(rtrim(p.council_id),	c.council_id),
			nvl(p.police_beat,		c.police_beat)

	from		garland.Code_District_NEW	C,
			garland.CDRELPAR			P,
			garland.Parcel_Convert		V

	where		c.rowid		= cd.rowid
	and		v.new_parcel_id	= c.parcel_id
	and		v.old_parcel_id	= p.parcel_id
);


--	Rollback;

	Commit;

--	=================================================================================
--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================
	set echo on;

