	set echo	off;
--	===================================================================================
--	generate adrEnding script from current adrEnding table

	select '	truncate table garland.adrEnding  reuse storage;' " "	from dual
	union all

	select '	insert into garland.adrEnding (name) values ( ''' || name || ''' );'
	" "
	from		( select name from garland.adrEnding order by 1)

	union all
	select '	commit;' " "  from dual
	;

--	===================================================================================
--	enhancement

--		name = 'FORD'	tail = null
--		name =  null	tail = 'ING'	
--		name =  null	tail = 'TON'	


--		Tail allows the creation of a addr_begin name w/out an addr_ending
--		Example:    addr_name = Worthing	addr_begin = Worth	addr_ending = null
--		Example:    addr_name = Wellington  addr_begin = Welling	`addr_ending = null

--	===================================================================================
--	look for missing name endings
--	=====================================================================================
/*

	select distinct addr_name  from garland.adrStreets  
	where addr_ending is null
	and	length(addr_name) >= 8;

*/

--	=====================================================================================
--	backup adrEnding table
--	=====================================================================================
/*

	truncate table	garland.gis_objects;

	insert into garland.gis_objects (item01, item02)
	select * from garland.adrEnding;

	commit;

*/

--	=====================================================================================
--	new endings to be added to table
--	=====================================================================================
/*

	insert into garland.adrEnding (name) values ( 'APPLE' );
	insert into garland.adrEnding (name) values ( 'MARIE' );
	insert into garland.adrEnding (name) values ( 'CYPRESS' );
	insert into garland.adrEnding (name) values ( 'BUNION' );
	insert into garland.adrEnding (name) values ( 'BURGH' );
	insert into garland.adrEnding (name) values ( 'BANKS' );
	insert into garland.adrEnding (name) values ( 'COACH' );
	insert into garland.adrEnding (name) values ( 'SQUARE' );
	insert into garland.adrEnding (name) values ( 'DAY' );
	insert into garland.adrEnding (name) values ( 'BREEZE' );
	insert into garland.adrEnding (name) values ( 'DOWNE' );
	insert into garland.adrEnding (name) values ( 'NECKER' );
	insert into garland.adrEnding (name) values ( 'GOLD' );
	insert into garland.adrEnding (name) values ( 'GLOW' );
	insert into garland.adrEnding (name) values ( 'BACK' );
	insert into garland.adrEnding (name) values ( 'MEDE' );
	insert into garland.adrEnding (name) values ( 'PIPER' );
	insert into garland.adrEnding (name) values ( 'DRAGON' );
	insert into garland.adrEnding (name) values ( 'HAMPTON );
	insert into garland.adrEnding (name) values ( 'OAK');
	insert into garland.adrEnding (name) values ( 'WATER');
	insert into garland.adrEnding (name) values ( 'WORTH');
	insert into garland.adrEnding (name) values ( 'SHED');
	insert into garland.adrEnding (name) values ( 'SCAPE');
	insert into garland.adrEnding (name) values ( 'HENGE' );
	insert into garland.adrEnding (name) values ( 'LOOK' );
	insert into garland.adrEnding (name) values ( 'CELLO' );
	insert into garland.adrEnding (name) values ( 'THORNE' );

	insert into garland.adrEnding (name) values ( 'GRANDE' );
	insert into garland.adrEnding (name) values ( 'LEIGH' );
	insert into garland.adrEnding (name) values ( 'BUSH' );
	insert into garland.adrEnding (name) values ( 'HALL' );
	insert into garland.adrEnding (name) values ( 'GARRY' );
	insert into garland.adrEnding (name) values ( 'ROBIN' );
	insert into garland.adrEnding (name) values ( 'WINKLE' );
	insert into garland.adrEnding (name) values ( 'CHALMERS' );
	insert into garland.adrEnding (name) values ( '' );


--	=====================================================================================
	set echo	on;
