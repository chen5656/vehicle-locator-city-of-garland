--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- alter session	set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	=======================================================================================
--	Extract titles & info from building inspection report
--	=======================================================================================

--	Activity: Type: Sub Type: Sq Feet: Site Address: Description: Occupancy: Valuation:

--	=======================================================================================
--	PREPARE:	Revise Title_List variable
--	PREPARE:	Revise Decode command near end of script
--	PREPARE:	Specify which External_View should be processed

--	=======================================================================================

--	select * from garland.Temp_View1;

--	=======================================================================================
--	SPECIFY INPUT TABLE    <<<<<<<<<<<<<<<<<<<

--	\\deacutis\external_access\external_table\
--	delimit by "|"

	drop synonym     jdeacutis.temp_syn;
	create synonym   jdeacutis.temp_syn    for garland.GIS_Objects;
--	create synonym   jdeacutis.temp_syn    for jdeacutis.EXTERNAL_VIEW1;

--	=======================================================================================
--	define output table

	create or replace	view		garland.Temp_View1		
	( rec, col, title, info	)
	as
	select item01, item02, item03, item04	from garland.Gis_Temp1;

--	=============================================================================

	Truncate table	garland.Gis_Temp1		reuse storage;

--	=============================================================================

declare

	do_compile		binary_integer := 0;
	insert_count	binary_integer := 0;
	
	first_title		varchar2(40)	:= 'Activity';

	title_list		varchar2(1000)  := 
					'Site Address: Valuation: Sq Feet:'
--				||	'Activity: Type: Sub Type: Site Address: Description: Occupancy: Valuation:'
					;

	spacing		char(03)		:= ' ';
	space_len		binary_integer	:= 3;

	row_num		binary_integer;
	col_num		binary_integer;
	table_size		binary_integer;
	ndx			binary_integer;

	starts		binary_integer;
	stops			binary_integer;
	here			binary_integer;
	there			binary_integer;

	line			varchar2(200);
	text			varchar2(200);
	label			varchar2(80);
	info			varchar2(80);

	cnt1			number := 0;
	
begin

	if	do_compile > 0		then
		return;
	end if;

	row_num 	:= 0;

--	scan each line of building inspection report


for	look in (select item01 from jdeacutis.TEMP_SYN)
loop

	line	:= look.item01;
	line	:= spacing || ltrim(rtrim(line)) || spacing;


--	look for desired title within each line
--	mark their positions

	stops	:= 1;

--dbms_output.put_line ('STOPS:' || stops || '  LINE:' ||line);


while	stops > 0		loop

--dbms_output.put_line (' ');
	
	here		:= stops + 01;					-- begin search "here"
	stops		:= instr (line, ':', here);			-- "stops" = end of label
	col_num	:= null;

--dbms_output.put_line ('STOPS:' ||stops|| '  HERE:' ||here );
	
	if	stops > 0					then

		text		:= substr(line, 01, stops - 01);
		starts	:= instr (text, spacing, -1) + space_len;	
		label		:= substr(text, starts);			

--dbms_output.put_line ('TEXT:' ||text|| '  STARTS:' ||starts|| '  LABEL:' ||label);

		here		:= stops + 01;
		there		:= instr(line, spacing, stops);
		info		:= substr(line, here, there - here);		

--dbms_output.put_line ('STOPS:' ||stops|| '  HERE:' ||here|| '  THERE:' ||there|| '  INFO:' ||info || '  LABEL:'||label );

		if	label = first_title		then
			row_num := row_num + 01;
		end if;

		select	decode ( label, 
			'Site Address',	01,
			'Sq Feet',		02,
			'Valuation',	03,

--			'Activity', 	04,
--			'Type',		05,
--			'Sub Type',		06,
--			'Description',	07,
--			'Occupancy',	08,

			 NULL		)
		into		col_num
		from		dual;

	end if;

	if	col_num > 0					then

		insert into garland.temp_view1	values 
		(
			lpad(row_num,4,'0'), 
			lpad(col_num,4,'0'), 
			label, 
			info
		);

		commit;

		insert_count := insert_count + 01;

	end if;

end loop;

--		 cnt1 := cnt1 + 01;
--		EXIT when cnt1 = 10;	

end loop;


	dbms_output.put_line ( 'Total Inserts: ' || insert_count);

end;
	
--	=======================================================================================
--	=======================================================================================
