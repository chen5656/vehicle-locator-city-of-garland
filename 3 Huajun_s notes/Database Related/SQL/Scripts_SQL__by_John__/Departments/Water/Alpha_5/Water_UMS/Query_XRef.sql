	set echo	off;
--	=================================================================================
--	Build Final Water / UMS CrossRef	=	Water Account - UMS Location No
--	=================================================================================

--	PREPARATION:	Load adrResult_Alpha5  into adrResult	<<<<<<<<<<<<<<<<<<<<<

--	=================================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;		
	set transaction use rollback segment rb1;

--	=================================================================================
	explain plan set statement_id = ' '		into garland.plan_table	for


	select count(count(*))		from


--	select count(*) from

(

	select  a.rec_key		WW, 		--  Water Account
		  u.rec_key		UU		--  UMS Location No

	from	garland.adrResult				A,
		garland.adrResult_UMS_Location	U,
		garland.temp_view2			V	-- UMS serial#, location#, address

	where	u.rec_key	 = ltrim(v.location,'0')	-- Location No
	and	u.segment_id = a.segment_id			-- mslink

	and	rtrim(a.addr_unit1) is null
	and	rtrim(u.addr_unit1) is null
	and	rtrim(a.addr_code1) is null
	and	rtrim(u.addr_code1) is null




--	union 

--	select account,		 
--		 location			
--	from	 garland.GIS_Temp2
--	where	location > '0'
)


	group by WW
	having count(distinct location) > 1

--	group by UU
--	having count(distinct account) > 1

;

--	=================================================================================
--	insert into garland.plan_table (object_owner, object_name) values ('GARLAND', '');

	select * from garland.explain_Plan;
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

--	Comment on table	garland.	is '' ;

--	=================================================================================
	set echo	on;

