--	ASSIGN CORNER XID

	set echo off;
--	=============================================================================
--	Assign Intersect IDs from Intersection table to Corner table
--	=============================================================================

	truncate table	gis_app_rowid	reuse storage;

	alter rollback segment	rb1		online;
	commit;
	set transaction	use rollback segment	rb1;

	insert into		gis_app_rowid
	(
		select	rownum,		--	row_seq
				rec_rowid		--	row_id
		from
	(
		select	c.rowid		rec_rowid
		from		intersection	x
		where		intersection_id like 'BB%'
		order by	addr1_name, addr1_type, addr2_name, addr2_type
	));

	alter rollback segment	rb1		offline;
	commit;
		
--	=============================================================================

declare

	do_compile		binary_integer	:= 01;
	this_seq		binary_integer	:= 0

cursor	read_Intersection		is

	select	intersection_id,
			node_id,
			road1_id,
			road2_id

	from		garland.gis_app_rowid	g,
			garland.Intersection	x

	where		g.row_seq	= this_seq
	and		x.rowid	= g.row_id;

begin

	if	do_compile > 0		then
		return;
	end if;

loop

	this_seq	:= this_seq + 01;

	open	read_Intersection;

	fetch	read_Intersection		into THIS;
	exit when	read_Intersection%notfound
	or		read_Intersection%notfound;

	close	read_Intersection;

	update	garland.Corner
	set		intersection_id	= this.intersection_id
			node_id		= this.node_id
	where		road1_id		= this.road1_id
	and		road2_id		= this.road2_id;

	commit;

end loop;

end;

--	=============================================================================
	set echo on;


