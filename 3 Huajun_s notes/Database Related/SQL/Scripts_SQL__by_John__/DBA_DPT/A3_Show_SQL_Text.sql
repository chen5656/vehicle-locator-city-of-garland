--	============================================================================================
--	generate displays & execution plans of v$sqltext 
--	============================================================================================
	set echo 		off;
	set charwidth	120;
	set fetchrows	999;
	set serveroutput	on		size 99999;
	SET TIMING		ON;
--	============================================================================================
declare
	spec_explain	varchar2(40)	:= 'Garland.Explain_Plan';
	spec_plan_table	varchar2(40)	:= 'Garland.Plan_Table';
	spec_into_table	varchar2(40)	:= ' into ' || spec_plan_table || ' for ';

	spec_self		number		:= 00;				--	get my sql
	spec_exec		number		:= 00;				--	get track_sql_text executions

	spec_text		varchar2(80)	:= upper('%%');			--	any text
--	spec_text		varchar2(80)	:= upper('%PAVE%');

	spec_osuser		varchar2(80)	:= 'X';				--	any user 
--	spec_osuser		varchar2(80)	:= upper('LPATTERS');

	spec_address	varchar2(20)	:= 'X';				--	any address;
--	spec_address	varchar2(20)	:= upper('032B6BE4');

	spec_command	number		:= 0;		
--		any command	0								--	any command
--		select	3	insert	2	update 6	delete 7
--		create tab	1	create idx	9

	spec_sid		number		:= 0;					--	any sid  
--	spec_sid		number		:= 15;			
										
	spec_machine	varchar2(80)	:= 'X';				--	any machine 
--	spec_machine	varchar2(80)	:= upper('COG\MIS-40-JDEACUTI');

--	-----------------------------------------------------------------------------------------

	spec_view_leng	number		:= 400;		--	min text length
	spec_line_leng	number		:= 40;		--	min print line width

	spec_max_queries	number		:= 30;		--	max queries to extract
	spec_max_lines	number		:= 500;		--	max lines	to print
	
	do_compile_only	number		:= 0;			--	suppress execution = 01

	spec_test		number		:= 0;

--	============================================================================================

cursor	read_sql_text	is

--	select	rtrim (t.sql_text)				string,
	select	t.sql_text						string,			--	dec 2002
			t.address						address,
			t.hash_value					hash_value,
			nvl (s.sid,	    rownum)				sid,	
			nvl (upper (s.osuser), t.address)		osuser,		
			nvl (upper (rtrim (s.machine)), ' ')	machine,
			a.executions


	from		v$session				s,				
			v$sqltext				t,
			v$sqlarea				a		--	Oracle  Statistics	
--			,v$open_cursor			c		--	Current Activity 



/*	from		v$session@umsp.world		s,				
			v$sqltext@umsp.world		t,
			v$sqlarea@umsp.world		a		--	Oracle  Statistics	
--			,v$open_cursor@umsp.world	c		--	Current Activity 
*/


	where		nvl(s.osuser,' ') <> 'SYSTEM'

	and	(	spec_self		> 0
	or		s.audsid		<> userenv('SESSIONID')	)

	and		t.address		= s.sql_address	 (+)	
	and		t.hash_value	= s.sql_hash_value (+)	

--	Oracle Statistic Filters 				
	and		t.address		= a.address		
	and		t.hash_value	= a.hash_value 

--	Current Activity Filter
--	and		t.address		= c.address				
--	and		t.hash_value	= c.hash_value 			

/*
--	SQL Text Filter	(from Find_SQL_Text.sql)

	and		t.address ||','|| t.hash_value in		
	(
	'0317E298,2206212128'                              
	'031D749C,2245537233'                              
	'036EC1E4,2214638850'                              
	'036ED1C4,2374024241'                              
	'03AC1E44,3994453755'                              
	'03AFC3E0,2918222939'                              
	'03CF6B7C,2095069785'                              
	'03E26568,508388865'                               
	'03EDA688,4015883357'                              
	'0404D0FC,3330369600'                              
	'0408D66C,871808262'                               
	 null
	)
*/

--	Spec Filters
	and		t.command_type in	(	 
			2,3,6,7,				--	insert, select, update, delete
			999			)	

	and		upper(t.sql_text)		like	spec_text 
	and		spec_command		in	( t.command_type,		 0 )
	and		spec_sid 			in	( s.sid, 			 0 )
	and		spec_address		in	( rtrim(t.address),	'X')	
	and		spec_osuser 		in	( upper(s.osuser),	'X')
	and		spec_machine 		in	( adr_string_cleaner(upper(s.machine)),	'X')

--	and		a.rows_processed		> 0
--	and		a.users_opening		> 0
--	and		a.users_executing		> 0
--	and		a.executions		> 0


