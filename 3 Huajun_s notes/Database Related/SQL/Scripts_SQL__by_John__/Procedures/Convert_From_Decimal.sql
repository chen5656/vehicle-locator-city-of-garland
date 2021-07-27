	set echo 		off;
	set serveroutput	on;
--	===========================================================
--	Convert Decimal number to number in another base (2 - 16)
--	===========================================================

	create or replace function	garland.Convert_From_Decimal
						( in_dec number, in_base number default 16)
	return	varchar2

AS	

	do_compile	integer	:= 0;
	do_max	integer	:= 99;

--	in_dec	integer	:= 00;	-- decimal number
--	in_base	integer	:= 16;	-- other base

	dec		integer;
	base		integer;
	quo		integer;
	rem		integer;

	mesg		varchar2(1000);
	msg		char;

begin

--	if	do_compile > 0		then
--		return;
--	end if;


	base		:= in_base;
	dec		:= in_dec;
	mesg		:= null;

	if	in_base > 16		then
		return 'Number Base Too Big';
	end if;

loop

	quo	:= floor(dec / base);
	rem	:= mod  (dec,  base);

	if	rem > 9		then
		select decode (rem,  10,'A',  11,'B',  12,'C',  13,'D',  14,'E',  15,'F',  'x')
		into msg
		from dual;
	else
		msg	:= rem;
	end if;

	mesg		:= msg || mesg;

	dec		:= quo;
	exit when	dec = 0;

--	dbms_output.put_line (mesg);
--	do_max :=	do_max - 1;		-- safety check
--	exit when	do_max < 0;

end loop;

--	dbms_output.put_line ( in_dec ||' = '|| mesg );

	return mesg;

end;
