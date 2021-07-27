	set echo		off;
	set serveroutput 	on;

--	=======================================================================	
--	generate sql queries to display columns from rows in an oracle table
--	display a few columns at a time of each key; enough to fill a single line of display

--	instructions:	alter job specifications (in capital letters), then execute job
--					schema name
--					table  name
--					identifier column (table key)
--					filter selections 1 & 2


--	=======================================================================	
--	enhance		"order by" clause
--	=======================================================================	

declare

	job_schema_name	varchar2(20)	:= 'GARLAND';

	job_table_name	varchar2(20)	:= 'CDRELADR';

	job_table_key	varchar2(20)	:= 'ADDR_NAME';

	job_max_rows	number		:= 40;			--  maximum rows to display

	job_max_length	number		:= 80;			--  length of display line


	filter_a	varchar2(80)	:=	
	'and ' 	|| job_table_key ||	' between ''A''		and ''B''	';


	filter_b	varchar2(80)	:=	
	'and ' 	|| job_table_key ||	' in  ( ''JUPITER'', ''SHILOH'',		null)		';


	filter_f	varchar2(800)	:= 	
'
';


	filter_x	char	:= ' ';		--  non filter


	select_filter1	varchar2(80)	:= FILTER_A;
	select_filter2	varchar2(80)	:= FILTER_X;

--	=======================================================================	

	this_data_length	number		:= 0;
	this_key_length	number		:= 0;
	this_length		number		:= 0;
	that_length		number		:= 0;
	line_seq		number		:= 0;

	do_compile_only	boolean		:= false;

--	=======================================================================	

	select_begin	varchar2(80);

	select_item		varchar2(80);

	select_from		varchar2(80)	:= 'from ' 	 || job_schema_name || '.' || job_table_name;	

	select_where	varchar2(80)	:= 'where rownum < ' || job_max_rows; 
	
	select_stop		varchar2(01)	:= ';';

	echo_off		varchar2(20)	:= 'set echo off;';
	echo_on		varchar2(20)	:= 'set echo on;';


--	=======================================================================	
--	=======================================================================	

cursor	read_columns		is

	select	column_name,
			data_type,
			data_length
	from		cols

	where		table_name = job_table_name
	and		column_name <> job_table_key

	and		data_type 	<> upper ('long')

	order by	column_id;


begin

	if	do_compile_only			then
		return;
	end if;


	select 	least ( data_length, job_max_length )
	into		this_key_length
	from		cols
	where		table_name  = job_table_name
	and		column_name = job_table_key;

	select_begin :=  'select  rpad(' || job_table_key || ', ' || this_key_length || ')  ' || job_table_key;



	dbms_output.put_line ('-- ============================================================');
	dbms_output.put_line (echo_off);
	dbms_output.put_line (select_begin);


for	look	in read_columns			loop

	if	this_length + look.data_length > job_max_length		then

		this_length	:= 0;

		dbms_output.put_line (select_from);
		dbms_output.put_line (select_where);
		dbms_output.put_line (select_filter1);
		dbms_output.put_line (select_filter2);
		dbms_output.put_line (select_stop);

		dbms_output.put_line (select_begin);

	end if;


		this_data_length	:= look.data_length;
		if	look.data_type = upper ('date')		then
			this_data_length	:= 09;
		end if;


		that_length	:= least ( greatest ( length (look.column_name), this_data_length), job_max_length);
		this_length	:= this_length + that_length;

	
		select_item	:=  ',rpad(' || look.column_name || ',' || that_length || ')  ' || look.column_name;
		dbms_output.put_line (select_item);


end loop;

		dbms_output.put_line (select_from);
		dbms_output.put_line (select_where);
		dbms_output.put_line (select_filter1);
		dbms_output.put_line (select_filter2);
		dbms_output.put_line (select_stop);
		dbms_output.put_line (echo_on);

end;
