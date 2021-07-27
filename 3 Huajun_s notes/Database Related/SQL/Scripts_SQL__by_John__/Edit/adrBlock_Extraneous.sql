--	search for extraneous adrBlock records
--	based on TRVEHRCL address ranges

	set echo		off;
	set serveroutput	on	size 100000;

declare
		do_compile_only	number	:= 0;
		error_count		number	:= 0;
		block_count		number	:= 0;
		test_count		number	:= 0;

cursor	read_block		is
		select *	from adrBlock
		order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_block;

--	==========================================================================================

begin

	if	do_compile_only > 0	then
		return;
	end if;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( '	Extraneous adrBlock Records' );
	dbms_output.put_line ( ' ' );

for	scan in read_block		loop

	select 	count(*)
	into		test_count	
	from 		trvehrcl

	where		addr_name	= scan.addr_name
	and		addr_type	= scan.addr_type
	and		addr_pfx	= scan.addr_pfx
	and		addr_sfx	= scan.addr_sfx
	and		scan.addr_block  between trunc(addr_lo,-2) and addr_hi;

	if	test_count = 0			then
		error_count	:= error_count + 01;

		dbms_output.put_line (	lpad(scan.addr_block,5) ||'   '|| 
						scan.addr_pfx  ||' '|| scan.addr_name ||' '||
						scan.addr_type ||' '|| scan.addr_sfx		);
	end if;

end loop;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( '	extraneous blocks	' || error_count);

end;

