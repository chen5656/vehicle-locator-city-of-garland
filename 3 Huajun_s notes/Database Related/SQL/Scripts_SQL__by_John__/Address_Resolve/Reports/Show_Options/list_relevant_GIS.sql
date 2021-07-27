
--	display relevant GIS records for adrResult addresses

	set echo 		off;
	set serveroutput	on	size 999999;

declare

	do_compile_only	number	:= 0;

	do_adrResult	number	:= 01;
	do_adrObject	number	:= 0;

	show_file		varchar2(10);
	show_code		varchar2(10);

--		================================================================================
cursor	read_adrResult	is

		select * from adrResult

		where	verify_code 	between 20 and 54

		and	verify_code		= 53

--		and	mod(verify_code,10) < 5


		order by verify_code, addr_name, addr_type, addr_pfx, addr_sfx, addr_num;

		ADR	read_adrResult%rowtype;

--		================================================================================
cursor	read_adrObject		is

		select all * 	
		from
(		select	item01	addr_num,
				item02	addr_pfx,
				item03	addr_name,
				item04	addr_type,
				item05	addr_sfx,
				item06	verify_code,
				item07	rec_key
		from	gis_objects
)
		where verify_code < 55
		and	trunc(verify_code, -1) between 10 and 50
--		and	mod(verify_code,10) < 5

		order by verify_code, addr_name, addr_type, addr_pfx, addr_sfx, addr_num;

		OBJ	read_adrObject%rowtype;

--	==============================================================================================

begin

	if	do_compile_only > 0			then
		return;
	end if;

	dbms_output.put_line ( ' ' );

	if	do_adrResult > 0				then
		open	read_adrResult;
	elsif	do_adrObject > 0				then
		open	read_adrObject;
	end if;

loop

	if	do_adrResult > 0				then
		fetch	read_adrResult	into adr;	
		exit when	read_adrResult%notfound
			or	read_adrResult%notfound is null;

	elsif	do_adrObject > 0				then
		fetch	read_adrObject	into obj;	
		exit when	read_adrObject%notfound
			or	read_adrObject%notfound is null;

		adr.addr_name	:= obj.addr_name;
		adr.addr_type	:= obj.addr_type;
		adr.addr_pfx	:= obj.addr_pfx;
		adr.addr_sfx	:= obj.addr_sfx;
		adr.addr_num	:= obj.addr_num;
		adr.verify_code	:= obj.verify_code;
		adr.rec_key		:= obj.rec_key;
	end if;

--	===============================================================================================

	select decode (trunc(adr.verify_code, -1), 50, 'address', 40, 'range', 30, 'block', 20, 'orphan', 'street')
	into	 show_file	from	dual;

	select decode (mod(adr.verify_code,10), 5, 'full', 4, 'partial', 3, 'wrong', 2, 'mixed', 1, 'poor', ' ')
	into	 show_code	from	dual;


	dbms_output.put_line ('									Error = ' || 
		 show_code ||' '|| show_file || ' ('  || adr.verify_code  ||')'	);

	dbms_output.put_line ( 'User    ' || rpad(nvl(adr.addr_num||' ',' '),12) || rpad(adr.addr_pfx,02) || 
					rpad(adr.addr_name,21) || rpad(adr.addr_type,05) || rpad(adr.addr_sfx,04) ||
					'  Key   = ' || rpad(adr.rec_key,20) 
					); 


for	look in (select * from adrStreets where addr_name = adr.addr_name)		
loop
	dbms_output.put_line ( 'Street  ' || rpad(' ',12) || rpad(look.addr_pfx,02)  || 
					rpad(look.addr_name,21)	  || rpad(look.addr_type,05) || rpad(look.addr_sfx,02) 	
					); 
end loop;


for	look in (select *	from adrBlock where addr_block = trunc(adr.addr_num, -2) and addr_name = adr.addr_name)
loop
	dbms_output.put_line ( 'Block   ' || rpad(look.addr_block,12) || rpad(look.addr_pfx,02) || 
					rpad(look.addr_name,21) || rpad(look.addr_type,05) || rpad(look.addr_sfx,02)	); 
end loop;


for	look in (select *	from trvehrcl where addr_name = adr.addr_name and adr.addr_num between addr_lo and addr_hi)

loop
	dbms_output.put_line ( 'Range   ' || rpad(look.addr_lo,06) || rpad(look.addr_hi,06) || rpad(look.addr_pfx,02) || 
					rpad(look.addr_name,21) || rpad(look.addr_type,05) || rpad(look.addr_sfx,02)	); 
end loop;


for	look in (select *	from cdreladr where addr_name = adr.addr_name and addr_num = adr.addr_num)
loop
	dbms_output.put_line ( 'Address ' || rpad(look.addr_num,12) || rpad(look.addr_pfx,02) || 
					rpad(look.addr_name,21) || rpad(look.addr_type,05) || rpad(look.addr_sfx,02)	); 
end loop;

end loop;

	if	do_adrResult > 0		then
		close	read_adrResult;
	elsif	do_adrObject > 0		then
		close	read_adrObject;
	end if;

end;
