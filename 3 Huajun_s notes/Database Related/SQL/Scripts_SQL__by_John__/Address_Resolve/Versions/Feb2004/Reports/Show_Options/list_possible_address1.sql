--	===================================================================================================
--	for invalid street name, display addresses with similar name and same number
--	using simple soundex match
--	===================================================================================================

	set termout		on;
	set echo		off;
	set timing		off;
	set serveroutput	on		size 999999;

--	===================================================================================================
--	enhance
--	===================================================================================================

declare

	do_compile_only		number	:= 0;
	spec_leading		number	:= 04;	--	look at names with # of leading characters
	spec_show_key		number	:= 01;

	user_name			varchar2(40);
	user_key			varchar2(40);

	this_name			varchar2(40);
	this_num			number;
	this_lo_range		number;
	this_hi_range		number;
	posn				number;
	match_count			number;

--	===================================================================================
cursor	read_invalid_name		is

	select 	distinct
			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			addr_num,
			do_alias,
			nvl (form_name, addr_name)	form_name,
			do_name,								-- TESTING
			rec_key
	from		adrResult

	where		verify_code between 01 and 09
	and		nvl(do_alias,' ') < '0'
	and		nvl(addr_num,0)   >  0
	;

--	===================================================================================
cursor	read_name_number		is

	select	addr_num,
			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,
			min(rowid)		row_id
	from		cdreladr

	where		addr_name like this_name || '%'
	and		addr_name   <> user_name 
	and		addr_num	=  this_num			
	and		nvl (unit_num, ' ') < '0'

	group by	addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			addr_num;

--	===================================================================================

begin

	if	do_compile_only > 0		then
		return;
	end if;

	dbms_output.put_line (' ' );
	dbms_output.put_line ('Similar Street with Same Number' );
	dbms_output.put_line (' ' );


for	ver in read_invalid_name		loop

	if	spec_show_key > 0			then
		user_key := ver.rec_key;
	else
		user_key := ' ';
	end if;

	user_name := rtrim(ver.addr_name);

	this_name := rpad (ver.form_name, spec_leading);
	this_num  := ver.addr_num;

	match_count := 0;


--	if	ver.form_name like 'WEST%'	then
--	dbms_output.put_line ( 'old = ' || ver.form_name || '  new = ' || ver.addr_name ||' '|| user_name 
--					|| ' do name = ' || ver.do_name);
--	end if;


for	adr in read_name_number			loop

	match_count	:= match_count + 01;

	if	match_count = 01			then
		dbms_output.put_line (' ');
		dbms_output.put_line ('app   ' ||
					rpad(ver.addr_num, 06)	|| 
					rpad(ver.addr_pfx, 03)	|| rpad(ver.addr_name,21) ||
					rpad(ver.addr_type,05)	|| rpad(ver.addr_sfx, 08) ||
					rpad(user_key,12)		|| rpad(ver.form_name, 20) || ver.do_alias);
	end if;

	dbms_output.put_line ('gis   ' ||		
				rpad(adr.addr_num, 06) || 							
				rpad(adr.addr_pfx, 03) || rpad(adr.addr_name, 21) ||
				rpad(adr.addr_type,05) || rpad(adr.addr_sfx,  03)	);
end loop;

end loop;

end;

