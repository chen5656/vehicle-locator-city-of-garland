	set echo off;
--	=================================================================================
--	create column headings for ASCII extract
--	=================================================================================

	drop function			temp_function;

	create or replace function	temp_function (table_name in varchar2)  
						return  varchar2	
	as

	spec_delimiter	char		 := ';';		-- CHANGE
	spec_table_name	varchar2(40);

	text			varchar2(200);
	comma			char;

begin

	spec_table_name	:= table_name;

	text := '''';
	for look in (	select column_name, column_id		from cols 
				where table_name = spec_table_name	order by column_id	)	
	loop

		select decode (look.column_id, 1,'',spec_delimiter) into comma from dual;
		text	:= text || comma || look.column_name;

	end loop;

	return	text || '''';

end;

--	==============================================
