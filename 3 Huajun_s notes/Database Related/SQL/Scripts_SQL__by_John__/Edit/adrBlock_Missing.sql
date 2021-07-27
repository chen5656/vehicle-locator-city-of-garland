--	search for missing adrBlock records
--	based on TRVEHRCL address ranges

	set echo		off;
	set serveroutput	on	size 100000;

declare
		do_compile_only	number	:= 0;

		error_count		number	:= 0;
		last_block		number	:= 0;

		this_block		number;
		block_hi		number;
		block_count		number;
		range_count		number;

		prev_name		varchar2(40);
		prev_type		varchar2(04);
		prev_pfx		varchar2(02);
		prev_sfx		varchar2(02);

cursor	read_range		is

		select *	from trvehrcl
		where		addr_name > '0'
		order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_lo, addr_hi;

--	==========================================================================================

begin

	if	do_compile_only > 0	then
		return;
	end if;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( '	Missing adrBlock Records' );
	dbms_output.put_line ( ' ' );

for	scan in read_range		loop

	if	scan.addr_name	= prev_name
	and	scan.addr_type	= prev_type
	and	scan.addr_pfx	= prev_pfx
	and	scan.addr_sfx	= prev_sfx		then
		null;
	else
		prev_name	:= scan.addr_name;
		prev_type	:= scan.addr_type;
		prev_pfx	:= scan.addr_pfx;
		prev_sfx	:= scan.addr_sfx;
		last_block	:= 0;
		range_count	:= 0;
	end if;

	range_count	:= range_count + 01;
	this_block	:= trunc (scan.addr_lo, -2);
	block_hi	:= trunc (scan.addr_hi, -2) + 99;

while	this_block <= block_hi			loop

	select 	count(*)
	into		block_count	
	from 		adrBlock

	where		addr_name	= scan.addr_name
	and		addr_type	= scan.addr_type
	and		addr_pfx	= scan.addr_pfx
	and		addr_sfx	= scan.addr_sfx
	and		addr_block	= this_block;

	if	block_count <> 1		
	and	this_block  >  last_block	then
		error_count	:= error_count + 01;

		dbms_output.put_line (	lpad(this_block,5)   ||'   '|| 

						rpad (
						scan.addr_pfx  ||' '|| scan.addr_name ||' '||
						scan.addr_type ||' '|| scan.addr_sfx
						,37)		   || 

						lpad(scan.addr_lo,5)    ||'-'|| rpad(scan.addr_hi,05)
						||'	count = '|| block_count ||' at segment ' || range_count);			
	end if;

	if	last_block  < this_block		then
		last_block := this_block;
	end if;

	this_block	:= this_block + 100;

end loop;

end loop;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( '	missing blocks	' || error_count);

end;
