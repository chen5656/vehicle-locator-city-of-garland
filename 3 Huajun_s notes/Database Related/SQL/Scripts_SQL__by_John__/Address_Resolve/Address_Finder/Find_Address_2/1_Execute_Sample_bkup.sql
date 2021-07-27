	set	echo			off;
	set	serveroutput	on		size 99999;
--	========================================================================
--	Test Batch Execution of Find_Address routine
--	========================================================================

--	CHECK WHETHER CURSOR IS SELECTIVE	

--	========================================================================

declare

	do_compile		binary_integer	:= 0;
	do_trace_basic	binary_integer	:= 01;
	do_trace_detail	binary_integer	:= 010;
	do_trace		binary_integer	:= do_trace_basic;
--	do_trace		binary_integer	:= do_trace_detail;

	seq			binary_integer	:= 0;
	idx			binary_integer	:= 0;
	prev_status		varchar2(10);

	show_block		binary_integer	:= 0;		-- should hundred block be shown	
	show_num		varchar2(10);

--	========================================================================
	cursor	Read_Sample		is

	select * 
	from	garland.Find_Address_Input

--	where	REC_SEQ IN ( 06 )			--  SELECTIVE TESTING
	;

--	========================================================================
	Type Address_Array	is table of		Find_Address.Address_Option
		index by binary_integer;

	Type Region_Array		is table of		Find_Address.Region_ID%type
		index by binary_integer;
--	========================================================================

	user_num		varchar2(10);
	user_pfx		varchar2(10);
	user_name		varchar2(40);
	user_type		varchar2(10);
	user_sfx		varchar2(10);
	user_bldg		varchar2(10);
	user_unit		varchar2(20);
	
	control		varchar2(40);
	choice		number;
	occurs		number;

	address_entry	Find_Address.Address_Array;	
	region_entry	Find_Address.Region_Array;

	adr			Find_Address.Address_Option;
	reg			Find_Address.Region_ID%type;

--	========================================================================
begin

	if	do_compile > 0		then
		return;
	end if;

	dbms_output.put_line (' ');
	dbms_output.put_line ('******************************************* ');


for	look in Read_Sample			loop

	user_num	:=	look.user_num;
	user_pfx	:=	look.user_pfx;
	user_name	:=	look.user_name;
	user_type	:=	look.user_type;
	user_sfx	:=	look.user_sfx;
	user_bldg	:=	look.user_bldg;
	user_unit	:=	look.user_unit;

	control	:=	look.control;
	choice	:=	look.choice;
	occurs	:=	look.occurs;

	region_entry (1)	:= look.region1;
	region_entry (2)	:= look.region2;
	region_entry (3)	:= look.region3;
	region_entry (4)	:= Find_Address.end_of_list;


	
	if	do_trace >= do_trace_basic		then
	dbms_output.put_line (' ');
--	dbms_output.put_line (' /'	|| look.rec_seq );
	dbms_output.put_line (' /'	|| user_num  ||'/'|| user_pfx ||'/'|| user_name ||'/'|| 
						   user_type ||'/'|| user_sfx ||'/');
	if	do_trace >= do_trace_detail		then
	dbms_output.put_line (' /'	|| control   ||'/'|| choice   ||'/'|| occurs ||'/');
	end if;
	dbms_output.put_line (' ');
	end if;

	if	do_trace >= do_trace_detail		then
	idx := 0;
	loop
		idx	:= idx + 01;
		reg	:= region_entry (idx);
		dbms_output.put_line (' /' || reg ||'/');
		if	reg = Find_Address.end_of_list		then
			dbms_output.put_line (' '); 
			exit;
		end if;
	end loop;
	end if;

--	-----------------------------------------------------------------------------------------------------

	FIND_ADDRESS.Main
	(	user_num, user_pfx, user_name, user_type, user_sfx, user_bldg, user_unit, 
		control, choice, occurs,
		Address_Entry,   Region_Entry
	);

--	-----------------------------------------------------------------------------------------------------

	seq		:= 0;
	prev_status	:= null;

	loop
		seq	:= seq + 01;
		adr	:= address_entry (seq);
		exit when	adr.status = Find_Address.end_of_list;

	if	do_trace >= do_trace_basic	
	and	adr.status like '%4%'
	and	prev_status not like '%4%'		then
		dbms_output.put_line ( '.......................................................');
	end if;

	show_num := adr.addr_num;
	if	do_trace >= do_trace_basic		then
		if	adr.status like '%A%'
		or	show_block > 0			then
			null;
		else
			show_num := null;
		end if;
	end if;

	if	do_trace >= do_trace_basic		then
		dbms_output.put_line (  rpad(
						' /'	|| show_num	  ||'/'|| adr.addr_pfx ||'/'|| adr.addr_name ||'/'|| 
							adr.addr_type ||'/'|| adr.addr_sfx ||'/'
						,40)	||
				'           ='	|| lpad(seq,2,'0') ||'     ('|| adr.status || ')' );
	if	do_trace >= do_trace_detail		then
		dbms_output.put_line (' [' ||	adr.intersect1 ||']   ['|| adr.intersect2 ||']');
		dbms_output.put_line (' /' ||	adr.status ||'/'|| adr.location1_id ||'/'|| adr.location2_id ||'/');
		dbms_output.put_line (' ');
	end if;
	end if;

		prev_status := adr.status;
	end loop;


	if	do_trace >= do_trace_basic		then
	dbms_output.put_line (' ');
	dbms_output.put_line (' /'	|| control   ||' '|| occurs   ||' options - First one is at '|| choice );

	elsif	do_trace >= do_trace_detail		then
	dbms_output.put_line (' ');
	dbms_output.put_line (' /'	|| user_num  ||'/'|| user_pfx ||'/'|| user_name ||'/'|| 
						   user_type ||'/'|| user_sfx ||'/');
	end if;


	idx := 0;
	loop
		idx	:= idx + 01;
		reg	:= region_entry (idx);
		exit when	reg = Find_Address.end_of_list;
		dbms_output.put_line (' /' || reg ||'/');
	end loop;
	dbms_output.put_line (' ');



	dbms_output.put_line ('******************************************* ');

end loop;


end;

