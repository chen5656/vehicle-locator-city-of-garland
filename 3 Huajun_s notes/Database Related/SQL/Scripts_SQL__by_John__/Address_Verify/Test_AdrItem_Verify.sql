
	set echo		on;
	set serveroutput	on;


declare

	in_text		varchar2(20)		:= 'AVE';
	out_text		varchar2(20);


begin


	out_text := garland.adr_verify_street_type		(in_text);

--	out_text := garland.adr_verify_street_prefix	(in_text);

--	out_text := garland.adr_verify_unit_code		(in_text);




	dbms_output.put_line ('VERIFY:   ' || in_text ||' '|| out_text);

end;

