	set echo		off;
	set timing		off;
	set serveroutput	on	size 99999;

--	==========================================================================
--	adr_parse_address test harness
--	==========================================================================

declare
		do_compile		number	:= 0	;
		do_parse		number	:= 01	;

		cycles		number	:= 01		;
--		cycles		number	:= 01000	;

		start_key		number	:= 01		;
		stop_key		number	:= 099	;

		page_size		number	:= 46	;
		group_size		number	:= 06	;

		adr1_num		varchar2(80);
		adr1_pfx		varchar2(80);
		adr1_name		varchar2(80);
		adr1_type		varchar2(80);
		adr1_sfx		varchar2(80);
		adr1_code1		varchar2(80);
		adr1_unit1		varchar2(80);
		adr1_code2		varchar2(80);
		adr1_unit2		varchar2(80);
		adr1_audit		varchar2(80);

		adr2_num		varchar2(80);
		adr2_pfx		varchar2(80);
		adr2_name		varchar2(80);
		adr2_type		varchar2(80);
		adr2_sfx		varchar2(80);
		adr2_code1		varchar2(80);
		adr2_unit1		varchar2(80);
		adr2_code2		varchar2(80);
		adr2_unit2		varchar2(80);
		adr2_audit		varchar2(80);

		headings		varchar2(120) := 
					'pfx  name                                       type      sfx       ' 
				||	'code1  unit1   code2  unit2';

		stars			varchar2(120)	:= rpad ('*',105,'*');

		samples		number	:= 0;
		line_count		number	:= 0;
	
--	==========================================================================
cursor	read_adr_parse	is

		select 	all *
		from		garland.adr_parse_test_vw
--		where		key	between start_key	and stop_key
		order by	key;
	
--	==========================================================================
begin

	if	do_compile > 0		then
		return;
	end if;

	dbms_output.put_line ( stars);
	dbms_output.put_line ('Line 1:  column headings');
	dbms_output.put_line ('Line 2:  input  address ');
	dbms_output.put_line ('Line 3:  output desired ');
	dbms_output.put_line ('Line 4:  output obtained');
	dbms_output.put_line ('Line 5:  input, desired, actual audit');
	line_count := group_size;


for cycle in 1..cycles			loop 

for look in	read_adr_parse		loop

	adr1_num	:= nvl(	 look.addr_num,	' ');
	adr1_pfx	:= nvl(upper(look.addr_pfx),  ' ');
	adr1_name	:= nvl(upper(look.addr_name), ' ');
	adr1_type	:= nvl(upper(look.addr_type), ' ');
	adr1_sfx	:= nvl(upper(look.addr_sfx),  ' ');
	adr1_code1	:= nvl(upper(look.addr_code1),' ');
	adr1_unit1	:= nvl(upper(look.addr_unit1),' ');
	adr1_code2	:= nvl(upper(look.addr_code2),' ');
	adr1_unit2	:= nvl(upper(look.addr_unit2),' ');
	adr1_audit	:= nvl(upper(look.addr_audit),' ');

	adr2_num	:= adr1_num;
	adr2_pfx	:= adr1_pfx;
	adr2_name	:= adr1_name;
	adr2_type	:= adr1_type;
	adr2_sfx	:= adr1_sfx;
	adr2_code1	:= adr1_code1;
	adr2_unit1	:= adr1_unit1;
	adr2_code2	:= adr1_code2;
	adr2_unit2	:= adr1_unit2;
	adr2_audit	:= adr1_audit;

	if	do_parse > 0			then
		garland.TST_parse_address (
					adr2_num,	adr2_pfx,	adr2_name,	adr2_type,	adr2_sfx,
					adr2_code1,	adr2_unit1,	adr2_code2,	adr2_unit2,
					adr2_audit	);
	end if;

	adr2_num		:= nvl(adr2_num,  ' ');
	adr2_code1		:= nvl(adr2_code1,' ');
	adr2_unit1		:= nvl(adr2_unit1,' ');
	adr2_code2		:= nvl(adr2_code2,' ');
	adr2_unit2		:= nvl(adr2_unit2,' ');


	if	cycle = 1				then
					
		if	page_size - line_count < group_size		then
			for x in line_count + 01..page_size		loop
				dbms_output.put_line (' ');
			end loop;
			line_count	:= 0;
		end if;

		line_count := line_count + group_size;

		dbms_output.put_line ( stars);
		dbms_output.put_line ( rpad('<' ||look.key || '>',07) || headings );
					
		dbms_output.put_line (
			rpad (adr1_num,	07)		||
			rpad (adr1_pfx,	05)		||
			rpad (adr1_name,	43)		||
			rpad (adr1_type,	10)		||
			rpad (adr1_sfx,	10)		||
			rpad (adr1_code1,	07)		||
			rpad (adr1_unit1,	08)		||
			rpad (adr1_code2,	07)		||
			rpad (adr1_unit2,	08)
		);
	
		dbms_output.put_line (upper(look.note));
					
		dbms_output.put_line (
			rpad (adr2_num,	07)		||
			rpad (adr2_pfx,	05)		||
			rpad (adr2_name,	43)		||
			rpad (adr2_type,	10)		||
			rpad (adr2_sfx,	10)		||
			rpad (adr2_code1,	07)		||
			rpad (adr2_unit1,	08)		||
			rpad (adr2_code2,	07)		||
			rpad (adr2_unit2,	08)
		);
	
--		dbms_output.put_line (upper(look.note));
					
		dbms_output.put_line (
			rpad (nvl(look.addr_audit,' '),20)	||
			rpad (nvl(look.note_audit,' '),35)	||
			rpad (nvl(adr2_audit,' '),	 35)	
		);

	end if;

end loop;

end loop;

	select max (key)  
	into	 samples
	from 	garland.adr_parse_test_vw;
					
	dbms_output.put_line (' ');
	dbms_output.put_line ('cycles   =' || lpad(cycles, 7));
	dbms_output.put_line ('samples  =' || lpad(samples,7));
	dbms_output.put_line ('executes =' || lpad(cycles * samples,7));
	
end;
