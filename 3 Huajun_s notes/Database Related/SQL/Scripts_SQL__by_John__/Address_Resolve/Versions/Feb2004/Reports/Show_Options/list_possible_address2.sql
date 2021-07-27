--	===================================================================================================
--	for invalid street name, display addresses with similar name and same number
--	using fuzzy name match
--	===================================================================================================

	set termout		on;
	set serveroutput	on		size 999999;
	set timing		on;
	set echo		off;

--	===================================================================================================
--	enhance
--	===================================================================================================

declare

	do_compile_only		number	:= 0;

	best_names			varchar2(800);
	good_names			varchar2(800);
	list_names			varchar2(800);

	best_count			number;
	good_count			number;
	list_count			number;

	this_name			varchar2(40);
	this_num			number;
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
			form_name
	from		adrResult

	where		verify_code = 01
	and		nvl(do_alias,' ') < '0'
	and		nvl(addr_num, 0 ) >  0;

--	===================================================================================
cursor	read_name_number		is

	select	addr_num,
			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,
			min(rowid)		row_id
	from		cdreladr

	where		addr_name	= this_name
	and		addr_num	= this_num
	and		nvl (unit_num,	' ') 	< '0'

	group by	addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			addr_num;

--	======================================================================

begin

	if	do_compile_only > 0		then
		return;
	end if;


for	ver in read_invalid_name		loop

	best_names	:= ver.form_name;
	good_count	:= -1;

	ADR_compare_names (best_names, good_names, best_count, good_count);

	match_count	:= 0;

--	======================================================================

for	l in 01..02					loop

	if	l = 01		then
		list_names	:= best_names;
		list_count	:= best_count;
	else
		list_names	:= good_names;
		list_count	:= good_count;
	end if;		

	posn := 01;


for	n in 01..list_count			loop

	this_name	:= rtrim (substr (list_names, posn, 20));	
	this_num	:= ver.addr_num;  

if	this_name <> ver.addr_name		then

--	dbms_output.put_line ('read name.num  ' || ver.addr_name1 ||' / '|| this_name ||'   '|| this_num); --	TEST

for	adr in read_name_number			loop

	match_count	:= match_count + 01;

	if	match_count = 01			then
		dbms_output.put_line (' ');

		dbms_output.put_line (	'app   ' ||
					rpad(ver.addr_num, 06) || rpad(ver.addr_pfx,03) || rpad(ver.addr_name,21) ||
					rpad(ver.addr_type,05) || rpad(ver.addr_sfx,03)	);
	end if;

	dbms_output.put_line (	'gis   ' ||		
				rpad(adr.addr_num, 06) || 							
				rpad(adr.addr_pfx, 03) || rpad(adr.addr_name, 21) ||
				rpad(adr.addr_type,05) || rpad(adr.addr_sfx,  03)	);
end loop;

end if;

	posn := posn + 20;				

end loop;

end loop;

end loop;


end;

--	===================================================================================
