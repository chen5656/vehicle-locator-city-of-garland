	set echo 	on;
--	==========================================================

create or replace procedure 		Show_Long_Column
(
	sql_query	in	varchar2
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

	sql_string	:= sql_query;

	select_cursor := dbms_sql.open_cursor;

--	dbms_sql.parse (select_cursor, sql_string, dbms_sql.v7);
	dbms_sql.parse (select_cursor, sql_string, dbms_sql.native);

	dbms_sql.define_column_long (select_cursor, 01);
		
	ignore := dbms_sql.execute (select_cursor);

	
	if	dbms_sql.fetch_rows (select_cursor) > 0				then

		loop

			dbms_sql.column_value_long (select_cursor, 1, spec_leng, view_posn, view_show, view_leng);
			exit when	view_leng < 01;

			loop_cnt	:= loop_cnt + 01;
			exit when	loop_cnt > 1000;				--	safety check

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
