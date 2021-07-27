	set serveroutput on;
--	===================================================================================
--	SQL Education necessary to decipher LONG RAW

--	Text ASCII = 32 - 126
--	===================================================================================

declare

	a	number;
	b	char(2);

	x	long;
	y	varchar2(32000);
	z	varchar2(32000);


begin

	select codedvalues	into Y 
	from	 sde.gdb_codeddomains where rownum < 2;

	x := y;

	z := rawtohex(y);

	dbms_output.put_line (z);
	dbms_output.put_line ( substr(z,100, 10) );

	a := ascii(chr(substr(y,1,2)));
	dbms_output.put_line (a);

	b := chr(substr(z,1,2));
	dbms_output.put_line (b);

end;
