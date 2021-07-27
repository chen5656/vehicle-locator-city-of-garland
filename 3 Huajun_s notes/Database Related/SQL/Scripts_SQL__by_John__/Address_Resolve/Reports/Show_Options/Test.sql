--	===================================================================================================
--	for invalid street range, display segments with similar name and in range
--	===================================================================================================

	set serveroutput	on		size 999999;
	set timing		on;
	set echo		on;

--	===================================================================================================
--	enhance
--		addr1_name			name only
--		best.good count		non-null
--	===================================================================================================

declare

	do_compile_only		number	:= 0;

	match_count			number;

	user_name			varchar2(40);
	this_name			varchar2(40);
	this_num			number;
	this_lo_range		number;
	this_hi_range		number;
	posn				number;

--	===================================================================================
cursor	read_invalid_range		is

	select 	distinct
			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			addr_num,
			addr_name1
	from		gis_verify_addr

	where		verify_code = 3
	and		addr_num > 0
	;

--	===================================================================================

cursor	read_address_range		is

--	truncate table 	plan_table;
--	explain plan	set statement_id = 'test '	for

	select	--+	index_asc ( trvehrcl, trvehrcl_x_name_num)
--			distinct
			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,
			min(addr_lo)	addr_lo,
			max(addr_hi)	addr_hi

	from		trvehrcl
	where		addr_name like this_name || '%'
	and		addr_lo	>= this_lo_range
	and		addr_hi	<= this_hi_range
	and		rtrim(addr_name) <> user_name

	group by	addr_name, addr_type, addr_pfx, addr_sfx
	; 	

--	select * from explain_plan;

--	======================================================================

begin

	if	do_compile_only > 0		then
		return;
	end if;

for	ver in read_invalid_range		loop

	user_name	  := ver.addr_name;
	this_name	  := rpad (ver.addr_name, 03);

	this_lo_range := trunc (ver.addr_num, -2);
	this_hi_range := this_lo_range + 99;

	match_count	:= 0;

for	adr in read_address_range		loop

	match_count	:= match_count + 01;

	if	match_count = 01			then
		dbms_output.put_line (' ');

		dbms_output.put_line (	'app         ' ||	
					rpad(ver.addr_num, 06) || rpad(ver.addr_pfx,03) || rpad(ver.addr_name,21) ||
					rpad(ver.addr_type,05) || rpad(ver.addr_sfx,03)	);
	end if;

	dbms_output.put_line (	'gis   ' ||		
				rpad(adr.addr_lo,  06) || rpad(adr.addr_hi,    06)	||
				rpad(adr.addr_pfx, 03) || rpad(adr.addr_name, 21)	||
				rpad(adr.addr_type,05) || rpad(adr.addr_sfx,  03)	);

end loop;

end loop;

end;

