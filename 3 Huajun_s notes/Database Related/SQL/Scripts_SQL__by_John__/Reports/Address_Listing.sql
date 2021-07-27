	set echo 		off;
	set serveroutput	on		size 999999;
--	=============================================================================================
--	generate Garland address list

--	Word Document Settings		100%		Normal	Courier	7.5
--						Top & Bottom = 1.0	Left & Right = 0.5
--	=============================================================================================

declare

	do_compile		binary_integer	:= 0;

	page_size		binary_integer	:= 76;
	line_size		binary_integer	:= 18;
	lines			binary_integer	:= 0;
	rows			binary_integer	:= 0;
	item			binary_integer	:= 0;

	line			varchar2(200);
	prev_name		varchar2(20);
	prev_type		varchar2(04);
	prev_pfx		varchar2(02);
	prev_sfx		varchar2(02);


cursor	read_address		is

	select addr_name, addr_type, addr_pfx, addr_sfx, 
		'A'			class, 
		count(*)		addr_num
	from	garland.cdrelADR
	where	addr_num > 0
	and	rtrim(unit_type) is null
	and	rtrim(unit_num)  is null

	and	ADDR_NAME LIKE 'WALNUT%'				-- TESTING

	group by addr_name, addr_type, addr_pfx, addr_sfx

	union

	select addr_name, addr_type, addr_pfx, addr_sfx, 
		'B'			class, 
		addr_num
	from
(
	select addr_name, addr_type, addr_pfx, addr_sfx, addr_num
	from	garland.cdrelADR
	where	addr_num > 0
	and	rtrim(unit_type) is null
	and	rtrim(unit_num)  is null

	and	ADDR_NAME LIKE 'WALNUT%'					-- TESTING

)
	order by	1,2,3,4,5,6;

--	=============================================================================================

begin

	if	do_compile > 0		then
		return;
	end if;

--	dbms_output.put_line (' ');

for	look in read_address		loop


--	if	look.class = 'A'		then
--		dbms_output.put_line (	'summary ' || look.addr_name ||' '|| look.addr_num );
--	end if;
		

	if	look.addr_name	= prev_name
	and	look.addr_type	= prev_type
	and	look.addr_pfx	= prev_pfx
	and	look.addr_sfx	= prev_sfx			then
		null;
	else
		dbms_output.put_line (	rpad(' ',10) || line);
		lines := lines + 01;
		line  := null;
		item   := 0;

		prev_name	:= look.addr_name;
		prev_type	:= look.addr_type;
		prev_pfx	:= look.addr_pfx;
		prev_sfx	:= look.addr_sfx;

		rows	:= ceil(look.addr_num / line_size);

--		dbms_output.put_line (	'next page ' || lines ||' '|| look.addr_num ||' '|| rows ||' '|| page_size);

		if	lines + rows + 02 > page_size		then
			while	lines < page_size			loop
				dbms_output.put_line (' ');
				lines	:= lines + 01;		
			end loop;
			lines	:= 0;
		end if;

--		dbms_output.put_line (	rpad(' ',10) || line);
		dbms_output.put_line (	rpad(look.addr_pfx, 02) ||' '||rpad(look.addr_name,20) ||' '||
						rpad(look.addr_type,04) ||' '||rpad(look.addr_sfx,02) );
		lines := lines + 01;
		line  := null;
		item   := 0;
		goto	end_loop;
	end if;

	if	item = line_size		then
		dbms_output.put_line (rpad(' ',10) || line);
		lines	:= lines + 01;
		line	:= null;
		item	:= 0;
	end if;

	item	:= item + 01;
	line	:= line || lpad(look.addr_num, 06);

<<end_loop>>
	null;
end loop;

	dbms_output.put_line (rpad(' ',10) || line);
	dbms_output.put_line (' ');

end;	
