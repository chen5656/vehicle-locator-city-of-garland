	set echo	off;
--	=================================================================================

	select max(mslink) "MSlink"  from cdreladr;

--	=================================================================================

	create or replace view  garland.temp_view  (last_mslink)	
				 as	select max(mslink)  from cdreladr;

--	=================================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;		
	set transaction use rollback segment rb1;

--	=================================================================================
--	explain plan set statement_id = ' '		into garland.plan_table	for

	insert into garland.cdreladr
	(	parcel_id,	addr_num, addr_pfx, addr_name, addr_type, addr_sfx, x_coord, y_coord, 
		map_grid,	mslink		)

	select	item01, item02, item03, item04, item05, item06, item07, item08, 
			item09, last_mslink + rownum 

	from		garland.gis_objects	G,
			garland.temp_view		V

	where		translate(item01, '123456789', '000000000') = '0000000.000'
	;

--	=================================================================================

	select a.mslink - g.counter	"Initial"
	from	 
	(select max(mslink) mslink from cdreladr)		A,
	(select count(*) counter   from gis_objects)	G;

	select count(*)    "Input"   from gis_objects;

	select max(mslink) "Final"  from cdreladr;

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

--	=================================================================================
--	Executions

--	Feb 4, 2004		MSlink:	69928 + 422 = 70350

--	=================================================================================
	set echo	on;

