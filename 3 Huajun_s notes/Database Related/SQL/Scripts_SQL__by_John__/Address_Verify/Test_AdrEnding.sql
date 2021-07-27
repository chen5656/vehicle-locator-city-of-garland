	set echo 		off;
	set serveroutput	on;

declare

	in_name	varchar2(40)	:= 'brandywine';
	out_name	varchar2(40);

begin

	out_name := garland.TST_name_ending ( in_name );

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( in_name ||' '|| out_name );

end;