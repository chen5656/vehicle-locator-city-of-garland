--	BUILD INTERSECTION REGION	3



	set echo off;
--	=================================================================================================
--	Assign Intersection Region "priority" based on occurrences of the region id
--	=================================================================================================

	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi') || '  ASSIGN INTERSECTION PRIORITY' " "	from dual;

declare

	do_compile			binary_integer	:= 01;
	do_update			binary_integer	:= 0;

	read_total			binary_integer	:= 0;
	update_total		binary_integer	:= 0;

	this_intersect_id		binary_integer;
	this_region_type		binary_integer;
	this_priority		binary_integer;

cursor	read_interesection		is

		select 	intersect_id, region_type, priority, region_id, 
				rowid  row_id 
		from		garland.Intersection_Region

		order by	intersect_id, 
				region_type, 
				priority		desc
				region_id;

begin

	if	do_compile > 0		then
		return;
	end if;

	dbms_transaction.use_rollback_segment ('RB1');

for	look in read_intersection		loop

	read_total	:= read_total + 01;

	if	look.intersect_id		= this_intersect_id
	and	look.region_type		= this_region_type		then
		null;
	else
		this_priority		:= 0;
		this_intersect_id		:= look.intersect_id;
		this_region_type		:= look.region_type;
	end if;

	this_priority := this_priority + 01;

	if	do_update > 0			then
		update	garland.intersection_region
		set		priority = this_priority
		where		rowid = look.row_id;

		update_total := update_total + 01;

		commit;
	end if;

end loop;

	dbms_output.put_line (	' ' );
	dbms_output.put_line (	'Assign Intersection Region Priority   '		||
					to_char(sysdate, 'mon dd yyyy  hh24:mi')  " " from dual);

	dbms_output.put_line (	'total input    ' || total_read);
	dbms_output.put_line (	'total updates  ' || total_update);

end;

