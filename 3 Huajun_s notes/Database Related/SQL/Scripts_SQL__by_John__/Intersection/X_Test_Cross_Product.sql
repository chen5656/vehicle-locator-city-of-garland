
	set echo off;
	set serveroutput on;


declare

	x1	number	:= 0;
	y1	number	:= 0;

	x2	number	:= 0;
	y2	number	:= 0;

	cp	number	:= 0;

begin

	x1	:= 2;
	y1	:= 3;
	x2	:= 5;
	y2	:= 7;
	cp :=	(x1 * y2) - (x2 * y1);
	dbms_output.put_line ( '	' || x1 ||','|| y1 ||'    '|| x2 ||','|| y2 ||'     '||   cp );


	x1	:= 5;
	y1	:= 7;
	x2	:= 2;
	y2	:= 3;
	cp :=	(x1 * y2) - (x2 * y1);
	dbms_output.put_line ( '	' || x1 ||','|| y1 ||'    '|| x2 ||','|| y2 ||'     '||   cp );

end;
