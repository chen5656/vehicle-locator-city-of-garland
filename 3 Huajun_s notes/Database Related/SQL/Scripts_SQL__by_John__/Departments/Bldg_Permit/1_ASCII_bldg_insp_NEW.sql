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

--	PREPARE:	Execute 0_Extract_Report to build garland.gis_objects

--	=======================================================================================

--	select lpad(item01,5) seq, rpad(item02,30) text from garland.gis_objects order by item01;

--	select rpad(rec,05) rec, rpad(col,05) col, rpad(title,20) label, rpad(info,30) info  
--	from garland.Temp_View1 order by rec, col;

--	select distinct substr(info,instr(info,' ',-1)) from garland.Temp_View1	where col = 0002;
	
--	select distinct col from garland.Temp_View1;

--	=======================================================================================
--	SPECIFY INPUT TABLE    <<<<<<<<<<<<<<<<<<<

	drop synonym     jdeacutis.temp_syn;
	create synonym   jdeacutis.temp_syn    for garland.GIS_Objects;

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
					'Activity: Site Address: Valuation: Sq Feet:'
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


for	look in (select item02 from jdeacutis.TEMP_SYN order by item01)
loop

	line	:= look.item02;
	line	:= spacing || ltrim(rtrim(line)) || spacing;

--	look for desired title within each line
--	mark their positions

	stops	:= 1;

-- dbms_output.put_line ('---');
-- dbms_output.put_line ('A-STOPS:' || stops || '  LINE:' ||line);

while	stops > 0		loop

-- dbms_output.put_line ('---');
	
	here		:= stops + 01;					-- begin search "here"
	stops		:= instr (line, ':', here);			-- "stops" = end of label
	col_num	:= null;

-- dbms_output.put_line ('1-STOPS:' ||stops|| '  HERE:' ||here );
	
	if	stops > 0					then

		text		:= substr(line, 01, stops - 01);
		starts	:= instr (text, spacing, -1) + space_len;	
		label		:= substr(text, starts);			

-- dbms_output.put_line ('2-TEXT:' ||text|| '  STARTS:' ||starts|| '  LABEL:' ||label);

		here		:= stops + 01;
		there		:= instr(line, spacing, stops);
		info		:= substr(line, here, there - here);		

-- dbms_output.put_line ('3-STOPS:' ||stops|| '  HERE:' ||here|| '  THERE:' ||there||  '  LABEL:'||label|| '  INFO:' ||info);

		if	label = first_title		then
			row_num := row_num + 01;
		end if;

		if	label = 'Site Address'
		and	info like '% GARL'		then
			info := substr(info, 01, instr(info,' GARL',-1) -1);
		end if;

		select	decode ( label, 
--			'Activity', 	01,
			'Site Address',	02,
--			'Sq Feet',		03,
			'Valuation',	04,

--			'Type',		05,
--			'Sub Type',		06,
--			'Description',	07,
--			'Occupancy',	08,

			 NULL		)
		into		col_num
		from		dual;

	end if;

-- if col_num > 0 then dbms_output.put_line ('4-DECODE:' || row_num ||'.'||col_num ||' '|| label ||' '|| info ); end if;

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
