	set echo 		on;
	set serveroutput	on;
--	=============================================================
--	Convert number in any base (2 - 16) to decimal number
--	=============================================================


	create or replace function	garland.Convert_To_Decimal
						( in_digits varchar2, in_base number default 16)
			return	integer

AS	

	do_compile	integer := 0;

	base		integer		:= in_base;
	digits	varchar2(1000)	:= in_digits;

	digit		char;

	full_leng	integer;
	idx		integer;
	num		integer;
	code		integer;

begin

--	if	do_compile > 0		then
--		return;
--	end if;

	full_leng	:= length(digits);
	code		:= 00;
	idx		:= 00;

loop

	idx := idx + 01;
	exit when idx > full_leng;

	digit	:= substr(digits, idx, 1);

	select  decode (digit, 'A',10, 'B',11, 'C',12, 'D',13, 'E',14, 'F',15,  digit)
	into num	
	from dual;

	if	num >= base			then
		return  'Invalid digit ' || digit || ' for base ' || base;
	end if;

	code	:= (code * base) + num;

end loop;

--	dbms_output.put_line( digits ||' = '|| code );

	return	code;

end;
