	set echo	off;
--	=================================================================================
--	Obtain UMS Location No that corresponds to Water Serial Number

--	PREPARATION:	LOAD ADRRESULT_WATER INTO ADRRESULT	<<<<<<<<<<<<<<<<<<<<<<<<<<<

--	=================================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;		
	set transaction use rollback segment rb1;

--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	update garland.temp_view1		W

	set		w.location = 			-- obtain location no
(
	select	max(u.location)			-- from UMS

	from		adrResult			R,
			garland.temp_view2	U

	where		r.rec_key	= ltrim(w.account,'0')	-- aR  water account = Water account
	and		u.serial	= w.serial			-- UMS water serial  = Water serial
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

	savepoint	xxx;	
--	Rollback;
	Commit;
	alter rollback segment rb1 offline;

--	Comment on table	garland.GIS_TEMP2		is 'ALPHA5 Serial & Account' ;
--	Comment on table	garland.GIS_OBJECTS	is 'UMS Account & Serial' ;

--	=================================================================================
--	how many Water Accounts have a UMS Account

	select count(location) "Water Locn" from garland.temp_view1;		

--	=================================================================================
	set echo	on;
