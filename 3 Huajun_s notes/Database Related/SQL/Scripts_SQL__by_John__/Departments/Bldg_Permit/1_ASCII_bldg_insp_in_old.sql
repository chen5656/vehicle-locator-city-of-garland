	set echo		off;
	set serveroutput	on	size 9999;
--	=======================================================================================
--	Extract titles & info from building inspection report
--	=======================================================================================

--	Activity: Type: Sub Type: Sq Feet: Site Address: Description: Occupancy: Valuation:

--	=======================================================================================
--	PREPARE:	Revise Title_List
--	PREPARE:	Revise Decode command near end of script
--	PREPARE:	Specify which External_View should be processed
--	    see:	for	look in (select item01 from jdeacutis.EXTERNAL_VIEW)

--	=======================================================================================
--	define output table

	create or replace	view		garland.temp_view1		
	(	 rec, col, title, info	)
	as
	select item01, item02, item03, item04	from garland.gis_temp1;

	Truncate table	garland.gis_temp1		reuse storage;

--	=============================================================================

	Truncate table	garland.gis_temp1		reuse storage;

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

begin

	if	do_compile > 0		then
		return;
	end if;

	row_num 	:= 0;

--	scan each line of building inspection report

for	look in (select item01 from jdeacutis.EXTERNAL_VIEW1)
loop

	line	:= look.item01;
	line	:= spacing || ltrim(rtrim(line)) || spacing;

--	look for desired title within each line
--	mark their positions

	stops	:= 1;

while	stops > 0		loop
	
	here		:= stops + 01;					-- begin search "here"
	stops		:= instr (line, ':', here);			-- "stops" = end of label
	col_num	:= null;
	
	if	stops > 0					then

		text		:= substr(line, 01, stops - 01);
		starts	:= instr (text, spacing, -1) + space_len;	
		label		:= substr(text, starts);			

		here		:= stops + 01;
		there		:= instr(line, spacing, stops);
		info		:= substr(line, here, there - here);		

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

end loop;

	dbms_output.put_line ( 'Total Inserts: ' || insert_count);

end;

	
--	=======================================================================================
--	=======================================================================================
