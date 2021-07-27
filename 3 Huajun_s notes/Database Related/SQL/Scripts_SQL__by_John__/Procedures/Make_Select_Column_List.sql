	set echo		off;	
	set serveroutput	on;
--	===============================================================================
--	Generate list of table column names for use in a SQL "Select" list
--	===============================================================================

--	select jdeacutis.make_select_column_list ('WATER_PIPE') from dual;

--	===============================================================================

	create or replace function	jdeacutis.Make_Select_Column_List (in_table_name   varchar2)
	return	varchar2

	AS	


	spec_table_name		varchar2(80);

	line_max			integer		:= 70;
	line_len			integer		:= 0;

	list				varchar2(2000)	:= null;
	prefix			varchar2(10)	:= '   ';

begin

	spec_table_name	:= in_table_name;

--	spec_table_name	:= 'WATER_PIPE';


for	LOOK in (	select column_name, column_id		from all_tab_columns 
			where table_name = spec_table_name  order by column_id	)
loop

	if	look.column_id = 01		then
		prefix	:= '';
	else
		prefix	:= ',';
	end if;

	list	:= list || prefix || look.column_name;

	line_len	:= line_len + length(look.column_name);

	if	line_len > line_max	then
		list	:= list || chr(10) || '   ';
		line_len := 0;
	end if;

end loop;

--	dbms_output.put_line ( rpad(list,200) );

	return	LIST;

end;
