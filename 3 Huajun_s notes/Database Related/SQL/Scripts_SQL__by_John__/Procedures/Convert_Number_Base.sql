	set echo on;
--	=====================================================================================


	create or replace function	garland.Convert_Number_Base
						( in_digits varchar2, in_base1 integer, in_base2 integer)
	return	varchar2

AS	

	do_compile	integer := 0;

	base1		integer		:= in_base1;
	base2		integer		:= in_base2;
	digits	varchar2(1000)	:= in_digits;


	dec		integer;
	num		varchar2(1000);


BEGIN

	dec	:= garland.convert_to_decimal 	(digits, base1);

	num	:= garland.convert_from_decimal	(dec,	base2);
	
	return	num;

END;

