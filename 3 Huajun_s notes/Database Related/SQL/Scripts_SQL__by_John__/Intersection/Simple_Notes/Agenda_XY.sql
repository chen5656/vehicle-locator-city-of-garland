set linesize 2000;
--	==============================================================================
--	Extract First & Last XY for each ROAD record from TOOLBOX extract
--	==============================================================================

declare
	compile_only		integer	:= 01;
	is_eof			integer	:= 00;
	is_objectid			integer	:= 00;
	this_objectid		integer;
	first_xcoord		integer;
	first_ycoord		integer;
	last_xcoord			integer;
	last_ycoord			integer;

cursor	READ_ROAD_XY		is
	select objectid, xcoord, ycoord  
	from	 jdeacutis.ROAD_COORDINATE_EXTERNAL);

	ROAD	 READ_ROAD_XY%rowtype;

begin
	if	compile_only > 0		then
		return;
	end if;

	open	READ_ROAD_XY;
	fetch	READ_ROAD_XY	into ROAD;
	if	READ_ROAD_XY%notfound	
	or	READ_ROAD_XY is null		then
		is_eof := 09;
	end if;

while is_eof = 00					loop

	this_objectid	:= road.objectid;
	first_xcoord	:= round(road.xcoord);
	first_ycoord	:= round(road.ycoord);
	is_objectid		:= 0;

while	road.objectid = this_objectid		loop
while	is_objectid = 00				loop

	last_xcoord		:= round(road.xcoord);
	last_ycoord		:= round(road.ycoord);

	fetch	READ_ROAD_XY	into ROAD;
	if	READ_ROAD_XY%notfound		then
		is_eof := 01;
		exit;
	end if;

end loop;

	exit when	is_eof := 09;

	insert into garland.ROAD_NODE_BLOCK ( OBJECTID, XCOORD, YCOORD)
					values	( this_objectid, first_xcoord, first_ycoord);

	insert into garland.ROAD_NODE_BLOCK ( OBJECTID, XCOORD, YCOORD)
					values	( this_objectid, last_xcoord,  last_ycoord);

	exit when	is_eof := 01;
end loop;

	Commit;
end;

