
--	generate displays & execution plans of v$sqltext 

--	============================================================================================
--	enhance:	change view_ names
--	enhance:	display	filter values
--	enhance:	replace	sql_ with rec.
--	============================================================================================

	set echo 		off;
	set charwidth	100;
	set serveroutput	on		size 10000;				--	max buffer output bytes

declare

	spec_test		number		:= 01;

	spec_sid		number		:= 0;
--							any sid  =  0

	spec_osuser		varchar2(80)	:= 'x';
--							any user = 'x'  

	spec_command	number		:= 0;				--	any command = 0		
--	command codes 								--	see v$session listing
--				select		3
--				insert		2
--				update		6
--				delete		7
--				create table	1				
--				create index	9

	spec_view_leng	number		:= 400;			--	min text length
	spec_line_leng	number		:= 40;			--	min print line width

	spec_max_queries	number		:= 30;			--	max queries to extract
	spec_max_lines	number		:= 500;			--	max lines	to print
	
	do_compile_only	number		:= 0;				--	suppress execution = 01

--	============================================================================================

	cursor_is_open	boolean		:= true;
	fetch_is_active	boolean		:= true;

	end_posn		number		:= 0;
	semi_posn		number		:= 0;
	comma_posn		number		:= 0;
	quote_posn		number		:= 0;
	quote_count		number		:= 0;

	sql_string		varchar2(2000);

	view_show		varchar2(2000)	:= '';
	view_leng		number		:= 0;

	view_display	varchar2(2000)	:= '';
	start_scan		number		:= 0;

	this_address	raw(4);
	this_hash_value	number;

	sql_address		raw(4);
	sql_hash_value	number;
	sql_sid		number;
	sql_user		varchar2(80);

	spec_loop1		number		:= 0;	
	spec_loop2		number		:= 0;	
	spec_max_loop1	number		:= spec_max_queries;	
	spec_max_loop2	number		:= spec_max_lines;

--	============================================================================================

cursor	read_sql_text	is

	select	rtrim (t.sql_text)			string,
			t.address					address,
			t.hash_value				hash_value,
			nvl (s.osuser, t.address)		osuser,		
			nvl (s.sid,	    rownum)			sid				

	from		v$session		s,				
			v$sqlarea		a,					--	a = filter for oracle statistics
			v$open_cursor	c,					--	c = filter for current activity
			v$sqltext		t

	where		t.address		= s.sql_address	 (+)	
	and		t.hash_value	= s.sql_hash_value (+)	

	and		t.command_type	not in (24,47,59,91,94,97)	--	suppress program scripts

											--	named spec filters
	and		spec_command	in	( t.command_type,		 0 )
	and		spec_sid 		in	( s.sid, 			 0 )
	and		spec_osuser 	in	( lower(s.osuser),	'x')

											--	oracle statistic filters			
	and		a.sharable_mem		> 10000
--	and		a.users_executing 	> 0
--	and		a.executions 		> 0
--	and		a.rows_processed		> 0
--	and		a.disk_reads		> 0
--	and		a.first_load_time 	> '2001-01-00/00:00:00'

	and		a.address		= t.address			
	and		a.hash_value	= t.hash_value 		
											--	current activity only
	and		c.address		= t.address				
	and		c.hash_value	= t.hash_value 			

	order by	t.address,
			t.hash_value,
			t.piece;

	rec		read_sql_text%rowtype;

--	============================================================================================

begin

	if	do_compile_only > 0			then
		return;
	end if;

	open	read_sql_text;

	fetch	read_sql_text	
	into	sql_string,	
		sql_address,
		sql_hash_value,
		sql_user,
		sql_sid;

	if	read_sql_text%notfound			then
		return;
	end if;
	
	dbms_output.put_line ( ' '); 
	dbms_output.put_line ( 'truncate table plan_table;');


