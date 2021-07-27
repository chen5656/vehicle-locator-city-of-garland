	set echo		off;
	set serveroutput	on		size 99999;
	set charwidth	400;

--	=========================================================================================
--	display procedure & function scripts
--	=========================================================================================

--	=========================================================================================
--	problems
--		'' / ';' / ',' / ')' / '"' / ";" / "," / ")"	are not handled correctly
--	=========================================================================================

declare

	spec_program	varchar2(40)	:= 'FA_VALUE';	
--	spec_program	varchar2(40)	:= 'ATTRIB_VALUE';	

	do_compile		number	:= 0;
	do_print		number	:= 01;
	do_test		number	:= 0;

	min_source		number	:= 1000;	--	trigger dba_source input
	min_leng		number	:= 040;	--	minimum output line
	max_leng		number	:= 100;	--	maximum output line
	max_loop		number	:= 1000;	--	prevent runaway looping

	here			number	:= 0;		
	next			number	:= 0;
	look			number	:= 0;		--	start search position
	source_seq		number	:= 0;
	source_end		number	:= 0;
	source_leng		number	:= 0;

	source		varchar2(8000);
	source_input	varchar2(4000);
	show_line		varchar2(400);

begin

	if	do_compile > 0		then
		return;
	end if;

	select max(line)
	into	 source_end
	from	 dba_source@umsp.world
	where	 name = spec_program;

	here	:= 01;

loop

	while	source_leng - here < min_source
	and	source_seq  < source_end			loop
		source_seq := source_seq + 01;
		select text
		into	 source_input
		from	 dba_source@umsp.world
		where	 name = spec_program
		and	 line = source_seq;

--		source_input	:= replace (source_input, rpad(' ',3), ' ');
--		source_input	:= replace (source_input, rpad(' ',2), ' ');
--		source_input	:= replace (source_input, rpad(' ',2), ' ');
--		source_input	:= replace (source_input, rpad(' ',2), ' ');

		if	source_input like '--%'			then
			null;
		else
			source	:= substr (source, here) || source_input;
			source_leng	:= length (source);
			here		:= 01;
		end if;

		if	do_test > 0					then
			dbms_output.put_line ('			///' || rpad(source_input,200));	--	TEST
		end if;
	end loop;

	look := here + min_leng;

	next := instr (source, ';', here);

	if	next - here not between 00 and max_leng		then
		next	:= instr (source, ',', look);
	end if;

	if	next - here not between 00 and max_leng		then
		next	:= instr (source, '''', here, 2);
	end if;

	if	next - here not between 00 and max_leng		then
		next	 := instr (source, '"', here, 2);
	end if;

	if	next - here not between 00 and max_leng		then
		next	:= instr (source, ' ', look);
	end if;

	if	next - here not between 00 and max_leng		then
		next	:= instr (source, ' ');
	end if;

	if	next - here not between 00 and max_leng		then
		next	:= instr (source, ')', look);
	end if;

	if	next - here not between 00 and max_leng		then
		next	:= source_leng;
	end if;

	if	next - here not between 00 and max_leng		then
		dbms_output.put_line ('PROGRAM ERROR - make max_leng bigger');
		exit;
	end if;

--	-----------------------------------------------------------------------------------------

	show_line := rtrim (substr (source, here, next - here + 01));

	if	do_print  > 0
	and	show_line is not null		then
		dbms_output.put_line ('    ' || show_line);
	end if;

	if	do_test > 0				then
		dbms_output.put_line 									--	TEST
		('			' || 'here=' || here || ' next=' || next || ' leng=' || source_leng);

		dbms_output.put_line ('			|||' || substr (source, here, 80));	--	TEST
		dbms_output.put_line (' ');		
	end if;

	here := next + 01;

	exit when 	source_seq = source_end
		and	here >= source_leng;

	max_loop := max_loop - 01;
	if	max_loop < 0		then
		dbms_output.put_line ( 'ERROR = looping');
		exit;
	end if;

end loop;

end;


--	=========================================================================================
/*
	select text
	from	 dba_source@umsp.world	

	where	 name = 'FA_VALUE'
--	where	 name = 'ATTRIB_VALUE'

	and	 line = 01;
*/
--	=========================================================================================
