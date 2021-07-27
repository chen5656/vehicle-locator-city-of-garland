	set echo		off;
	set timing		off;
	set serveroutput	on	size 999999;

--	correct conflicts in address ranges of TRVEHRCL

--	====================================================================
declare
	
	do_compile			number := 0;
	do_print			number := 01;

	do_update			number := 0;
	do_reverse_actual		number := 01;
	do_revise_potential	number := 01;
	do_intra_conflict		number := 0;
	do_inter_conflict		number := 0;

	count_update		number := 0;
	count_reverse_actual	number := 0;
	count_revise_potential	number := 0;
	count_intra_conflict	number := 0;
	count_inter_conflict	number := 0;

	did_update			number;
	did_reverse_actual	number;
	did_revise_potential	number;
	did_intra_conflict	number;
	did_inter_conflict	number;

	show_pfx			char(02);
	show_name			char(40);
	show_type			char(05);
	show_sfx			char(02);
	show_lo			varchar2(06);
	show_hi			varchar2(06);
	show_left_from		varchar2(06);
	show_left_to		varchar2(06);
	show_rght_from		varchar2(06);
	show_rght_to		varchar2(06);

	hold_num			number;
		
--	===================================================================
cursor read_segment	is

	select distinct	addr_name, addr_type, addr_pfx, addr_sfx,
				addr_lo,   addr_hi, 
				addr_left_from, addr_left_to,	  addr_rght_from, addr_rght_to,
				rowid	row_id
	from	trvehrcl
	where mslink > 0

--	and	rownum < 1111

	and	addr_lo < 9999
	and	addr_hi < 9999
	order by	1,2,3,4,5,6,7;

	SEG	read_segment%rowtype;
	RNG	read_segment%rowtype;
		
--	===================================================================

begin

	if	do_compile > 0	then
		return;
	end if;

	open	read_segment;

loop

	fetch read_segment			into SEG;
	exit when	read_segment%notfound
		or	read_segment%notfound is null;

	RNG := SEG;

	did_reverse_actual	:= 0;
	did_revise_potential	:= 0;
	did_intra_conflict	:= 0;
	did_inter_conflict	:= 0;
		
--	===================================================================

	if	do_reverse_actual > 0
	and 	rng.addr_left_from > rng.addr_left_to		then
		hold_num		 := rng.addr_left_from;
		rng.addr_left_from := rng.addr_left_to;
		rng.addr_left_to	 := hold_num;
		did_reverse_actual := 1;
	end if;

	if	do_reverse_actual > 0
	and 	rng.addr_rght_from > rng.addr_rght_to		then
		hold_num		 := rng.addr_rght_from;
		rng.addr_rght_from := rng.addr_rght_to;
		rng.addr_rght_to	 := hold_num;
		did_reverse_actual := 1;
	end if;

	if	do_revise_potential > 0					then
		rng.addr_lo	:= least	(rng.addr_left_from, rng.addr_rght_from);
		rng.addr_hi	:= greatest (rng.addr_left_to,   rng.addr_rght_to);
		if	rng.addr_lo < seg.addr_lo
		or	rng.addr_hi > seg.addr_hi			then
			did_revise_potential := 1;
		end if;
	end if;
		
--	===================================================================

	did_update := did_reverse_actual + did_revise_potential + did_intra_conflict + did_inter_conflict;

	if	do_print * did_update > 0	then
		dbms_output.put_line (	' ' );
		dbms_output.put_line (	'Street    = ' || rpad(seg.addr_pfx,2) || rpad(seg.addr_name,20)	||
					   				rpad(seg.addr_type,05)	|| rpad(seg.addr_sfx, 02)	);

		dbms_output.put_line (	'Actual LR =  '|| lpad(seg.addr_left_from,5) ||'-'|| rpad(seg.addr_left_to,5) 
								   || ' ' 	 
								   ||	lpad(seg.addr_rght_from,5) ||'-'|| rpad(seg.addr_rght_to,5)	); 	 

		dbms_output.put_line (	'Potential =  '|| lpad(seg.addr_lo,5) ||'-'|| rpad(seg.addr_hi,5)	); 	 
	end if;
		
