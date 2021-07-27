
--	display contents of long data column
--	does not work: hangs at column_value_long function.

	set echo 	on;

create or replace procedure 		show_long_data
(
	long_data	in	long
)
is

	spec_leng		number		:= 200;

	loop_cnt		number		:= 0;
	end_posn		number		:= 0;
	semi_posn		number		:= 0;

	view_leng		number		:= 00;
	view_posn		number		:= 00;
	view_show		varchar2(2000)	:= ' ';
	view_long		long;

	view_display	varchar2(2000)	:= ' ';
	leng_display	number		:= 0;

	select_cursor	integer;
	ignore		integer;
	sql_string		varchar2(2000);


begin

	view_long	  := long_data;

	sql_string	  :=  'select dummy, :long_field   from dual';

	select_cursor := dbms_sql.open_cursor;

	dbms_sql.parse (select_cursor, sql_string, dbms_sql.v7);


	dbms_sql.define_column (select_cursor, 01 );

	dbms_sql.define_column_long (select_cursor, 02);

	dbms_sql.bind_variable (select_cursor, ':long_field', view_long );



	ignore := dbms_sql.execute (select_cursor);
	

	if	dbms_sql.fetch_rows (select_cursor) > 0				then

		loop

	
	return;

			dbms_sql.column_value_long (select_cursor, 1, spec_leng, view_posn, view_show, view_leng);

	return;


			exit when	view_leng < 01;

			loop_cnt	:= loop_cnt + 01;
			exit when	loop_cnt > 10;				--	safety check

			leng_display := least( length(view_show) - 01, 50);

			end_posn  := instr (view_show || ' ', ' ', leng_display);
			semi_posn := instr (view_show, '; ');
			if	semi_posn between 1 and end_posn		then
				end_posn := semi_posn + 01;
			end if;

			exit when	end_posn < 01;


			view_display := substr (view_show, 01, end_posn - 01);

			dbms_output.put_line (view_display);

			view_posn	:= view_posn + end_posn;

		end loop;

	end if;

	dbms_sql.close_cursor (select_cursor);

end;


