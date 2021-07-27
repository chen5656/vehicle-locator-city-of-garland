	set echo	off;
--	=======================================================================================================
--	read Corner View, which contains corner Intersection pointers (where intersection id like 'BB%')
--	read the primary intersection block (block1)
--	if the primary block region is empty, then update it with the secondary block region (block2)
--	=======================================================================================================

declare

	do_compile			number 	:= 01;
	commit_size			number	:= 100;

	commit_count		number	:= 0;
	this_seq			number	:= 0;

	empty_id			char(01)	:= '.';

	intersection_region	varchar2(20);
	block1_region		varchar2(20);


cursor read_corner		is

	select	intersect_rowid,
			block1_rowid
	from		corner		c,
			gis_app_rowid	g
	where		g.row_seq	= this_seq
	and		g.row_id	= c.rowid;

	CORNER	read_corner%rowtype;


begin

	if	do_compile > 0		then
		return;
	end if;


loop

	this_seq := this_seq + 01;

	open	read_corner;
	fetch	read_corner		into corner;
	exit when	read_corner%notfound
		or	read_corner%notfound is null;
	close read_corner;

	select nvl(region, empty_id)
	into	 intersection_region
	from	 Intersection_Region_view
	where	 rowid = corner.intersect_rowid;

	if	intersection_region <= empty_id		then

		select nvl(region, empty_id)
		into	 block1_region
		from	 Block_Region_View
		where	 rowid = corner.block1_rowid;

		if	block1_region > empty_id		then

			update Intersection_Region_view
			set	 region = block1_region
			where	 rowid = corner.intersect_rowid;

			commit_count := commit_count + 01;
			if	commit_count > commit_size	then
				commit;
				commit_count := 0;
			end if;
		end if;

	end if;

end loop;

	close	read_corner;

	commit;

end;

