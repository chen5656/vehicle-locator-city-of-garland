
--	test adr_process_atreet_alias  function

	set	echo			off;
	set 	serveroutput	on;

declare

	start_seq		number	:= 0;
	stop_seq		number	:= 099;

	seq			number;

	addr_num		number;
	addr_pfx		varchar2(20);
	addr_name		varchar2(40);
	addr_type		varchar2(20);
	addr_sfx		varchar2(20);
	addr_code		varchar2(20);
	addr_unit		varchar2(20);


begin

	seq	:= start_seq - 01;

loop
	seq	:= seq + 01;	
	exit when	seq > stop_seq;

--	=========================================================================================================

--	AD HOC

	if	seq = 00	then 
		dbms_output.put_line (' ');
		dbms_output.put_line ('***  ad hoc  ***');
		goto	re_initialize;
	end if;

	if	seq is null	then null;

	elsif	seq = 01			then 
		addr_num	:= 1234;
		addr_pfx	:= 'E';
		addr_name	:= 'AVENUE ';
		addr_type	:= '';
		addr_sfx	:= '';
		addr_code	:= '';
		addr_unit	:= 'D';

	else
		goto	re_initialize;

	end if;

--	=========================================================================================================

	dbms_output.put_line ( ' ' );
	dbms_output.put_line (  'IN '|| '   ' 
					||'/'|| rpad(addr_num,05)
					||'/'|| rpad(nvl(addr_pfx,' '),02)	||'/'|| rpad(addr_name,25) 
					||'/'|| rpad(addr_type,06)		||'/'|| rpad(addr_sfx, 02)	
					||'/'|| rpad(addr_code,06)		||'/'|| rpad(addr_unit,05)	
					||'/');


	
--	ADR_resolve_unparsed_exit (addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_code, addr_unit);

	ADR_resolve_parsed_exit	  (addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_code, addr_unit);



	dbms_output.put_line ('OUT'  || '   '	
					||'/'|| rpad(addr_num,05)
					||'/'|| rpad(nvl(addr_pfx,' '),02)	||'/'|| rpad(addr_name,25) 
					||'/'|| rpad(addr_type,06)		||'/'|| rpad(addr_sfx, 02)	
					||'/'|| rpad(addr_code,06)		||'/'|| rpad(addr_unit,05)	
					||'			'|| seq );

--	=========================================================================================================

<<re_initialize>>

	addr_num	:= null;
	addr_pfx	:= '';
	addr_name	:= '';
	addr_type	:= '';
	addr_sfx	:= '';
	addr_code	:= '';
	addr_unit	:= '';

end loop;

end;

