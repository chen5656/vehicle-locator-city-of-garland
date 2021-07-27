	set echo	off;
	set timing	on;
	set serveroutput	on 	size 999999;

--	update TRVEHRCL range with CDRELADR number that matches its block but is outside its range
--	ie. put a lower limit in addr_lo or a higher limit in addr_hi

declare

	do_compile_only		number := 0;
	do_print			number := 01;
	do_update			number := 0;
	do_trace			number := 0;

	read_limit			number := 99999;
	need_update			number;
	did_start_rowid		rowid;

	address_count		number := 0;
	segment_count		number := 0;
	update_count		number := 0;
	update_lo_count		number := 0;
	update_hi_count		number := 0;

	start_addr_lo		number;
	start_addr_hi		number;
	start_rowid			rowid;

	stop_addr_lo		number;
	stop_addr_hi		number;
	stop_rowid			rowid;

	show_ranges			varchar2(80);
	show_update			char(14);
	show_lo			char(06);
	show_hi			char(06);
	show_pfx			char(02);
	show_name			char(20);
	show_type			char(05);
	show_sfx			char(02);

cursor read_address	is

	select distinct addr_name, addr_type, addr_pfx, addr_sfx, addr_num
	from	cdreladr  a

	where	addr_num >  0

	and	rownum < read_limit + 01

	and	addr_name > 'CENTERVILLE'

	and exists	
(	select 'x'	from trvehrcl	
	where	addr_name = a.addr_name 
	and	addr_type = a.addr_type 
	and	addr_pfx  = a.addr_pfx 
	and	addr_sfx  = a.addr_sfx 
)

	and not exists	
(	select 'x'	from trvehrcl	
	where	addr_name = a.addr_name 
	and	addr_type = a.addr_type 
	and	addr_pfx  = a.addr_pfx 
	and	addr_sfx  = a.addr_sfx 
	and	a.addr_num  between addr_lo and addr_hi
)
	order by 1,2,3,4,5;
	
	ADR	read_address%rowtype;


cursor read_segment	is

	select r.addr_name, r.addr_type, r.addr_pfx, r.addr_sfx, r.addr_lo, r.addr_hi,
		 r.rowid row_id	
	from	trvehrcl	r

	where	r.addr_name	= adr.addr_name
	and	r.addr_type	= adr.addr_type
	and	r.addr_pfx	= adr.addr_pfx
	and	r.addr_sfx	= adr.addr_sfx
	and	adr.addr_num  between trunc(r.addr_lo, -2) and trunc(r.addr_hi, -2) + 99

	and	r.addr_lo between 01 and 9999
	and	r.addr_hi between 01 and 9999

	order by r.addr_name, r.addr_type, r.addr_pfx, r.addr_sfx, r.addr_lo, r.addr_hi;

	SEG	read_segment%rowtype;

--	=====================================================================================

begin

	if	do_compile_only > 0	then
		return;
	end if;

	open	read_address;

loop

	fetch	read_address	into ADR;
	exit when	read_address%notfound
		or	read_address%notfound is null;

	address_count := address_count + 01;

	start_addr_lo := 999999;
	stop_addr_hi  := 0;
	segment_count := 0;
	show_ranges	  := null;

	open	read_segment;

loop
	fetch	read_segment	into SEG;
	exit when	read_segment%notfound
		or	read_segment%notfound is null;

	segment_count := segment_count + 01;
	show_ranges	  := show_ranges || rpad (seg.addr_lo ||'-'|| seg.addr_hi, 15); 

	if	start_addr_lo = seg.addr_lo		then
		start_addr_lo	:= null;
	end if;

	if	stop_addr_hi  = seg.addr_hi		then
		stop_addr_hi	:= null;
	end if;

	if	stop_addr_hi  < seg.addr_hi		then
		stop_addr_lo	:= seg.addr_lo;
		stop_addr_hi	:= seg.addr_hi;
		stop_rowid		:= seg.row_id;
	end if;

	if	start_addr_lo > seg.addr_lo		then
		start_addr_lo	:= seg.addr_lo;	
		start_addr_hi	:= seg.addr_hi;	
		start_rowid		:= seg.row_id;
	end if;

	if	do_trace > 0		then
		dbms_output.put_line (' ');
		dbms_output.put_line ( 'segm  = ' || seg.addr_lo   ||' '|| seg.addr_hi	);
		dbms_output.put_line ( 'start = ' || start_addr_lo ||' '|| start_addr_hi);
		dbms_output.put_line ( 'stop  = ' || stop_addr_lo  ||' '|| stop_addr_hi	);
	end if;

