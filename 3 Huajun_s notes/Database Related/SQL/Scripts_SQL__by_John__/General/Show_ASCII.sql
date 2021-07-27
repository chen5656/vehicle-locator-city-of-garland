
--	build sql query to display keyboard characters in ascending collating order

	set echo		off;
	set serveroutput	on;


declare

begin

for x	in 0..128		loop

	dbms_output.put_line ( x ||' '|| chr(x) ); 

end loop;

end;
