	set echo off;
--	=============================================================================
--	Assign Intersect IDs from Intersection table to Corner table
--	=============================================================================

	Truncate table	garland.GIS_App_RowID	reuse storage;

	alter rollback segment	rb1			online;
	set transaction	use rollback segment	rb1;

--	=========================================================================================================

--	explain plan  set statement_id = 'xxx'   for

	insert into	garland.GIS_App_RowID

	select	rownum,
			rec_rowid
	from	
(
	select	road1_id,
			road2_id,
			rowid		rec_rowid

	from		garland.Intersection
	where		x.intersection_id like 'BB%'
);

	commit;
	alter rollback segment	rb1			offline;

	analyze table	garland.gis_app_rowid	compute statistics;

--	======================================================================


declare

	do_compile		binary_integer	:= 01;

	this_seq		binary_integer	:= 0;
	total_update	binary_integer	:= 0;


cursor	Read_Intersection		is

	select	intersection_id,
			node_id,
			road1_id,
			road2_id
	from		garland.Intersection	x,
			garland.gis_app_rowid	g

	where		g.row_seq	= this_seq
	and		x.rowid	= g.row_id;
		
	READ		Read_Intersection%rowtype;

begin

	if	do_compile > 0		then
		return;
	end if;

loop
	this_seq	:= this_seq + 01;

	open	Read_Intersection;
	fetch	Read_Intersection		into READ;
	exit when	read_intersection%notfound
	or		read_intersection%notfound is null;
	close	Read_Intersection;

	Update	garland.Corner
	set		intersection_id	= read.intersection_id,
			node_id		= read.node_id
	where		road1_id	= read.road1_id	
	and		road2_id	= read.road2_id;

	commit;

	total_update := total_update + 01;

end loop;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'Total Updates =  ' total_update );

end;

--	=============================================================================
	set echo on;


