	set echo	off;
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;		
	set transaction use rollback segment rb1;

--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	update adrResult_Alpha5			A
	set	 parcel_id = 
(
	select	item02
	from		gis_objects			G
	where		item01 = rec_key
)
	where not exists
(
	select '*'
	from	gis_objects				J
	where	j.item01 = a.rec_key
	group by item01
	having count(*) > 1
)
	;

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

--	Comment on table	garland.	is '' ;



--	=================================================================================
/*	Accounts occur multiple times
	Example:  644 Accounts occur 2 times each

	select counter, count(*)
	from
(
	select count(*) counter
	from	gis_objects
	group by item01
	having count(*) > 1
)
	group by counter;


COUNTER    COUNT(*)  
---------- ----------
         2        644
         3         29
         4          9
         5          1
        15          1

*/
--	=================================================================================
	set echo	on;

