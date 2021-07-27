--	=================================================================
--	test harness for tst_compare_name procedure
--	=================================================================

	set echo		off;
	set timing		on;
	set serveroutput	on		size 99999;
--	=================================================================

--	create or replace procedure	test1		as

declare

	print_spec			number := 	0;		
		is_print_best	number := 	+00;
		is_print_all	number := 	+10;

--	===================================================================

	fetch_count			number	:= 0;

	error_count			number 	:= 0;
		is_show_trace	number 	:= -100;

	best_entry			varchar2(40);
	best_list			varchar2(200);
	name_list			varchar2(200);
	flag				varchar2(10) := '    ';

	addr1_name			varchar2(20);
	addr2_name			varchar2(20);
	user_name			varchar2(80);
	prev_name			varchar2(80);
	addr1_compact		varchar2(20);

	match_best			number	:= 0;
	error_best			number	:= 0;
	delim				number	:= 0;

	match_count			number	:= 0;
	match_score			number	:= 0;

	leng_compact		number	:= 0;

	job_scope			varchar2(40);

--	===================================================================

	type	name_array	is	table	of varchar2(20)
				index by binary_integer;

	best_array		name_array;

	best_size		number	:= 0;
	best_error		number	:= 99999;

--	===================================================================
--	===================================================================

	cursor	read_compare_names	is
	select	distinct	
			addr_name,
			addr_compact

	from		garland.adrStreets

	where		addr_name like substr (addr1_name, 01, 01) || '%'

	and		abs (length (addr_compact) - leng_compact) <= 3

	and		nvl (length (translate (addr_name,  'x'||addr1_name, 'x')), 0)	+
			nvl (length (translate (addr1_name, 'x'||addr_name,  'x')), 0)	<= 4
	;
	
--	===================================================================

begin

	dbms_output.put_line (' ');
	dbms_output.put_line ('NAME1                     NAME2              SCORE ERRORS');

	dbms_output.put_line (rpad ('=', 70, '='));
	dbms_output.put_line (' ');

--	===================================================================

for	look in ( select item01, item02 from gis_objects)		loop

	if	look.item02 = '$'		
	and	look.item01 = 'best'		then
		goto	end_loop;
	end if;

	if	look.item02 = '$'		
	and	look.item01 = 'all'		then
		print_spec := is_print_all;
		goto	end_loop;
	end if;

	user_name	:= upper (look.item01);

	fetch_count	:= fetch_count + 01;

	error_count	:= 0;

--	===================================================================
--	display or trace ?

	delim	:= instr (user_name, '/');

	if	delim = 0					then
		addr1_name := user_name;
	else
		addr1_name := substr (user_name, 1, delim - 01);
		addr2_name := substr (user_name,	delim + 01);
	end if;

	if	delim = 0			then
		addr1_compact := adr_compress_name ( addr1_name, '4');
		leng_compact  := length (addr1_compact);

		match_count	:= 000;
		match_best	:= 999;
		name_list	:= '';
	end if;

--	===================================================================
--	option = print trace

	prev_name	:= addr1_name;
	addr1_name	:= ltrim (addr1_name, '=');

	if	delim > 0
	and	addr1_name <> prev_name			then
		error_count	:= is_show_trace;
	end if;
	
	if	delim > 0		then	

--	----------------------------------------------------------------------------------
--		TST_compare_name (addr1_name, addr2_name, match_score, error_count);
--		ADR_compare_name (addr1_name, addr2_name, match_score, error_count);

		Fuzzy_Match (addr1_name, addr2_name, match_score, error_count);

--	----------------------------------------------------------------------------------

		dbms_output.put_line (  rpad (addr1_name, 26) ||' '|| rpad  (addr2_name, 19) 
						||' '|| match_score   ||'   '|| error_count); 
		dbms_output.put_line (' ');
	end if;

--	===================================================================

for scan in	read_compare_names			loop

	exit when	delim > 0;

--	----------------------------------------------------------------------------------
--	TST_compare_name (addr1_name, scan.addr_name, match_score, error_count);
--	ADR_compare_name (addr1_name, scan.addr_name, match_score, error_count);

	Fuzzy_Match (addr1_name, scan.addr_name, match_score, error_count);

--	----------------------------------------------------------------------------------

--	=======================================================================================
--	option = print all

	if	print_spec = is_print_all	then

		dbms_output.put_line (  	  	rpad (nvl (addr1_name, ' '),	 20	) 
						||' ' ||	to_char (error_count,     	'90'	)
						||'  '||	to_char (match_score,     	'9099')
						||'  '||	flag || scan.addr_name	);
	end if;
--	=======================================================================================

	if	match_score  < match_best		then
		match_best	:= match_score;
		error_best	:= error_count;
		match_count	:= 0;
		best_size	:= 0;
		best_error	:= 999999;
		best_list	:= '';
		name_list	:= '';
	end if;

	if	match_score  = match_best		then
		match_count	:= match_count + 01;

		if	error_count < best_error	then
			best_error	:= error_count;
			best_size	:= 0;
		end if;

		if	error_count = best_error	then
			best_size			:= best_size + 01;
			best_array (best_size) 	:= scan.addr_name;
		end if;			
	end if;

	if	match_count <= 07				
	and	match_score  = match_best		then
		name_list	:= name_list || scan.addr_name ||' / ';
	end if;

end loop;

--	=======================================================================================
--	option = standard print 

	if	delim = 0							then
		for	x in 01..best_size				loop
			best_entry :=  best_array (x) || ' / ';

			best_list	:= best_list || best_entry;
			name_list	:= replace (name_list, best_entry, ' ');
		end loop;
	end if;

	if	match_best = 999		then
		best_list	:= '';
		name_list	:= '';
	end if;

	if	delim = 0			then
		dbms_output.put_line (  	  	rpad (nvl (addr1_name, ' '),20) 
						||' '   ||	to_char (error_best, '90')
						||'  '  ||	to_char (match_best, '9099')
						||'  '  ||	to_char (best_size,  '90')
						||'  '  ||	to_char (match_count - best_size, '90')
						||'    '||	best_list || name_list );
	end if;

	if	print_spec = is_print_all	then
		dbms_output.put_line (' ');
	end if;

--	=======================================================================================

<<end_loop>>
	null;

end loop;

	select decode (	print_spec,
				00,			'Best',
				10,			'All',
							'???'			)
		into	job_scope
		from	dual;


	dbms_output.put_line (' ');
	dbms_output.put_line (	job_scope || ' street name matches for ' || fetch_count || ' entries');

end;


--	=======================================================================================
--	instructions

--	standard summary
--				do_streets = 01

--	compare two names
--				do_names = 01
--				set array_name to	'xxxx/yyyy'

--	trace two names 
--				do_names = 01
--				set array_name to	'=xxxx/yyyy'

--	=======================================================================================


