	set echo off;
--	==============================================================================
--	create an SQL command file to find table columns having a certain value
--	==============================================================================

declare

--	---------------------------------------------------------------------------------
--	fill in the following search specifications

	what_value		varchar2(20)	:= 'like ''%tp''	';
--	what_value		varchar2(20)	:= '= ''FL''		';
--	what_value		varchar2(20)	:= '= 0			';

	like_table		varchar2(20)	:= '%%';
	like_column		varchar2(20)	:= '%%';
	like_type		varchar2(20)	:= 'char%';

	min_length		number		:=  05;
	max_length		number		:=  05;

	name_owner		varchar2(20)	:= 'sfg';
	name_dblink		varchar2(20)	:= '@umsp.world';

--	name_distinct	varchar2(20)	:= 'distinct';
	name_distinct	varchar2(20)	:= '';

	also_filter		varchar2(80)	:= 'and rownum < 2';
--	also_filter		varchar2(80)	:= '';

--	---------------------------------------------------------------------------------

	string		varchar2(1000);
	counter		number		:= 0;

--	---------------------------------------------------------------------------------
cursor	read_data_dict		is

	select
			'select '				||
			name_distinct			||' '			||


			''''|| table_name			||''' " ",  '	||	
			''''|| column_name		||''' " ",  '	||
			'rpad(' ||  column_name || ',20)'	||' " " '	||
								chr(10)		||
			'from ' ||	owner			||'.'			||
					table_name		||
					upper(name_dblink)||
			
			' where '|| column_name		||' '			||
			what_value				|| chr(10)		||

			' ' || also_filter || ';'	|| chr(10)		string

	FROM		all_tab_columns@umsp.world

	where		owner		=	upper(name_owner)
	and		table_name	like	upper(like_table)
	and		column_name	like	upper(like_column)
	and		data_type	like	upper(like_type)
	and		data_length	between min_length and max_length
	;

--	---------------------------------------------------------------------------------

begin

	dbms_output.put_line ( ';' );
	dbms_output.put_line ( ' ' );


for	look in read_data_dict		loop

	dbms_output.put_line ( look.string );

	counter := counter + 01;

end loop;

	dbms_output.put_line ( '--  total commands = ' || counter);


end;


--	==============================================================================
/*
*/
--	==============================================================================
