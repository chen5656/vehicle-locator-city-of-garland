	set echo		off;
	set serveroutput	on	size 9999;
--	=======================================================================================
--	Extract titles & info from building inspection report
--	=======================================================================================

--	Activity: Type: Sub Type: Sq Feet: Site Address: Description: Occupancy: Valuation:

/*
--	=======================================================================================
--	define output table

	create or replace	view		garland.temp_view		as
	select item01, item02, item03, item04	from garland.gis_temp1;

	Truncate table	garland.gis_temp1		reuse storage;

--	=======================================================================================
--	set rec seq to fixed length number

	update  garland.gis_objects
	set	item02 = lpad(item02,04,'0');
	commit;

--	=============================================================================
*/



	Truncate table	garland.gis_temp1		reuse storage;



declare

	do_compile		binary_integer := 0;

	title_list		varchar2(1000)  := 
				'Activity: Type: Sub Type: Site Address: Description: Occupancy: Valuation:';


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

for	look in (select item01 from GIS_Objects	order by item02)	
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

		select	decode ( label, 
			'Activity', 	01,
			'Type',		02,
			'Sub Type',		03,
			'Site Address',	04,
			'Description',	05,
			'Occupancy',	06,
			'Valuation',	07,
			 NULL		)
		into		col_num
		from		dual;

	end if;

	if	col_num > 0					then

		if	col_num = 01			then
			row_num := row_num + 01;
		end if;

		insert into garland.temp_view		values 
		(
			row_num, 
			col_num, 
			label, 
			info
		);

		commit;

	end if;

end loop;

end loop;

end;

	
--	=======================================================================================
--	=======================================================================================