--	Execution Filter	(after Track_SQL_Text.sql)

	and	(spec_exec = 0
	or	(a.address, a.hash_value)	in
(
	select	item01,		--	address
			item02		--	hash_value
	from		garland.gis_objects
	where		to_number(item03) < a.executions
))

	and not exists
(
	select	'*'
	from		garland.gis_objects
	where		item01	= a.address
	and		item02	= a.hash_value
	and		to_number(item03) < 0
)
	
	order by	t.address,
			t.hash_value,
			t.piece;

	rec		read_sql_text%rowtype;

--	============================================================================================

	cursor_is_open	boolean		:= true;
	fetch_is_active	boolean		:= true;

	total_sql		number		:= 0;
	end_posn		number		:= 0;
	semi_posn		number		:= 0;
	comma_posn		number		:= 0;
	quote_posn		number		:= 0;
	quote_count		number		:= 0;
	show_explain	number		:= 0;

	sql_string		varchar2(2000);

	view_show		varchar2(2000)	:= '';
	view_leng		number		:= 0;

	view_display	varchar2(2000)	:= '';
	start_scan		number		:= 0;

	this_address	raw(4);
	this_hash_value	number;

	sql_address		raw(4);
	sql_hash_value	number;
	sql_user		varchar2(80);
	sql_machine		varchar2(80);
	sql_sid		number;
	sql_execs		number;

	spec_loop1		number		:= 0;	
	spec_loop2		number		:= 0;	
	spec_max_loop1	number		:= spec_max_queries;	
	spec_max_loop2	number		:= spec_max_lines;

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
		sql_sid,
		sql_user,
		sql_machine,
		sql_execs;

	if	read_sql_text%notfound			then
		return;
	end if;

	dbms_output.put_line (	'Explain Plan set statement_id=''SID:Executions User'' into Plan_Table'); 
	dbms_output.put_line ( ' '); 
	

<<loop1>>
loop

	total_sql	:= total_sql + 01;

	show_explain	:= 0;						--	dec 2002

--	dbms_output.put_line ( ' '); 					--	dec 2002
--	dbms_output.put_line (	'Explain Plan set statement_id = '''|| sql_sid ||':'|| sql_execs ||' '|| 
--					sql_user  
--					adr_string_cleaner (sql_machine)
--					|| '''' || spec_into_table); 

	fetch_is_active	:= true;
	this_address	:= sql_address;
	this_hash_value	:= sql_hash_value;

--	view_show	:= sql_string;
--	view_leng	:= nvl (length (view_show), 0);
	view_show	:= nvl (sql_string, ' ');			--	dec 2002
 	view_leng	:= length (view_show);
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

	end_posn	:= nvl (instr (view_show ||' ',' ', start_scan), 	0);
	comma_posn	:= nvl (instr (view_show, 	 ',', start_scan),	0);
	semi_posn	:= nvl (instr (view_show, 	 ';' ),			0);
	quote_posn	:= nvl (instr (view_show, 	 '''',quote_count + 01),0);

--	if	quote_posn = 0					then					--	dec 2002
--		quote_posn	:= nvl (instr (view_show,'"',quote_count + 01),	0);
--	end if;

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

	if	spec_test > 0		then
		dbms_output.put_line ( '	view show '	||  view_show	);	--	TEST
		dbms_output.put_line ( '	view leng '	||  view_leng	);	--	TEST
		dbms_output.put_line ( '	start scan '||  start_scan	);	--	TEST
		dbms_output.put_line ( '	end posn  '	||  end_posn 	);	--	TEST
	end if;

--	==========================================================================
<<print_line>>

--	print the line
--	shorten text by print line length 

	if	show_explain = 0			then					--	dec 2002
		show_explain := 01;
		dbms_output.put_line ( ' '); 
		dbms_output.put_line (	'Explain Plan set statement_id = '''
							|| sql_sid 
						||':' || sql_execs
--						||' ' || sql_user  
--						||' ' || adr_string_cleaner (sql_machine)
						||''''|| spec_into_table); 
	end if;

	view_display :=  substr (view_show, 01, end_posn);
	dbms_output.put_line	(view_display);

	view_show	:= substr (view_show, end_posn + 01);
	view_leng	:= nvl (length (view_show), 0);

--	==========================================================================
<<fetch_text>>

--	obtain more text when the trigger length (spec_line_leng) is reached

	if	fetch_is_active					
	and	view_leng < spec_view_leng		then

		fetch	read_sql_text	
		into	sql_string,	
			sql_address,
			sql_hash_value,
			sql_sid,
			sql_user,
			sql_machine,
			sql_execs;

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
	dbms_output.put_line ('--	total sql statements = ' || total_sql );

--	dbms_output.put_line ('		loops ' || spec_loop1 ||' '|| spec_loop2);	--	TEST

end;