<<loop1>>
loop

	dbms_output.put_line ( ' '); 
	dbms_output.put_line ( 'explain plan set statement_id = ''' || sql_user ||' '|| sql_sid || '''  for '); 

	fetch_is_active	:= true;
	this_address	:= sql_address;
	this_hash_value	:= sql_hash_value;

	view_show	:= sql_string;
 	view_leng	:= nvl (length (view_show), 0);
	quote_count	:= 0;

<<loop2>>
loop

	if	fetch_is_active			
	and	view_leng < spec_view_leng			then
		goto	fetch_text;
	end if;

--	==========================================================================
--	determine where to break the print line

	if	spec_line_leng < view_leng			then
		start_scan	:= spec_line_leng;
	else
		end_posn	:= view_leng;
		goto	print_line;
	end if;

	end_posn	:= nvl (instr (view_show||' ',' ', start_scan), 	0);
	comma_posn	:= nvl (instr (view_show, 	',', start_scan),		0);
	semi_posn	:= nvl (instr (view_show, 	';' ),			0);
	quote_posn	:= nvl (instr (view_show, 	'''',quote_count + 01),	0);
	if	quote_posn = 0					then
		quote_posn	:= nvl (instr (view_show,'"',quote_count + 01),	0);
	end if;

	if	quote_posn	between 1 and end_posn		then
		quote_count	:= quote_count + 01;
		if	quote_count = 01				then
			end_posn	:= quote_posn - 01;
		else
			end_posn	:= quote_posn;
			quote_count	:= 0;
		end if;

	elsif	semi_posn	between 1 and end_posn		then
		end_posn := semi_posn;

	elsif	comma_posn	between 1 and end_posn		then
		end_posn := comma_posn;

	end if;

	if	spec_test > 0		
	and	spec_sid  > 0		then
		dbms_output.put_line ( ' ' );
		dbms_output.put_line ( '	view show '	||  view_show	);		--	TEST
		dbms_output.put_line ( '	view leng '	||  view_leng	);		--	TEST
		dbms_output.put_line ( '	leng disp '	||  start_scan	);		--	TEST
		dbms_output.put_line ( '	end posn  '	||  end_posn 	);		--	TEST
	end if;

--	==========================================================================
<<print_line>>

--	print the line
--	shorten text by print line length 

	view_display :=  substr (view_show, 01, end_posn);
	dbms_output.put_line	(view_display);

	view_show	:= substr (view_show, end_posn + 01);
	view_leng	:= nvl (length (view_show), 0);

--	==========================================================================
<<fetch_text>>

--	obtain more text when the trigger length (spec_line_leng) is reached

	if	fetch_is_active					
	and	view_leng < spec_view_leng			then

		fetch	read_sql_text	
		into	sql_string,	
			sql_address,
			sql_hash_value,
			sql_user,
			sql_sid;

		if	read_sql_text%notfound			then
			cursor_is_open  := false;
			fetch_is_active := false;	

		elsif sql_address	   = this_address
		and	sql_hash_value = this_hash_value	then
			view_show	:= view_show || sql_string;
			view_leng	:= nvl (length (view_show), 0);

		else
			fetch_is_active := false;	
		end if;

--		if	read_sql_text%found			then
--			sql_string := adr_string_cleaner (sql_string);
--		end if;

	end if;


	exit when	view_leng < 01;

	spec_loop2 := spec_loop2 + 01;
	exit loop1 	when spec_loop2 > spec_max_loop2;				

end loop;

	dbms_output.put_line (';');

	exit when	not cursor_is_open;

	spec_loop1 := spec_loop1 + 01;
	exit loop1	when spec_loop1 = spec_max_loop1;				

end loop;

	close	read_sql_text;

	dbms_output.put_line (' ');
	dbms_output.put_line ('  	@c:\deacutis\scripts\plans\exhibit.sql;');
	dbms_output.put_line ('--	@c:\deacutis\scripts\plans\exhibits.sql;');
	dbms_output.put_line (' ');

--	dbms_output.put_line ('		loops ' || spec_loop1 ||' '|| spec_loop2);	--	TEST

end;


/*
--	============================================================================================
	select	rtrim (t.sql_text)			string,
			t.address					address,
			t.hash_value				hash_value,
			nvl (s.osuser, t.address)		osuser,		
			nvl (s.sid,	    rownum)			sid				

	from		v$session		s,				
			v$sqltext		t

	where		s.SID			= 43
--	where		lower(s.OSUSER)	= 'beck'

	and		t.command_type	not in (24,47,59,91,94,97)	

	and		t.address		= s.sql_address	 (+)	
	and		t.hash_value	= s.sql_hash_value (+)	

	order by	t.address,
			t.hash_value,
			t.piece;
--	============================================================================================
*/