end loop;

	close	read_segment;

	if	segment_count = 0				then
		need_update	 := 0;
	elsif	start_addr_lo > adr.addr_num		then
		need_update  := 1;
	elsif	stop_addr_hi  < adr.addr_num		then
		need_update  := 2;
	else
		need_update	 := 0;
	end if;

	if	need_update = 1				then	
		if	start_rowid = did_start_rowid then
			need_update := 0;
		else
			did_start_rowid := start_rowid;
		end if;
	end if;

	if	need_update > 0	
	and	do_print 	> 0			then
		select decode (need_update, 1, 'addr_lo', 2, 'addr_hi', ' ') into show_update from dual;		
		dbms_output.put_line (' ');
		dbms_output.put_line (show_update || show_ranges);
	
		dbms_output.put_line (	rpad(adr.addr_num, 12)	|| 
						rpad(adr.addr_pfx, 02)	|| rpad(adr.addr_name,20)	||
					    	rpad(adr.addr_type,05)	|| rpad(adr.addr_sfx, 02)	);
	end if;

	if	need_update > 0			then
		update_count := update_count + 01;
	end if;

	if	need_update = 1			then

		if	do_print > 0		then
			dbms_output.put_line (	rpad(start_addr_lo, 06)	|| rpad(start_addr_hi, 06)	|| 	 
							rpad(adr.addr_pfx,  02)	|| rpad(adr.addr_name, 20)	||
						   	rpad(adr.addr_type, 05)	|| rpad(adr.addr_sfx,  02)	);
		end if;

--		if	do_update > 0		then
			update trvehrcl
				set	addr_lo	= adr.addr_num
				where	rowid		= start_rowid
				returning	addr_lo, addr_hi, addr_pfx, addr_name, addr_type, addr_sfx
				into		show_lo, show_hi, show_pfx, show_name, show_type, show_sfx;
--		end if;

		if	do_print > 0		then
			dbms_output.put_line (show_lo || show_hi || show_pfx || show_name || show_type || show_sfx);
		end if;

		if	nvl(do_update,0) = 0	then
			rollback;
		else
			update_lo_count := update_lo_count + 01;
		end if;


	elsif	need_update = 2			then

		if	do_print > 0		then
			dbms_output.put_line (	rpad(stop_addr_lo,  06)	|| rpad(stop_addr_hi,  06)	|| 	 
							rpad(adr.addr_pfx,  02)	|| rpad(adr.addr_name, 20)	||
						   	rpad(adr.addr_type, 05)	|| rpad(adr.addr_sfx,  02)	);
		end if;

--		if	do_update > 0		then
			update trvehrcl
				set	addr_hi	= adr.addr_num
				where	rowid		= stop_rowid
				returning	addr_lo, addr_hi, addr_pfx, addr_name, addr_type, addr_sfx
				into		show_lo, show_hi, show_pfx, show_name, show_type, show_sfx;
--		end if;

		if	do_print > 0		then
			dbms_output.put_line (show_lo || show_hi || show_pfx || show_name || show_type || show_sfx);
		end if;

		if	nvl (do_update,0) = 0	then
			rollback;
		else
			update_hi_count := update_hi_count + 01;
		end if;

	end if;

end loop;

	close	read_address;

	rollback;
--	commit;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'Total Address = '	|| address_count	);
	dbms_output.put_line ( 'Update Low	  = '	|| update_lo_count);
	dbms_output.put_line ( 'Update High   = '	|| update_hi_count);
	dbms_output.put_line ( 'Update Total  = '	|| update_count	);
	
end;
