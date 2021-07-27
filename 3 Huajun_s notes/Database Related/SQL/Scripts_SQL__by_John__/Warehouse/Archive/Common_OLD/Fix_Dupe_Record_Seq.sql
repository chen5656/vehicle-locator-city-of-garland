	set echo 		off;
    set linesize	2000;
	set serveroutput	on;

declare

	do_compile			number	:= 0;

	prev_record_seq		number	:= 0;
	seq				number	:= 0;

cursor	read_ccs_address		is

		select  record_seq, 
			  rowid		row_id
		from	  garland.ccs_address
		where	  record_seq      in
(
		select  record_seq
		from	  garland.ccs_address
		group by record_seq
		having	count(*) > 1
)		
		order by 1;


begin

	if	do_compile > 0		then
		return;
	end if;

for	look in read_ccs_address	loop

	if	prev_record_seq <> look.record_seq 		then
		prev_record_seq	:= look.record_seq;
		seq := 0;
	end if;

	seq	:= seq + 01;
	
	update	garland.ccs_address
	set		record_seq = look.record_seq + seq
	where		rowid = look.row_id;


--	dbms_output.put_line  ( look.record_seq ||' / '|| (look.record_seq + seq) );

end loop;

	commit;
end;