--	===================================================================

	if	did_update > 0			then
		update trvehrcl
		set	addr_lo		= rng.addr_lo,
			addr_hi		= rng.addr_hi,
			addr_left_from	= rng.addr_left_from,
			addr_left_to	= rng.addr_left_to,
			addr_rght_from	= rng.addr_rght_from,
			addr_rght_to	= rng.addr_rght_to

		where	rowid			= seg.row_id

		returning	addr_pfx, addr_name, addr_type, addr_sfx,
				addr_lo,  addr_hi, 	
				addr_left_from,  addr_left_to, addr_rght_from, addr_rght_to 	

		into		show_pfx, show_name, show_type, show_sfx,
				show_lo,  show_hi, 
				show_left_from,  show_left_to, show_rght_from, show_rght_to ;
	end if;

	if	do_update * did_update > 0	then
--		commit;
		null;
	else
		rollback;
	end if;
		
--	===================================================================

	if	do_print > 0				then
		if	did_reverse_actual > 0		then
			count_reverse_actual	:= count_reverse_actual + 01;
			dbms_output.put_line ( '<Reverse Actual>');
		end if;

		if	did_revise_potential > 0	then
			count_revise_potential	:= count_revise_potential + 01;
			dbms_output.put_line ( '<Revise Potential>');
		end if;
	end if;

	if	do_print * did_update > 0		then
		dbms_output.put_line (	'Actual LR =  '|| lpad(show_left_from,5) ||'-'|| rpad(show_left_to,5) 
							    	   || ' '
								   || lpad(show_rght_from,5) ||'-'|| rpad(show_rght_to,5)  );
		dbms_output.put_line (	'Potential =  '|| lpad(show_lo,5) ||'-'|| rpad(show_hi,5)	); 
	end if;

end loop;
		
--	===================================================================

	close read_segment;

	rollback;
--	commit;


	count_update := count_reverse_actual + count_revise_potential;
	dbms_output.put_line (' ');
	dbms_output.put_line ('Total Reverse Actual	= '	|| lpad(count_reverse_actual,3));
	dbms_output.put_line ('Total Revise Potential	= '	|| lpad(count_revise_potential,3));
	dbms_output.put_line ('Total Updates		= '	|| lpad(count_update,3));

end;


/*
--	===========================================================
	'equal range boundaries ' 	" ",

	and (	addr_left_from	= addr_rght_from
	or	addr_left_to	= addr_rght_to	)

--	===========================================================
	'missing number ' 	" ",


	and (	nvl(addr_left_from, 0)  = 0
	or	nvl(addr_left_to,   0)	= 0
	or 	nvl(addr_rght_from, 0)  = 0
	or	nvl(addr_rght_to,   0)	= 0 )

--	===========================================================
	'inter conflict ' 	" ",

	and (	mod(addr_left_from,2) in ( mod(addr_rght_from,2),  mod(addr_rght_to,2) )
	or	mod(addr_left_to,  2) in ( mod(addr_rght_from,2),  mod(addr_rght_to,2) )	)

--	===========================================================
	'intra conflict ' 	" ",

	and (	mod(addr_left_from,2) <> mod(addr_left_to,2)
	or	mod(addr_rght_from,2) <> mod(addr_rght_to,2 )	)

--	===========================================================
	'reversed range ' 	" ",

	and (	addr_left_from > addr_left_to
	or	addr_rght_from > addr_rght_to )

--	===========================================================
	'empty street item ' 	" ",

	and (	addr_name	is null
	or	addr_type	is null
	or	addr_pfx	is null
	or	addr_sfx	is null	)

--	===========================================================
*/
