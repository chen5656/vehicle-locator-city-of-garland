	set echo 		off;
	set timing		off;
	set serveroutput	on		size 99999;
	select rpad(' ',70) " " from dual;
--	=====================================================================
--	address verification procedure called by VB "Address Finder"
--	=====================================================================

--	=====================================================================
--	prepare input view (temp_view of gis_objects)

--	@c:\deacutis\scripts\packages\address_finder\0_adrFinder_Sample.sql

--	=====================================================================

declare

	do_compile		number := 0;


	test_total		number := 0;

	this_total		number;
	idx			number;

	cursor  read_address is select * from temp_view;
	adr	  read_address%rowtype;

	adr_num		adr_finder_01.adr_num;
	adr_pfx		adr_finder_01.adr_prefix;
	adr_name		adr_finder_01.adr_name;
	adr_type		adr_finder_01.adr_type;
	adr_sfx		adr_finder_01.adr_suffix;
	adr_parcel		adr_finder_01.adr_parcel;
	adr_id		adr_finder_01.adr_id;
	adr_status		adr_finder_01.adr_status;

	best_status		varchar2(20);
	best_choice		binary_integer;

begin

	if	do_compile > 0		then
		return;
	end if;

	dbms_output.put_line (' ');
	dbms_output.put_line ('**********************************************************************');
	dbms_output.put_line (' ');


for look in read_address		loop

	test_total	:= test_total + 01;

	adr := look;

	best_status	:= adr.status;
	best_choice	:= adr.choice;


	dbms_output.put_line (	rpad(nvl(adr.addr_num,' '), 6) || rpad(nvl(adr.addr_pfx, ' '),3) || 
					rpad(adr.addr_name, 20)		 || rpad(nvl(adr.addr_type,' '),5) || 
					rpad(adr.addr_sfx,  03)	);


	dbms_output.put_line (	'         option: ' || rpad(nvl(best_status, ' '),7)
--				||	'     choice: '     || rpad(nvl(best_choice,  0 ),7) 	
				);


--	dbms_output.put_line (	'         choice: '|| rpad(nvl(best_choice,  0),7)	||
--					'     control: '   || rpad(nvl(best_status,' '),7) 	);

--	=====================================================================

--	ADR_Finder.verify_address
	ADR_Finder_01.verify_address

	(	
		adr.addr_num,	adr.addr_pfx,	adr.addr_name,	adr.addr_type,    adr.addr_sfx,
		adr_num,	 	adr_pfx,		adr_name,		adr_type,		adr_sfx,
		adr_parcel,		adr_id,		adr_status,
		best_status,	best_choice
	);

--	=====================================================================

	dbms_output.put_line (',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,');


	idx := 01;

while adr_status(idx) <> 'stop'		loop

	dbms_output.put_line (	rpad(nvl(adr_num(idx),' '), 6) || rpad(adr_pfx(idx),3) || 
					rpad(adr_name(idx),20)|| rpad(adr_type(idx),5) || rpad(adr_sfx(idx),3)	

					|| rpad (
					   rpad(' ',03)
					|| lpad(adr_id(idx),	06) 
					|| lpad(adr_parcel(idx),14) 
										   ,27)
					|| '' || adr_status(idx) || ''
				);

	idx	:= idx + 01;

	exit when idx > 999;

end loop;


--	TEMPORARY SUPPRESSION
--	dbms_output.put_line (	'         choice: '|| rpad(nvl(best_choice,  0),7)	||
--					'     control: '   || rpad(nvl(best_status,' '),7) 	);


	dbms_output.put_line (' ');
	dbms_output.put_line ('**********************************************************************');
	dbms_output.put_line (' ');

end loop;

	dbms_output.put_line (' ');
	dbms_output.put_line ('total = ' || test_total);

end;


