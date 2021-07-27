
--	display v$sqltext

	set echo 		off;
	set serveroutput	on;

declare

--	spec_osuser		varchar2(80)	:= 'lcombs';		--	any user = '0'
	spec_osuser		varchar2(80)	:= '0';			--	any user = '0'
	spec_sid		number		:= 0;				--	any sid  =  0

	spec_line_leng	number		:= 50;			--	max text length
	spec_loops		number		:= 100;			--	safety valve

	do_compile_only	number		:= 0;			--	suppress execution

--	============================================================================================

	cursor_is_open	boolean		:= true;

	end_posn		number		:= 0;
	semi_posn		number		:= 0;

	view_show		varchar2(2000)	:= null;
	view_leng		number		:= 00;

	view_display	varchar2(2000)	:= ' ';
	leng_display	number		:= 0;

	sql_sid		number;
	sql_string		varchar2(100);


cursor	read_sql_text	is

	select	c.sid,
			t.sql_text

	from		v$open_cursor	c,		
			v$session		s,
			v$sqltext		t

	where		c.sid			= s.sid
	and		t.address		= s.sql_address
	and		t.hash_value	= s.sql_hash_value 

	and		spec_osuser	in	( lower(s.osuser), '0'	)
	and		spec_sid	in	( s.sid,		  0	)

	order by	c.sid,
			c.hash_value,
			t.piece;

--	============================================================================================

begin

	if	do_compile_only > 0				then
		return;
	end if;

	open	read_sql_text;

loop

	if	cursor_is_open
	and	view_leng < spec_line_leng			then

		fetch	read_sql_text	
		into	sql_sid,
			sql_string;	

		if	read_sql_text%found			then
			view_show	:= view_show || sql_string;
			view_leng	:= length (view_show);
		else
			cursor_is_open := false;
		end if;
	end if;

	leng_display := least(view_leng - 01, spec_line_leng);
	end_posn  := instr (view_show || ' ', ' ', leng_display);
	semi_posn := instr (view_show, '; ');
	if	semi_posn between 1 and end_posn		then
		end_posn := semi_posn + 01;
	end if;

	exit when	end_posn < 01;

	view_display := substr (view_show, 01, end_posn - 01);
	dbms_output.put_line (view_display);

	view_show	:= substr (view_show, end_posn + 01);
	view_leng	:= length (view_show);

	spec_loops	:= spec_loops - 01;
	exit when	spec_loops < 0;				

end loop;


	dbms_output.put_line (';');

	close	read_sql_text;


end;

