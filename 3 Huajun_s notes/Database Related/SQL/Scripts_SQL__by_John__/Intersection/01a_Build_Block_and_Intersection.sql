	set echo	off;
	set timing	off;
--	=========================================================================================
--	complete series for rebuilding the Block & Intersection tables
--	=========================================================================================

--	=========================================================================================
--	step 1		load Spoke table

--	ESRI extract	\\deacutis\loader\esri_spoke.dat
--	(Format:  trvehrcl mslink,  "from" node,  "to" node)

--	truncate table	GIS_TEMP1	reuse storage;		--  Spoke table

--	SQL*LOADER		\\deacutis\loader\esri_spoke1.ctl	("from" spokes)
--	SQL*LOADER		\\deacutis\loader\esri_spoke2.ctl	("to"   spokes)

--	=========================================================================================
--	step 3		create temporary table Views

	@c:\deacutis\scripts\intersection\view_Intersection.sql;		--	gis_objects


	@c:\deacutis\scripts\intersection\view_Spoke.sql;			--	gis_temp1	

	@c:\deacutis\scripts\intersection\view_Node.sql;			--	gis_temp2	

	@c:\deacutis\scripts\intersection\view_Corner.sql;			--	gis_temp3	

	@c:\deacutis\scripts\intersection\view_Twin_Compass.sql;		--	gis_temp4	

	@c:\deacutis\scripts\intersection\view_Non_Partial_Intersect.sql; --	gis_temp4	

	@c:\deacutis\scripts\intersection\view_Dupe_Intersect.sql; 		--	gis_temp4	


--	FYI	Other views are defined & used later

--	block_region_view			\\regions\block\10_Update_Block_regions				
	
--	intersection_region_view	\\regions\intersection\20_Update_Intersection_regions	

--	=========================================================================================
--	step 4		rebuild Block & Block Side tables

	select 'Rebuild Block & Block Side  ' || to_char (sysdate, 'Mon dd yyyy  hh24:mi') " " from  dual; 
	@c:\deacutis\scripts\adrTable\01_bld_adrBlock_Side.sql;	

--	=========================================================================================
--	step 5		update Spoke table by Node, Street & Block tables

	select 'Update Spoke                ' || to_char (sysdate, 'Mon dd yyyy  hh24:mi') " " from  dual; 
	@c:\deacutis\scripts\intersection\20_Update_Spoke.sql;

--	=========================================================================================
--	step 6		build Intersection table
--				build Corner table 

	select 'Build Intersect & Corner    ' || to_char (sysdate, 'Mon dd yyyy  hh24:mi') " " from  dual; 
	@c:\deacutis\scripts\intersection\10_Execute_Intersection.sql;

--	------------------------------------------------------------------------------------------

	analyze table	gis_objects		compute statistics;
--	analyze table	intersection	compute statistics;

	analyze table	gis_temp1	compute statistics;
	analyze table	gis_temp2	compute statistics;
	analyze table	gis_temp3	compute statistics;

	comment on table	gis_objects	is 'Intersection  table';
	comment on table	gis_temp1	is 'Spoke  table';
	comment on table	gis_temp2	is 'Node   table';
	comment on table	gis_temp3	is 'Corner table';

	select count(*) "Intersection" from Intersection;
	select count(*) "Spoke"		 from Spoke;
	select count(*) "Node" 		 from Node;
	select count(*) "Corner"	 from Corner;

	select count(*) "From"		from Spoke	where terminal = 'F';
	select count(*) "To"		from Spoke	where terminal = 'T';

--	=========================================================================================
--	step 9		remove Invalid Partial Intersections

	select 'Remove Invalid Partial     ' || to_char (sysdate, 'Mon dd yyyy  hh24:mi') " " from  dual; 
	@c:\deacutis\scripts\intersection\60_Remove_Invalid_Partial.sql;	

--	=========================================================================================
--	step 10		remove Duplicate Intersections

	select 'Remove Duplicate IDs       ' || to_char (sysdate, 'Mon dd yyyy  hh24:mi') " " from  dual; 

	@c:\deacutis\scripts\intersection\71_show_one_node_dupe.sql;	--	should not exist

	@c:\deacutis\scripts\intersection\72_show_many_node_dupe.sql;	--	should exist

	@c:\deacutis\scripts\intersection\70_Remove_Dupe_Intersection.sql;

	@c:\deacutis\scripts\intersection\72_show_many_node_dupe.sql;	--	should not exist

--	=========================================================================================
--	step 11		update Block Side Regions

	select 'Update Block Regions       ' || to_char (sysdate, 'Mon dd yyyy  hh24:mi') " " from  dual; 

	@c:\deacutis\scripts\regions\block\01_Block_app_rowid.sql;

	@c:\deacutis\scripts\regions\block\10_Update_Block_regions.sql;

--	=========================================================================================
--	REPORTS
--	=========================================================================================

	select 'Job Series Completed       ' || to_char (sysdate, 'Mon dd yyyy  hh24:mi') " " from  dual; 

/*
--	=========================================================================================
	Step	Table			Description
	----	-----			-----------

	1	gis_temp1		Spoke table

	2	gis_temp2		Node	table

	6	gis_temp3		Corner table

	6	gis_objects		Intersection table

	8	gis_temp4		Twin Compass table

	9	gis_temp4		Non Partial Intersect table

	10	gis_temp4		Dupe Intersection ID  table

	11	gis_app_rowid	Block Side table

	12	gis_app_rowid	Corner table

--	=========================================================================================
*/

	set echo	on;

