	set echo off;
--	======================================================================================
--	Assign values for specific region to Block_Side & Intersection tables
--	This job series must be executed for each individual region (council, beat, code, etc)
--	======================================================================================

--	======================================================================================
--	PRIOR JOBS	

--		Rebuild Block & Block_Side tables
--		Assign Block Side regions per CDRELPAR table
--		Rebuild Intersection table

--		c:\deacutis\scripts\regions\Assign_CDRELPAR_Region.sql;
--		c:\deacutis\scripts\adrTable\01_Bld_Block_Side.sql;
--		c:\deacutis\scripts\Intersection\01_Build_Block_and_Intersection.sql;
--	======================================================================================


--	Obtain ESRI ASCII extract of all Centerlines lying completely within single Regions
--	SQL*LOAD extract to GIS_OBJECTS table  (TRVEHRCL mslink + ESRI region id)


--	select 'Block Region Views' || to_char( sysdate, 'mon dd yyyy hh24:mi' )  " " from dual;
--	@c:\deacutis\scripts\regions\block_intersection\01_BLOCK_REGION_VIEWS.sql;


--	select 'Block Side Rowid' || to_char( sysdate, 'mon dd yyyy hh24:mi' )  " " from dual;
--	@c:\deacutis\scripts\regions\block_intersection\02_BLOCK_SIDE_ROWID.sql;


--	select 'Block Region All' || to_char( sysdate, 'mon dd yyyy hh24:mi' )  " " from dual;
--	@c:\deacutis\scripts\regions\block_intersection\11_BUILD_REGION_ALL.sql;


--	select 'Build Region One' || to_char( sysdate, 'mon dd yyyy hh24:mi' )  " " from dual;
--	@c:\deacutis\scripts\regions\block_intersection\12_BUILD_REGION_ONE.sql;


--	select 'Extend Region One' || to_char( sysdate, 'mon dd yyyy hh24:mi' )  " " from dual;
--	@c:\deacutis\scripts\regions\block_intersection\13_EXTEND_REGION_ONE.sql;


--	select 'Assign Block Region' || to_char( sysdate, 'mon dd yyyy hh24:mi' )  " " from dual;
--	@c:\deacutis\scripts\regions\block_intersection\21_ASSIGN_BLOCK_REGION.sql;


--	select 'Intersection Region Rowid' || to_char( sysdate, 'mon dd yyyy hh24:mi' )  " " from dual;
--	@c:\deacutis\scripts\regions\block_intersection\03_INTERSECTION_REGION_ROWID.sql;


--	select 'Assign Intersection Region' || to_char( sysdate, 'mon dd yyyy hh24:mi' )  " " from dual;
--	@c:\deacutis\scripts\regions\block_intersection\22_ASSIGN_INTERESECTION_INTERSECTION.sql;


	set echo on;
