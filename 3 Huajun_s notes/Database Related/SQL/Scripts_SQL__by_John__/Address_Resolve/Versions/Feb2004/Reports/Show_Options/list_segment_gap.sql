--	===================================================================================================
--	for an address having an out-of-range number, get segments immediately above & below the address
--	display message showing the address gap
--	this may indicate the need to expand an address range on trvehrcl
--	===================================================================================================

	set termout		on;
	set serveroutput	on		size 999999;
	set timing		off;
	set echo		off;

--	===================================================================================================

declare

	do_compile_only		number	:= 0;
	srch_margin			number	:= 0;	--	look how far on either side of address' 100 block ?

	srch_lo			number;
	srch_hi			number;

--	===================================================================================
cursor	read_bad_range_address		is

	select 	distinct
			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			addr_num
	from		adrResult
	where		trunc (verify_code, -1) = 30
	and		addr_num > 0;

	ADR	read_bad_range_address%rowtype;

--	===================================================================================
cursor	read_segment_below		is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	select	
--+	index_desc	(trvehrcl  trvehrcl_x_name_num)		

			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			addr_lo,
			addr_hi
	from		trvehrcl

	where		addr_name = adr.addr_name
	and		addr_hi between srch_lo and adr.addr_num

	and		adr.addr_type	in (addr_type, ' ')
	and		adr.addr_pfx	in (addr_pfx,  ' ')
	and		adr.addr_sfx	in (addr_sfx,  ' ')
	and		branch_no < 9999

	and		rownum	<= 2;

--	select * from explain_plan;

	LO	read_segment_below%rowtype;

--	===================================================================================
cursor	read_segment_above		is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	select	
--+	index_asc	(trvehrcl  trvehrcl_x_name_num)		

			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			addr_lo,
			addr_hi
	from		trvehrcl

	where		addr_name = adr.addr_name
	and		addr_lo  between adr.addr_num and srch_hi

	and		adr.addr_type	in (addr_type, ' ')
	and		adr.addr_pfx	in (addr_pfx,  ' ')
	and		adr.addr_sfx	in (addr_sfx,  ' ')
	and		branch_no < 9999

	and		rownum	<= 2;

--	select * from explain_plan;

	HI	read_segment_above%rowtype;

--	===================================================================================

begin

	if	do_compile_only > 0				then
		return;
	end if;

	dbms_output.put_line (' ' );
	dbms_output.put_line ( 'Segment Below or Above Application Address ' ); 
	dbms_output.put_line (' ' );


for	look in	read_bad_range_address			loop

	adr	:= look;

	srch_lo := trunc (adr.addr_num, -2) - srch_margin;
	srch_hi := trunc (adr.addr_num, -2) + srch_margin + 99;

	open	read_segment_below;
	fetch read_segment_below	into lo;
	if	read_segment_below%notfound		
	or 	read_segment_below%notfound is null		then
		lo.addr_name := null;
	end if;
	close read_segment_below;	

	open	read_segment_above;
	fetch read_segment_above	into hi;
	if	read_segment_above%notfound		
	or 	read_segment_above%notfound is null		then
		hi.addr_name := null;
	end if;
	close read_segment_above;	


	if	lo.addr_name || hi.addr_name is not null	then
		dbms_output.put_line ( ' ');
	end if;

	if  	lo.addr_name is not null			then
		dbms_output.put_line (	'below   ' ||
					rpad(lo.addr_lo,  06) || rpad(lo.addr_hi,  06)	||
					rpad(lo.addr_pfx, 03) || rpad(lo.addr_name,21) 	||
					rpad(lo.addr_type,05) || rpad(lo.addr_sfx, 03)	);
	end if;

	if	lo.addr_name || hi.addr_name is not null	then
		dbms_output.put_line (	'address       ' ||
					rpad(adr.addr_num, 06) || 
					rpad(adr.addr_pfx, 03) || rpad(adr.addr_name,21) ||	
					rpad(adr.addr_type,05) || rpad(adr.addr_sfx, 03) );	
	end if;

	if  hi.addr_name is not null				then
		dbms_output.put_line (	'above   ' ||
					rpad(hi.addr_lo,  06) || rpad(hi.addr_hi,  06)	||
					rpad(hi.addr_pfx, 03) || rpad(hi.addr_name,21) 	||
					rpad(hi.addr_type,05) || rpad(hi.addr_sfx, 03)	);
	end if;
	
end loop;

end;

