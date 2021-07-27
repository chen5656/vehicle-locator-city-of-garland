	set echo		off;
	set charwidth	200;
	set serveroutput	on	size 99999;
--	=============================================================================
--	display procedure & function scripts
--	=============================================================================

--	select rtrim(text, chr(10))	" "
--	from user_source
--	where name = 'NIRANJAN'		--  CHANGE  --
--	order by type,line;

--	use notepad to remove excessive spaces from script


--	=============================================================================
--	problems
--		'' / ';' / ',' / '"' / ";" / "," 			not handled correctly
--	=============================================================================

declare

--	spec_program	varchar2(40)	:= 'FA_VALUE';	
	spec_program	varchar2(40)	:= 'ATTRIB_VALUE';

	do_compile		number	:= 0;
	do_print		number	:= 01;
	do_test		number	:= 0;

	min_source		number	:= 1000;	--	trigger dba_source input
	min_leng		number	:= 40;	--	minimum output line
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

	here	:= 01;

loop

begin

	while	source_leng - here < min_source
	and	source_end  = 0					loop
		source_seq	:= source_seq + 01;

		select text
		into	 source_input
		from	 dba_source@umsp.world
		where	 name = spec_program
		and	 line = source_seq;

		if	source_input like '--%'			then
			null;
		else
			source	:= substr (source, here) || source_input;
			source_leng	:= length (source);
			here		:= 01;
		end if;

		if	do_test > 0					then
			dbms_output.put_line ('			' || rpad(source_input,250));	--	TEST
		end if;
	end loop;

exception

	when others	then	
		source_end := source_leng;
		if	do_test > 0			then
			dbms_output.put_line ( 'source ends at line ' || source_seq);
		end if;
end;

	look := here + min_leng;

	next	:= instr (source, ';', here);

	if	next - here not between 01 and max_leng		then
		next	:= instr (source, ',', look);
	end if;

	if	next - here not between 01 and max_leng		then
		next	:= instr (source, '''', here, 2);
	end if;

	if	next - here not between 01 and max_leng		then
		next	 := instr (source, '"', here, 2);
	end if;

	if	next - here not between 01 and max_leng		then
		next	:= instr (source, ' ', look);
	end if;

	if	next - here not between 01 and max_leng		then
		next	:= instr (source, ' ',3);						--	oct 2002
	end if;

	if	next - here not between 01 and max_leng		then
		next	:= instr (source, ')', look);
	end if;

	if	next - here not between 01 and max_leng		then
		next	:= source_leng;
	end if;

	if	next - here not between 01 and max_leng		then
		dbms_output.put_line ('ERROR - output too long');
		dbms_output.put_line (substr (source, here, 100));
		exit;
	end if;

--	-----------------------------------------------------------------------------------------

	show_line := rtrim (substr (source, here, next - here + 01));

	if	do_print  > 0
	and	show_line is not null				then
		dbms_output.put_line ('    ' || show_line);
	end if;

	if	do_test > 0		then
		dbms_output.put_line 									--	TEST
		('			' || 'here=' || here || ' next=' || next || ' leng=' || source_leng);

		dbms_output.put_line ('			' || substr (source, here, 80));	--	TEST
		dbms_output.put_line (' ');		
	end if;

	here := next + 01;
	exit when 	source_end > 0
		and	source_end <= here;

	exit when	here is null;

	max_loop := max_loop - 01;
	if	max_loop < 0		then
		dbms_output.put_line ( 'ERROR = looping');
		exit;
	end if;

end loop;

end;


--	=============================================================================
/*
	select text
	from	 dba_source@umsp.world	
	where	 name = 'FA_VALUE'
	and	 line = 01;
*/
--	=============================================================================

