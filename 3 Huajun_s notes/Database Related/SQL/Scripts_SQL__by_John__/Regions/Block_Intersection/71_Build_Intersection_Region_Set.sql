	set echo		off;
	set serveroutput	on
--	==================================================================
--	build region list for each intersection node id
--	for display in Excel spreadsheet (Bettes)
--	==================================================================

--		truncate table	gis_temp4	reuse storage;		--  region set

declare

		do_compile		binary_integer	:= 0;

		seq			binary_integer	:= 0;
		inserts		binary_integer	:= 0;

		prev_node_id	varchar2(80);
		prev_kind		varchar2(80);
		prev_region		varchar2(80);

		show_regions	varchar2(80);

cursor	read_intersection_region	is

		select	x.node_id, x.kind, x.region
		from		garland.intersection_region_view	x,
				garland.gis_app_rowid			r

		where		r.row_seq	= seq
		and		r.row_id	= x.rowid;
	
		LOOK		read_intersection_region%rowtype;

begin

	if	do_compile > 0		then
		return;
	end if;

loop

	seq := seq + 01;

	open	read_intersection_region;
	fetch	read_intersection_region	into look;
	exit when	read_intersection_region%notfound
		or	read_intersection_region%notfound is null;

	if	look.node_id = prev_node_id			then
		if	look.region <> prev_region
		and	look.region  > '0'			then
			show_regions := show_regions ||','|| look.region;
		end if;

	else
		if	prev_node_id is not null		then
			insert into gis_temp4 (	item01,		item02,	item03	)
					values    (	prev_node_id,	prev_kind,	show_regions);
			commit;
			inserts := inserts + 01;
		end if;

		if	look.region > '0'				then
			show_regions := look.region;
		else
			show_regions := null;
		end if;

	end if;

	prev_node_id := look.node_id;
	prev_kind	 := look.kind;
	prev_region	 := look.region;

	close	read_intersection_region;

end loop;

	insert into gis_temp4 (	item01,		item02,	item03	)
			values    (	prev_node_id,	prev_kind,	show_regions);
	commit;
	inserts := inserts + 01;

	dbms_output.put_line ('Total Region Sets   '  || inserts);

end;

