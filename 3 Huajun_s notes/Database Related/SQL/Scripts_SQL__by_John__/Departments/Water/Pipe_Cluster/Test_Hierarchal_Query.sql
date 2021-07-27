	set echo off;
--	===============================================================================
/*
	create or replace view	garland.temp_view		AS
		select item01, item02, item03	
		from garland.gis_objects;

--	===============================================================================

	truncate table  garland.gis_objects   reuse storage;

	insert into garland.temp_view values (  '1', '0', 'x' );
	insert into garland.temp_view values (  '2', '1', ' ' );
	insert into garland.temp_view values (  '3', '2', ' ' );
	insert into garland.temp_view values (  '4', '3', ' ' );
	insert into garland.temp_view values (  '5', '4', ' ' );
	insert into garland.temp_view values (  '6', '26',' ' );
	insert into garland.temp_view values (  '7', '6', ' ' );
	insert into garland.temp_view values (  '8', '7', ' ' );
	insert into garland.temp_view values (  '9', '8', ' ' );

	insert into garland.temp_view values (  '11', '4',  ' ' );
	insert into garland.temp_view values (  '12', '11', ' ' );
	insert into garland.temp_view values (  '13', '12', ' ' );
	insert into garland.temp_view values (  '14', '13', ' ' );
	insert into garland.temp_view values (  '15', '14', ' ' );
	insert into garland.temp_view values (  '16', '15', ' ' );

	insert into garland.temp_view values (  '21', '0',  'x' );
	insert into garland.temp_view values (  '22', '21', ' ' );
	insert into garland.temp_view values (  '23', '22', ' ' );
	insert into garland.temp_view values (  '24', '23', ' ' );
	insert into garland.temp_view values (  '25', '24', ' ' );
	insert into garland.temp_view values (  '26', '25', ' ' );

*/
--	===============================================================================

	select 
		rpad(item01, 6)		item,
		rpad(item02, 6)		parent,
		rpad(item03, 6)		flag,
		lpad(level,  4)		levl,
		lpad(rownum, 4)		seq
	from garland.temp_view

--	-------------------------------------------------------------------------------

	where level 	=  1   
	or	item03 	= ' '

--	-------------------------------------------------------------------------------

	start with	item03 = 'x'

	connect by	prior item01 = item02
	;
--	===============================================================================
--	start with	item01	in ( '1',  '21' )
--	start with	item01	in ( select '1' from dual)
--		and	prior item03 = ' '
--	===============================================================================
