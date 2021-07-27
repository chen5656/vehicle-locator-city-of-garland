	set echo off;
	set timing on;
--	=================================================================
--	update of rec_seq following initial extract
--	=================================================================

declare

		do_compile		number := 0;

		this_seq		number := 0;
		last_seq		number := 0;
		total_update	number := 0;

cursor	read_app_rowid	is

		select *
		from	garland.gis_app_rowid
		where row_seq = this_seq;

		look	read_app_rowid%rowtype;

--	==================================================================
begin

	if	do_compile > 0		then
		return;
	end if;

	select max(row_seq)
	into	 last_seq
	from	 garland.gis_app_rowid;

while this_seq < last_seq		loop

	this_seq := this_seq + 01;

begin

	open	read_app_rowid;
	fetch	read_app_rowid	into look;

	update garland.adrResult_Input
	set	rec_seq = look.row_seq
	where	rowid	  = look.row_id;

	total_update := total_update + 01;

	commit;

	close	read_app_rowid;

exception
	when others	then	close read_app_rowid;
end;

end loop;

	dbms_output.put_line (' ');
	dbms_output.put_line ('Total Updates  ' || total_update);

end;
